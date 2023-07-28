$(function () {
    window.addEventListener('message', function (event) {
        var item = event.data;
        var health = new ldBar(".health", {
            "stroke": '#00FF0A',
            "stroke-width": 5,
            "stroke-trail-width": 5,
            "preset": "circle",
            "stroke-trail": "#00000090",
            "value": 50
        });
        var health2 = new ldBar(".health-inside", {
            "stroke": '#00FF0A',
            "stroke-width": 50,
            "stroke-trail-width": 50,
            "preset": "circle",
            "stroke-trail": "#00000000",
            "value": 25
        });
        health.set(item.health)
        health2.set(item.health)
        var armor = new ldBar(".armor", {
            "stroke": '#0047FF',
            "stroke-width": 5,
            "stroke-trail-width": 5,
            "preset": "circle",
            "stroke-trail": "#00000090",
            "value": 20
        });
        var armor2 = new ldBar(".armor-inside", {
            "stroke": '#0047FF',
            "stroke-width": 50,
            "stroke-trail-width": 50,
            "preset": "circle",
            "stroke-trail": "#00000000",
            "value": 25
        });
        armor.set(item.armor)
        armor2.set(item.armor)
        var hunger = new ldBar(".hunger", {
            "stroke": '#FF7A00',
            "stroke-width": 5,
            "stroke-trail-width": 5,
            "preset": "circle",
            "stroke-trail": "#00000090",
            "value": 20
        });
        var hunger2 = new ldBar(".hunger-inside", {
            "stroke": '#FF7A00',
            "stroke-width": 50,
            "stroke-trail-width": 50,
            "preset": "circle",
            "stroke-trail": "#00000000",
            "value": 25
        });
        hunger.set(item.hunger)
        hunger2.set(item.hunger)
        var thirst = new ldBar(".thirst", {
            "stroke": '#00A3FF',
            "stroke-width": 5,
            "stroke-trail-width": 5,
            "preset": "circle",
            "stroke-trail": "#00000090",
            "value": 20
        });
        var thirst2 = new ldBar(".thirst-inside", {
            "stroke": '#00A3FF',
            "stroke-width": 50,
            "stroke-trail-width": 50,
            "preset": "circle",
            "stroke-trail": "#00000000",
            "value": 25
        });
        thirst.set(item.thirst)
        thirst2.set(item.thirst)
        //asdsad
        var mic = new ldBar(".mic", {
            "stroke": '#8000FF',
            "stroke-width": 5,
            "stroke-trail-width": 5,
            "preset": "circle",
            "stroke-trail": "#00000090",
            "value": 33
        });
        var mic2 = new ldBar(".mic-inside", {
            "stroke": '#8000FF',
            "stroke-width": 50,
            "stroke-trail-width": 50,
            "preset": "circle",
            "stroke-trail": "#00000000",
            "value": 33
        });
    })
})

window.addEventListener("message", function (event) {
    var vehicle = event.data;
    switch (vehicle.carhud) {
        case 'arabada':
            $('.vehicle-wrapper').css({ 'display': `block` })
            $(".speed").text(vehicle.speed);
            $(".fuel-inside").css("width", vehicle.fuel)
            if (vehicle.fuel >= 66){
                $(".fuel-inside").css("background-color", "#10D15A")
            } else if(vehicle.fuel >= 33){
                $(".fuel-inside").css("background-color", "yellow")
            } else {
                $(".fuel-inside").css("background-color", "red")
            }
            if (vehicle.percent <= 100) {
                setProgress(vehicle.percent)
            } else {
                setProgress(100)
            }
            break
        case 'indi':
            $('.vehicle-wrapper').css({ 'display': `none` })
            break
    }
});

// $('.vehicle-wrapper').css({ 'display': `block` })
// $(".speed").text(vehicle.speed);

window.addEventListener('message', (event) => {
    let item = event.data;
    if (item.type === 'open2') {
        var ammo = new ldBar(".ammo", {
            "stroke": '#FF002E',
            "stroke-width": 5,
            "stroke-trail-width": 5,
            "preset": "circle",
            "stroke-trail": "#00000060",
            "max": (item.maxammo),
            "value": (item.gunammo)
        });
        var ammo2 = new ldBar(".ammo-inside", {
            "stroke": '#FF002E',
            "stroke-width": 50,
            "stroke-trail-width": 50,
            "preset": "circle",
            "stroke-trail": "#00000000",
            "max": (item.maxammo),
            "value": (item.gunammo)
        });
        ammo.set(item.gunammo)
        ammo2.set(item.gunammo)
        $(".gun-ammo").text(`${item.gunammo}`);
        $("#playerId").text("PLAYER ID :  " + `${item.pid}`);
    }

    if (item.type == "updateMoney"){
        switch(item.account){
            case 'black_money':
                $("#black_money").text("💸 " + nf.format(item.money).replace(".00", ""));
                break;
            case 'money':
                $("#cash").text("💵 " + nf.format(item.money).replace(".00", ""));
                break;
            case 'bank':
                $("#bank").text("🏛️ " + nf.format(item.money).replace(".00", ""));
                break;
        } 
    }

    if (item.type === "updateDetails") {
        $("#cash").text("💵 " + nf.format(item.cash).replace(".00", ""));
        $("#bank").text("🏛️ " + nf.format(item.bank).replace(".00", ""));
        $("#black_money").text("💸 " + nf.format(item.black_money).replace(".00", ""));
    }
})

const nf = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
    maximumFractionDigits: 2,
    roundingIncrement: 5,
});

window.addEventListener('message', (event) => {
    const data = event.data
    switch (data.action) {
        case "speak":
            if (data.active) {
                $(".mic path.mainline").css({ 'stroke': `#760015` })
                $(".mic-inside path.mainline").css({ 'stroke': `#760015` })
            } else {
                $(".mic-inside path.mainline").css({ 'stroke': `#FF002E` })
            }
            break;
        case "voice":

            if (data.lvl == 1) {
                var mic = new ldBar(".mic", {
                    "stroke": '#FFF',
                    "stroke-width": 5,
                    "stroke-trail-width": 5,
                    "preset": "circle",
                    "stroke-trail": "#00000060",
                    "value": 33
                });
                var mic2 = new ldBar(".mic-inside", {
                    "stroke": '#00000060',
                    "stroke-width": 50,
                    "stroke-trail-width": 50,
                    "preset": "circle",
                    "stroke-trail": "#8000FF",
                    "value": 33
                });
                mic2.set(33)
                mic.set(33)
            } else if (data.lvl == 2) {
                var mic = new ldBar(".mic", {
                    "stroke": '#FFF',
                    "stroke-width": 5,
                    "stroke-trail-width": 5,
                    "preset": "circle",
                    "stroke-trail": "#00000060",
                    "value": 66
                });
                var mic2 = new ldBar(".mic-inside", {
                    "stroke": '#00000060',
                    "stroke-width": 50,
                    "stroke-trail-width": 50,
                    "preset": "circle",
                    "stroke-trail": "#8000FF",
                    "value": 66
                });
                mic2.set(66)
                mic.set(66)
            } else if (data.lvl == 3) {
                var mic = new ldBar(".mic", {
                    "stroke": '#FFF',
                    "stroke-width": 5,
                    "stroke-trail-width": 5,
                    "preset": "circle",
                    "stroke-trail": "#00000060",
                    "value": 100
                });
                var mic2 = new ldBar(".mic-inside", {
                    "stroke": '#00000060',
                    "stroke-width": 50,
                    "stroke-trail-width": 50,
                    "preset": "circle",
                    "stroke-trail": "#8000FF",
                    "value": 100
                });
                mic2.set(100)
                mic.set(100)
            }
            break;
    }
});
lastPercent = 0
function setProgress(perc) {
    var $bar = $(".bar"); 
    $({ p: lastPercent }).animate({ p: perc }, {
        duration: 3000,
        easing: "swing",
        step: function (p) {
            $bar.css({
                transform: "rotate(" + (45 + (p * 1.8)) + "deg)", // 100%=180° so: ° = % * 1.8
                // 45 is to add the needed rotation to have the green borders at the bottom
            });
        }
    });
    lastPercent = perc
};
