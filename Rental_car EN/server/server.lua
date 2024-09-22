RegisterNetEvent('my_car_rental:rentCar', function(car)
    local xPlayer = source

    local money = exports.ox_inventory:Search(xPlayer, 'count', 'money')
    if money >= car.price then
        exports.ox_inventory:RemoveItem(xPlayer, 'money', car.price)

        TriggerClientEvent('my_car_rental:spawnVehicle', xPlayer, car.model)

        TriggerClientEvent('ox_lib:notify', xPlayer, {
            title = 'Car rental',
            description = 'You borrowed ' .. car.label .. ' for ' .. car.price .. '$',
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', xPlayer, {
            title = 'Car rental',
            description = 'You not have enough money',
            type = 'error'
        })
    end
end)
