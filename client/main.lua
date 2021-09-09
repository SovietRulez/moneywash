RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    playerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    playerJob = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    playerJob = JobInfo
end)

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    if not Config.JobRequired then
        while true do
            Citizen.Wait(5)
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            for washName, washData in pairs(Config.WashLocations) do
                local distance = #(coords - washData.coords)
                if distance <= 1 then
                    DrawText3D(washData.coords, "~r~ Wash Mulah")
                end
                if distance <= 1 and IsControlJustReleased(0, 38) then
                    local washAmount = LocalInput('Wash Amount', 255, '')
                    if washAmount ~= nil then
                        TriggerServerEvent('washMoney', tonumber(washAmount), washData)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.JobRequired then
        while true do
            Citizen.Wait(5)
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
			local PlayerData = QBCore.Functions.GetPlayerData()
            for washName, washData in pairs(Config.WashLocations) do
                local distance = #(coords - washData.coords)
                if distance <= 1 and PlayerData.job.name == Config.Job then
                    DrawText3D(washData.coords, "~r~ Wash Mulah")
                end
                if distance <= 1 and IsControlJustReleased(0, 38) then
                    local washAmount = LocalInput('Wash Amount', 255, '')
                    if washAmount ~= nil then
                        TriggerServerEvent('washMoney', tonumber(washAmount), washData)
                    end
                end
            end
        end
    end
end)

function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end

function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end
