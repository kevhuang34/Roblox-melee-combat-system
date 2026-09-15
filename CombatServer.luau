Debris = game:GetService("Debris")
local Players = game:GetService("Players")


function TagHumanoid(humanoid, plr)
	local creatorTag = Instance.new("ObjectValue")
	creatorTag.Name = "player"
	creatorTag.Value = plr
	Debris:AddItem(creatorTag, 2)
	creatorTag.Parent = humanoid
end


function UntagHumanoid(humanoid)
	for i, v in pairs(humanoid:GetChildren()) do
		if v:IsA("ObjectValue") and v.Name == "player" then
			v:Destroy()
		end
	end
end


function IsPlayer(Player1, Player2)
	return (Player1 and Player2)
end


game.ReplicatedStorage.Punching.CombatHit.OnServerEvent:Connect(function(plr) --takes data from the client(Combat Skill) and moved it back to serverscriptservice
	
	task.wait(1)
	local hitbox = Instance.new("Part")
	hitbox.Parent = workspace
	hitbox.Anchored = true
	hitbox.CanCollide = false
	hitbox.Transparency = 1
	hitbox.Size = Vector3.new(3,3,5)
	hitbox.CFrame = plr.Character.HumanoidRootPart.CFrame*CFrame.new(1,0,-2) --Location of where hitbox is relative to you
	game.Debris:AddItem(hitbox,0.1) --Destroy hitbox 
	
	
	local hit = {}
	local touchingParts = workspace:GetPartsInPart(hitbox)
	
	
	for _, part in touchingParts do
		local eHum = part.Parent:FindFirstChild("Humanoid")
		if eHum and eHum.Parent.Name ~= plr.Name and not hit[eHum] then
			local player = game.Players:FindFirstChild(part.Parent.Name)
			if hit[eHum.Parent.Name] or player and (player == plr or IsPlayer(plr, player)) then
				return
			end

			hit[eHum] = true
			UntagHumanoid(eHum)
			TagHumanoid(eHum, plr)
			eHum:TakeDamage(20)
		end
	end
end)

game.ReplicatedStorage.Punching.SpecialHit.OnServerEvent:Connect(function(plr) --takes data from the client(Combat Skill) and moved it back to serverscriptservice
	local chargeEffect = game.ReplicatedStorage.Punching.Effect:Clone()
	chargeEffect.Parent = workspace
	chargeEffect.Anchored = true
	chargeEffect.CanCollide = false
	chargeEffect.Transparency = 1
	chargeEffect.Size = Vector3.new(1,1,1)
	chargeEffect.CFrame = plr.Character.HumanoidRootPart.CFrame*CFrame.new(1,0,0)
	game.Debris:AddItem(chargeEffect,2.5)

	task.wait(2.5)
	
	local hitbox = game.ReplicatedStorage.Punching.UltraPunchEffect:Clone()
	local realHitbox = Instance.new("Part")
	hitbox.Parent = workspace
	realHitbox.Parent = workspace
	hitbox.Anchored = true
	realHitbox.Anchored = true
	hitbox.CanCollide = false
	realHitbox.CanCollide = false
	hitbox.Transparency = 0.4
	realHitbox.Transparency = 1
	hitbox.Size = Vector3.new(80,50,50)
	realHitbox.Size = Vector3.new(80,34,34)
	hitbox.CFrame = plr.Character.HumanoidRootPart.CFrame*CFrame.Angles(0, math.rad(267),math.rad(357))*CFrame.new(-42,0,0) --Location of where hitbox is relative to you
	realHitbox.CFrame = plr.Character.HumanoidRootPart.CFrame*CFrame.Angles(0, math.rad(90),0)*CFrame.new(42,0,0)
	game.Debris:AddItem(hitbox,2) --Destroy hitbox 
	game.Debris:AddItem(realHitbox,0.1)


	local hit = {}
	local touchingParts = workspace:GetPartsInPart(realHitbox)


	for _, part in touchingParts do
	local enemyHumanoid = part.Parent:FindFirstChild("Humanoid")

	if enemyHumanoid and enemyHumanoid.Parent.Name ~= plr.Name and not hit[enemyHumanoid] then
		local targetPlayer = Players:GetPlayerFromCharacter(enemyHumanoid.Parent)

		if targetPlayer then
			continue
		end

		hit[enemyHumanoid] = true
		UntagHumanoid(enemyHumanoid)
		TagHumanoid(enemyHumanoid, plr)
		enemyHumanoid:TakeDamage(200)
	end
end
end)