RegisterServerEvent('washMoney')
AddEventHandler('washMoney', function(washAmount, washData)
    local src = source
    local plyLoc = GetEntityCoords(GetPlayerPed(src))
    local spotLoc = #(washData.coords - plyLoc)
    local Player = QBCore.Functions.GetPlayer(src)
    if spotLoc > 2 then ---- IF YOU ADJUST DISTANCE IN CLIENT, ADJUST HERE OR NORMAL PLAYERS WILL GET KICKED
        DropPlayer(src, "Cheaters are not welcome here")
	end
        if spotLoc < 1 then
            if Player.Functions.GetItemByName("markedbills") ~= nil and
                Player.Functions.GetItemByName('markedbills').amount >= washAmount then
                TriggerClientEvent("QBCore:Notify", src, string.format("you have washed %s marked bills", washAmount),"success", 5000)
                Player.Functions.AddMoney('cash', washAmount * Config.Value)
                Player.Functions.RemoveItem('markedbills', washAmount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "removed")
            else
                TriggerClientEvent("QBCore:Notify", src, string.format("Who you trying to fool?!"), "error", 5000)
            end
    end
end)

