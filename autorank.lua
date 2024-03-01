function autoRank(typeOfGoal,goalIndex)

	if typeOfGoal == 1 then
		-- any breakable
		tp(getLastAreaIndex())
		repeat task.wait() until SaveFile.Goals[tostring(goalIndex)]["Type"] ~= typeOfGoal
	elseif typeOfGoal == 2 then
		-- pet?
	elseif typeOfGoal == 3 then
		-- egg?
	elseif typeOfGoal == 4 then
		-- gold pets
		-- need to get remote
		-- CFrame.new(158.15,16.56,13.742)
	elseif typeOfGoal == 5 then
		-- rainbow pets
		-- CFrame.new(336.45,16.58,1317.09)
	elseif typeOfGoal == 6 then
		tp(getLastAreaIndex())
        repeat task.wait() until buyZone(getLastAreaIndex()) == true
    elseif typeOfGoal == 8 then
        tp(getLastAreaIndex())
        repeat task.wait() until SaveFile.Goals[tostring(goalIndex)]["Type"] ~= typeOfGoal
    elseif typeOfGoal == 9 then
        -- diamond breakables
        tp(getLastAreaIndex())
        repeat task.wait() until SaveFile.Goals[tostring(goalIndex)]["Type"] ~= typeOfGoal
    elseif typeOfGoal == 10 then
        -- Code for typeOfGoal 10
    elseif typeOfGoal == 11 then
        -- Code for typeOfGoal 11
    elseif typeOfGoal == 12 then
        -- Code for typeOfGoal 12
    elseif typeOfGoal == 13 then
        -- Code for typeOfGoal 13
    elseif typeOfGoal == 14 then
        -- Code for typeOfGoal 14
    elseif typeOfGoal == 15 then
        -- Code for typeOfGoal 15
    elseif typeOfGoal == 16 then
        -- Code for typeOfGoal 16
    elseif typeOfGoal == 17 then
        -- Code for typeOfGoal 17
    elseif typeOfGoal == 18 then
        -- Code for typeOfGoal 18
    elseif typeOfGoal == 19 then
        -- Code for typeOfGoal 19
    elseif typeOfGoal == 20 then
        -- Code for typeOfGoal 20
    elseif typeOfGoal == 21 then
        -- Code for typeOfGoal 21
    elseif typeOfGoal == 22 then
        -- Code for typeOfGoal 22
    elseif typeOfGoal == 23 then
        -- Code for typeOfGoal 23
    elseif typeOfGoal == 24 then
        -- Code for typeOfGoal 24
    elseif typeOfGoal == 25 then
        -- Code for typeOfGoal 25
    elseif typeOfGoal == 26 then
        -- Code for typeOfGoal 26
    elseif typeOfGoal == 27 then
        -- Code for typeOfGoal 27
    elseif typeOfGoal == 28 then
        -- Code for typeOfGoal 28
    elseif typeOfGoal == 29 then
        -- Code for typeOfGoal 29
    elseif typeOfGoal == 30 then
        -- Code for typeOfGoal 30
    elseif typeOfGoal == 31 then
        -- Code for typeOfGoal 31
    elseif typeOfGoal == 32 then
        -- Code for typeOfGoal 32
    elseif typeOfGoal == 33 then
        -- Code for typeOfGoal 33
    elseif typeOfGoal == 34 then
        -- Code for typeOfGoal 34
    elseif typeOfGoal == 35 then
        -- Code for typeOfGoal 35
    elseif typeOfGoal == 36 then
        -- Code for typeOfGoal 36
    elseif typeOfGoal == 37 then
        -- Code for typeOfGoal 37
    elseif typeOfGoal == 38 then
        -- Code for typeOfGoal 38
    elseif typeOfGoal == 39 then
        -- Code for typeOfGoal 39
    elseif typeOfGoal == 40 then
        -- Code for typeOfGoal 40
    elseif typeOfGoal == 41 then
        -- Code for typeOfGoal 41
    elseif typeOfGoal == 42 then
        -- Code for typeOfGoal 42
    end

end