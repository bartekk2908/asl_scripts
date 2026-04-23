state("MotionRec")
{
	byte roomID : 0x9FC414;
	float x: 0xA0A430, 0x8, 0xF4;
	float y: 0xA0A430, 0x8, 0xF8;
	byte playButtonFlag: 0x741A70, 0x120, 0x170, 0xA5C;
}

startup
{
	settings.Add("oldVersion", false, "Old Version (v1.02)");
    settings.SetToolTip("oldVersion", "Set True if playing on version v1.02.");
}

init
{
	if (settings["oldVersion"])
	{
		vars.roomIDNumbers = new int[] { 1, 2, 3, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20, 22, 23, 25, 27, 29, 30, 32, 33, 35, 37, 38, 40, -1};
	}
	else
	{
		vars.roomIDNumbers = new int[] { 1, 2, 3, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20, 22, 23, 25, 28, 30, 32, 34, 36, 38, 40, 41, 43, -1};
	}
}

start
{
	// timer can sometimes start by itself
	// timer does not start while holding key to move when game ends loading
    if (current.roomID == 1 &&
		(old.x == 323 &&
		current.x != old.x &&
		current.x > 300 &&
		current.x < 350) ||
		(old.y > 215.4 && old.y < 215.5 &&
		current.y < old.y &&
		current.y > 200))
    {
        return true;
    }
}

onStart
{
    vars.levelNumber = 1;
}

reset
{
    if (current.roomID == 1 &&
		old.x == 0 &&
		current.x == 323)
    {
        return true;
    }
}

split
{
	if (current.roomID == vars.roomIDNumbers[vars.levelNumber])
	{
		vars.levelNumber++;
		return true;
	}

	if (old.roomID == vars.roomIDNumbers[vars.roomIDNumbers.Length - 2] && current.roomID == vars.roomIDNumbers[vars.roomIDNumbers.Length - 2] + 1)
	{
		vars.endingTime = timer.CurrentTime.RealTime;
	}
	// last split may not work sometimes
	if (current.roomID == vars.roomIDNumbers[vars.roomIDNumbers.Length - 2] + 1 &&
	timer.CurrentTime.RealTime >= vars.endingTime + TimeSpan.FromSeconds(42) &&
	old.playButtonFlag == 0 &&
	current.playButtonFlag == 1)
	{
		return true;
	}
}
