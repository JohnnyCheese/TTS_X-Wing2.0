-------------------------------------------------------------
--- Original Script and Art by Joshmoe554---------------------
-------------------------------------------------------------

-- Check if this is a crit token and destroy it.  Nice way to return
-- tokens that have been updated since leaving the container.
function onCollisionEnter(collisionInfo)
    local obj = collisionInfo.collision_object
    local dmgToken = obj.getVar("IsCritToken")

    if dmgToken ~= nil then
        obj.destruct()
    end
end
