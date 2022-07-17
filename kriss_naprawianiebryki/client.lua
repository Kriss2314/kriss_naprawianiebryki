ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)

local sraka = 450



local blipson = {
    {title=Config.TitleBlipu, colour=Config.KolorBlipu, id=Config.IkonkaBlipu, x = 1141.1, y = -777.91, z = 57.6},
 }

Citizen.CreateThread(function()
   for _, info in pairs(blipson) do
       info.blip = AddBlipForCoord(info.x,info.y,info.z)

       SetBlipSprite(info.blip, info.id)
       SetBlipDisplay(info.blip, 6)
       SetBlipScale(info.blip, 0.9)
       SetBlipColour(info.blip, info.colour)
       SetBlipAsShortRange(info.blip, true)
       BeginTextCommandSetBlipName("STRING")
       AddTextComponentString(info.title)
       EndTextCommandSetBlipName(info.blip)
   end
end)

Citizen.CreateThread(function()
    local ped = GetPlayerPed(-1)
    while true do 
      Citizen.Wait(0)
      local playerCoords = GetEntityCoords(ped)
      local distance = #(playerCoords - Config.Miejsce)
      local jestwmarkerze = false
      if distance < 100.0 then
        DrawMarker(Config.Marker, Config.Miejsce.x, Config.Miejsce.y, Config.Miejsce.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.WielkoscMarkeru, Config.WielkoscMarkeru, Config.WielkoscMarkeru, Config.kolor1, Config.kolor2, Config.kolor3, Config.JasnoscMarkeru, false, true, 2, nil, nil, false)
        if distance < 2.0 then
            jestwmarkerze = true
        end
      else
        Citizen.Wait(2000)
      end
      if jestwmarkerze then
        ESX.ShowHelpNotification(Config.helpnotifka)
        if IsControlPressed(0, 38) then
            twojstary()
        end
      end
    end
end)

CreateThread(function()
  while true do 
    local PlayerPed = ESX.PlayerData.ped 
    local PlayerCoords = GetEntityCoords(PlayerPed)

    ESX.Game.Utils.DrawText3D(Config.Napis, "[~b~Lokalny Mechanik~s~]!", 5.0, 1) 

    Wait(Sleep) 
  end
end)
  
function menunaprawy()

    local vehicle = ESX.Game.GetVehicleInDirection()

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "kriss_naprawianiebryki", {
        title = "Lokalny Mechanik", -- tytul esx_menu_default
        align = "right",  -- polozenie
        elements = { 
            {label = "Napraw Pojazd 5000$", value = "napraw1"},  -- element 1
        }
    }, function(data, menu) 
 

        if data.current.value == "napraw1" then -- element 1 
            TriggerServerEvent('kriss:fure')
            menu.close() 
        end
    end, function(data, menu)
        menu.close() 
    end)
end


function twojstary()

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        sraka = 500
        menunaprawy()
    else
        ESX.ShowNotification(Config.Niemozesz)
        sraka = 430
    end
end

RegisterNetEvent('kriss:naprawka', function()
    local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
    exports.rprogress:Custom({
        Duration = 60000,
        Label = "Naprawiasz pojazd...",
        DisableControls = {
            Mouse = false,
            Player = true,
            Vehicle = true
        }
    })

    for i = 4, 4 do
      SetVehicleDoorOpen(Vehicle, i, false, true) -- will open every door from 0-5

    Wait(60000)
    local Playerped = GetPlayerPed(-1)
    local Twojabryka = GetVehiclePedIsIn(Playerped, false)
        SetVehicleFixed(Twojabryka)
    end
end)

