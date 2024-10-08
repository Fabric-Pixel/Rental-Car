local cars = {
    {model = 'asea', price = 500, label = "asea"},
    {model = 'Baller', price = 900, label = "Baller "},
    {model = 'stanier', price = 300, label = "Stanier"},
    {model = 'primo', price = 200, label = "primo"},
    {model = 'bmx', price = 50, label = "BMX"}
}

local rentalLocation = vector3(111.3753, -1482.8256, 29.2612)
local npcModel = 'a_m_m_business_01'


CreateThread(function()
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(100)
    end

    local npc = CreatePed(4, npcModel, rentalLocation.x, rentalLocation.y, rentalLocation.z - 1, 0.0, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)


    local blip = AddBlipForCoord(rentalLocation)
    SetBlipSprite(blip, 225)   
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Wypożyczalnia aut")
    EndTextCommandSetBlipName(blip)

    exports.ox_target:addLocalEntity(npc, {
        {
            name = 'car_rental',
            label = 'Wypożycz auto',
            icon = 'fa-solid fa-car',
            canInteract = function(entity, distance, coords, name)
                return distance < 3
            end,
            onSelect = function()
                openCarRentalMenu()
            end
        }
    })
end)

function openCarRentalMenu()
    local options = {}
    for _, car in ipairs(cars) do
        table.insert(options, {
            title = car.label,
            description = string.format('Cena: %d$', car.price),
            icon = 'fa-solid fa-car',
            onSelect = function()
                TriggerServerEvent('my_car_rental:rentCar', car)
            end
        })
    end

    lib.registerContext({
        id = 'car_rental_menu',
        title = 'Wypożyczalnia aut',
        options = options
    })

    lib.showContext('car_rental_menu')
end

RegisterNetEvent('my_car_rental:spawnVehicle', function(model)
    lib.requestModel(model)

    local spawnCoords = vector3(115.6392, -1483.8854, 29.1416)   
    local heading = 319.8713   

    local vehicle = CreateVehicle(GetHashKey(model), spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    TriggerServerEvent('idev_keys:giveKey', GetVehicleNumberPlateText(vehicle))
end)
