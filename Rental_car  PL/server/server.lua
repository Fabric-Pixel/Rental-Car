-- Event odpowiedzialny za wypożyczenie auta
RegisterNetEvent('my_car_rental:rentCar', function(car)
    local xPlayer = source

    local money = exports.ox_inventory:Search(xPlayer, 'count', 'money')
    if money >= car.price then
        exports.ox_inventory:RemoveItem(xPlayer, 'money', car.price)

        TriggerClientEvent('my_car_rental:spawnVehicle', xPlayer, car.model)

        TriggerClientEvent('ox_lib:notify', xPlayer, {
            title = 'Wypożyczalnia aut',
            description = 'Wypożyczyłeś ' .. car.label .. ' za ' .. car.price .. '$',
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', xPlayer, {
            title = 'Wypożyczalnia aut',
            description = 'Nie masz wystarczającej ilości pieniędzy!',
            type = 'error'
        })
    end
end)
