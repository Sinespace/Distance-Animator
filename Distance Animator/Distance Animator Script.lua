
myObj = Space.Host.ExecutingObject
myPlayer = Space.Scene.PlayerAvatar

maxDist = maxDist or 1.0
minDist = minDist or 0.1
stateName = stateName or "Distance"
normalized = normalized or false
networked = networked or false

animationObj = myObj
if Space.Host.ReferenceExistsAndNotEmpty("Animator") then
    animationObj = Space.Host.GetReference("Animator")
end

targetObj = animationObj
if Space.Host.ReferenceExistsAndNotEmpty("Target") then
    targetObj = Space.Host.GetReference("Target")
end

lastDist = nil

function onUpdate()
    if liveRoomEditing == true then
        lastDist = 0
    else
        lastDist = targetObj.WorldPosition.Distance(myPlayer.GameObject.WorldPosition) - minDist
        if lastDist >= maxDist then
            lastDist = maxDist
        elseif lastDist < 0 then
            lastDist = 0
        end
    end
    if normalized then
        animationObj.Animator.Play(stateName, 0, (maxDist - lastDist) / maxDist)
    else
        animationObj.Animator.PlayInFixedTime(stateName, 0, maxDist - lastDist)
    end
end

myObj.OnUpdate(onUpdate)

if initLiveRoomEditing ~= nil then
    initLiveRoomEditing()
end
