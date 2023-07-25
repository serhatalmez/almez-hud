local armor
local health
local HunVal = 0
local ThiVal = 0
local StaVal = 100
local speak = false
ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300) -- düştükçe daha hızlı tepki verir
        local person = PlayerPedId()
        if IsPedInAnyVehicle(person) then
            local veh = GetVehiclePedIsIn(ped, false);
            local ped = PlayerPedId()
            local car = GetVehiclePedIsUsing(person)
            local hiz = math.ceil(GetEntitySpeed(car) * 2.236936)
            local rpm = GetVehicleCurrentRpm(car)
            local weaponname = GetLabelText(wep)
            SendNUIMessage({
                carhud = 'arabada';
                speed = hiz;
                fuel = exports["LegacyFuel"]:GetFuel(car),
                percent = (hiz / 180) * 100;
            })
        else
            SendNUIMessage({
                carhud = 'indi';
            })
        end
    end
end)

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(500)
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            HunVal = status.val / 1000000 * 100
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            ThiVal = status.val / 1000000 * 100
        end)
        TriggerEvent('esx_status:getStatus', 'health', function(status)
            hp = status.val / 1000000 * 100
        end)
        TriggerEvent('esx_status:getStatus', 'stamina', function(status)
            local StaVal = GetPlayerSprintStaminaRemaining(PlayerId())
            StaVal = status.val / 1000000 * 100
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(800)
        playerPed = PlayerPedId()
        hp = GetEntityHealth(playerPed)
        local StaVal = GetPlayerSprintTimeRemaining(PlayerId()) * 10
        if hp == 175 then
            hp = 200
            SetEntityHealth(playerPed, 200)

        end
        if Config.ReCharge then
            SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
        else
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        end
        SendNUIMessage({
            health = hp - 100,
            armor = GetPedArmour(playerPed),
            hunger = HunVal,
            thirst = ThiVal,
            stamina = StaVal,
        })
    end
end)

RegisterNetEvent('esx_gangs:UpdateClient')
AddEventHandler('esx_gangs:UpdateClient', function()
    ESX.TriggerServerCallback('almez-hud:GetPlayerDetails', function(cb)
        SendNUIMessage(cb)
    end, "esx_gangs:UpdateClient")
end)
playerSociety = nil
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.TriggerServerCallback('almez-hud:GetPlayerDetails', function(cb)
        SendNUIMessage(cb)
        playerSociety = cb.society
    end, 'esx:playerLoaded')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function()
    ESX.TriggerServerCallback('almez-hud:GetPlayerDetails', function(cb)
        SendNUIMessage(cb)
        playerSociety = cb.society
    end, "esx:setJob")
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    SendNUIMessage({
        type = "updateMoney",
        account = account.name,
        money = account.money
    })
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
    --print(society, money, playerSociety)
    if playerSociety == society then
        SendNUIMessage({
            type = "updateAccountMoney",
            money = money
        })
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local status = NetworkIsPlayerTalking(PlayerId())
        if status and not speak then
            speak = true
            SendNUIMessage({ action = 'speak', active = true })
        elseif not status and speak then
            speak = false
            SendNUIMessage({ action = 'speak', active = false })
        end
    end
end)

RegisterNetEvent('pma-voice:setTalkingMode')
AddEventHandler('pma-voice:setTalkingMode', function(lvl)
    SendNUIMessage({ action = 'voice', lvl = tostring(lvl) })
end)

Citizen.CreateThread(function()
    while true do
        local ped        = PlayerPedId();
        local wep        = GetSelectedPedWeapon(ped);
        local bool, ammo = GetAmmoInClip(ped, wep);
        local maxAmmo    = GetMaxAmmoInClip(ped, wep)
        local player     = PlayerId()
        local pid        = GetPlayerServerId(player)
        SendNUIMessage({
            type = 'open2',
            gunammo = ammo,
            maxammo = maxAmmo,
            pid = pid,
        })
        Citizen.Wait(250);
    end
end)
