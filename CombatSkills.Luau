local plr = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local mouse = plr:GetMouse()


local debounce = false
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then
		return
	end
	if input.KeyCode == Enum.KeyCode.E then
		if debounce == true then
			return 
		end
		debounce = true
		game.ReplicatedStorage.Punching.CombatHit:FireServer() -- Fire the server from the client
		local simplePunch = plr.Character.Humanoid:LoadAnimation(script.SimplePunch)
		simplePunch:Play()
		task.wait(2)
		debounce = false
	end
	
	if input.KeyCode == Enum.KeyCode.R then
		if debounce == true then
			return 
		end
		debounce = true
		local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
		controls:Disable()
		game.ReplicatedStorage.Punching.SpecialHit:FireServer()
		local ultraChargeSound = script.ChargeUltra:Clone()
		ultraChargeSound.Parent = plr.Character
		ultraChargeSound:Play()
		game.Debris:AddItem(ultraChargeSound,2.5)
		local ultraPunch = plr.Character.Humanoid:LoadAnimation(script.UltraPunch)
		ultraPunch:Play()
		task.wait(2)
		controls:Enable()
		local blastSound = script.WindBust:Clone()
		blastSound.Parent = plr.Character
		blastSound:Play()
		game.Debris:AddItem(blastSound,3)
		task.wait(2)
		
		debounce = false
	end
	
end)
