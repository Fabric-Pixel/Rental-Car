-- Lista dostępnych aut do wypożyczenia
local cars = {
    {model = 'dilettantedx', price = 500, label = "Dilettante DX"},
    {model = 'ssg_ballerstd', price = 900, label = "SSG Baller STD"},
    {model = 'stanier', price = 300, label = "Stanier"},
    {model = 'odyssey', price = 200, label = "Odyssey"},
    {model = 'bmx', price = 50, label = "BMX"}
}

-- Lokalizacja NPC (południowe Los Santos)
local rentalLocation = vector3(111.3753, -1482.8256, 29.2612)
local npcModel = 'a_m_m_business_01'

-- Tworzenie NPC
CreateThread(function()
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(100)
    end

    local npc = CreatePed(4, npcModel, rentalLocation.x, rentalLocation.y, rentalLocation.z - 1, 0.0, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    -- Ustawianie blipu na mapie
    local blip = AddBlipForCoord(rentalLocation)
    SetBlipSprite(blip, 225) -- Ikona auta
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Wypożyczalnia aut")
    EndTextCommandSetBlipName(blip)

    -- Dodanie interakcji do NPC z ox_target
    exports.ox_target:addLocalEntity(npc, {
        {
            name = 'car_rental',
            label = 'Rent a car',
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

-- Funkcja otwierająca menu wyboru auta
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
        title = 'Rent a car',
        options = options
    })

    lib.showContext('car_rental_menu')
end

-- Event do spawnowania pojazdu
RegisterNetEvent('my_car_rental:spawnVehicle', function(model)
    lib.requestModel(model)

    -- Ustaw koordynaty spawn pojazdu
    local spawnCoords = vector3(115.6392, -1483.8854, 29.1416) -- Twoje koordynaty
    local heading = 319.8713 -- Kąt obrotu

    local vehicle = CreateVehicle(GetHashKey(model), spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

end)