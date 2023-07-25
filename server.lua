ESX = exports['es_extended']:getSharedObject()

local eventHandlerCounter = {}

ESX.RegisterServerCallback('almez-hud:GetPlayerDetails', function(source, cb, eventHandler)
    local src = source 
    local player = ESX.GetPlayerFromId(src)
    local gangText = false
    local societyMoney = false
    local society = false
    if not eventHandlerCounter[eventHandler] then
        eventHandlerCounter[eventHandler] = 0
    else
        eventHandlerCounter[eventHandler] = eventHandlerCounter[eventHandler] + 1
    end
    if player then
        local playerQuery = MySQL.Sync.fetchAll('SELECT gang, gang_rank FROM users WHERE identifier = ?', {player.identifier})
        local gang = playerQuery[1].gang
        local rank = playerQuery[1].gang_rank
        if gang and rank then
            local labelQuery = MySQL.Sync.fetchAll('SELECT label FROM gangs WHERE name = ?', {gang})
            local gradelabelQuery = MySQL.Sync.fetchAll('SELECT label FROM gang_ranks WHERE ranking = ? AND gang_name = ? ', {tonumber(rank), gang})
            if labelQuery[1] then 
                if labelQuery[1].label and gradelabelQuery[1].label then
                    gangText = labelQuery[1].label .. " - " .. gradelabelQuery[1].label
                end
            end
        end
        local playerJob = player.getJob()
        if playerJob.grade_name == "boss" then
            society = "society_" .. playerJob.name
            local societyQuery = MySQL.Sync.fetchAll("SELECT account_name, money FROM addon_account_data WHERE addon_account_data.account_name = ?",{society})
          --  print(json.encode(societyQuery[1]))
            societyMoney = societyQuery[1].money
        end
        Wait(500)
        cb({
            type = "updateDetails",
            cash = player.getMoney(),
            bank = player.getAccount('bank').money,
            black_money = player.getAccount('black_money').money,
            job = playerJob.label .. " - " .. playerJob.grade_label,
            job_money = societyMoney,
            gang = gangText,
            society = society
        })
    else
        cb(false)
    end
end)

RegisterCommand('buildcounter', function(src)
    if src == 0 then 
       -- print(json.encode(eventHandlerCounter))
    end
end)