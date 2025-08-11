--Preparing everything for render
models.scarlet_king.root:setVisible(false)
models.scarlet_king.root.Rune:setVisible(false)
models.scarlet_king.transformationResources:setVisible(false)
models.scarlet_king.HUD:setVisible(false)

--[action wheel, dependency, Boolean]
local magicPage = action_wheel:newPage(Transformation)
local runeToggle = magicPage:newAction()
local transformationToggle = magicPage:newAction()
local quickAnimation = magicPage:newAction()
require("GSAnimBlend")
animations.scarlet_king.walkingAnim:setBlendTime(4)
animations.scarlet_king.standingAnim:setBlendTime(4)
animations.scarlet_king.crouchingAnim:setBlendTime(3)

local isTransformed = false

--[Rune, Transformation, animations, custom attack(?)]
function pings.runeToggleF(state)
	models.scarlet_king.root.Rune:setVisible(state)
end

function pings.transformationToggleF(state)
    models.scarlet_king.transformationResources:setVisible(not state)
    animations.scarlet_king.getChainedLol:setPlaying(not state)
	if state == true then
		models.scarlet_king.HUD:setScale(client.getScaledWindowSize():augmented(1))
		models.scarlet_king.root:setVisible(true)
		vanilla_model.PLAYER:setVisible(not true)
		vanilla_model.ELYTRA:setVisible(not true)
		vanilla_model.ARMOR:setVisible(not true)
		vanilla_model.HELMET_ITEM:setVisible(not true)
		vanilla_model.CAPE:setVisible(not true)
		models.scarlet_king.HUD:setVisible(true)
		animations.scarlet_king.standingAnim:setPlaying(not crouching and not walking)
		animations.scarlet_king.walkingAnim:setPlaying(not crouching and walking)
		animations.scarlet_king.crouchingAnim:setPlaying(crouching and not walking)
		renderer:offsetCameraPivot(0,0.2,0)
        elseif state == false then
        models.scarlet_king.transformationResources:setVisible(false)
        models.scarlet_king.root:setVisible(state)
        vanilla_model.PLAYER:setVisible(not state)
        vanilla_model.ELYTRA:setVisible(not state)
        vanilla_model.ARMOR:setVisible(not state)
        vanilla_model.HELMET_ITEM:setVisible(not state)
        vanilla_model.CAPE:setVisible(not state)
        models.scarlet_king.HUD:setVisible(state)
        renderer:offsetCameraPivot(0,0,0)
        nameplate.ALL:setText("[${name}]")
        end
end

function pings.quickAnimationF()
    models.scarlet_king.transformationResources:setVisible(true)
    animations.scarlet_king.getChainedLol:setPlaying(true)
end

function events.tick()
	local crouching = player:getPose() == "CROUCHING"
	local sprinting = player:isSprinting()
	local blocking = player:isBlocking()
	local fishing = player:isFishing()
	local sleeping = player:getPose() == "SLEEPING"
	local swimming = player:getPose() == "SWIMMING"
	local flying = player:getPose() == "FALL_FLYING"
	local walking = player:getVelocity().xz:length() > .01
	nameplate.ALL:setText("§4§nScarlet king [${name}]")
end

--Further setup of the actions
runeToggle:setOnToggle(pings.runeToggleF)
transformationToggle:setOnToggle(pings.transformationToggleF)
quickAnimation:setOnLeftClick(pings.quickAnimationF)

runeToggle:setItem("minecraft:enchanting_table")
transformationToggle:setItem("minecraft:diamond")
quickAnimation:setItem("minecraft:coal")

action_wheel:setPage(magicPage)

print("Model loaded! updated")

--todo: punching animation