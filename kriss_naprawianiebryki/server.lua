ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('kriss:fure')
AddEventHandler('kriss:fure', function()
    local xPlayer = ESX.GetPlayerFromId(source) 
    local PlayerMoney = xPlayer.getMoney() 

    if PlayerMoney >= Config.KosztPojazd then 
        xPlayer.removeMoney(Config.KosztPojazd)
        xPlayer.triggerEvent('kriss:naprawka') 
    else 
        xPlayer.showNotification(Config.Niestac)
 end
end)
