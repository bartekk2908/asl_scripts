state("MotionRec")
{
	// MotionRec was made in Game Maker so every version can have different pointer paths
	byte scene : 0x9FC414;
	float x: 0xA0A430, 0x8, 0xF4;
	float y: 0xA0A430, 0x8, 0xF8;
	byte playButtonFlag: 0x741A70, 0x120, 0x170, 0xA5C;
}

startup
{
    vars.sceneNumbers = new int[] { 1, 2, 3, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20, 22, 23, 25, 27, 29, 30, 32, 33, 35, 37, 38, 40, -1};

    settings.Add("levelSplits", true, "Level Splits");
    settings.SetToolTip("levelSplits", "Splits between every playable level.");
}

start
{
	// timer can sometimes start by itself
	// timer does not start while holding key to move when game ends loading
    if (current.scene == 1 &&
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
    if (current.scene == 1 &&
		old.x == 0 &&
		current.x == 323)
    {
        return true;
    }
}

split
{
	if (current.scene == vars.sceneNumbers[vars.levelNumber])
	{
		vars.levelNumber++;
		return settings["levelSplits"];
	}

	if (old.scene == 40 && current.scene == 41)
	{
		vars.endingTime = timer.CurrentTime.RealTime;
	}
	// last split may not work sometimes
	if (current.scene == 41 &&
	timer.CurrentTime.RealTime >= vars.endingTime + TimeSpan.FromSeconds(42) &&
	old.playButtonFlag == 0 &&
	current.playButtonFlag == 1)
	{
		return true;
	}
}