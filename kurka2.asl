state("kurka")
{
	byte chickensLeft : 0x8AADC;
	byte levelTime : 0x1017F2C;
	byte finalBossHP : 0x3037A0;
	byte isLoadingNow : 0x1031AD4;
	int isInMainMenuFlag : 0x1031C2C;
}

startup
{
	// hard
	// vars.chickensLevelList = new int[] { 68, 85, 0, 103, 110, 107, 11 };

	// easy
	vars.chickensLevelList = new int[] { 46, 55, 0, 64, 72, 67, 8 };
}

start
{
    return (
		current.chickensLeft == vars.chickensLevelList[0] &&
		current.levelTime == 0
		);
}

onStart
{
	vars.levelNumber = 1;
	vars.canSplit = false;
	vars.isEnding = false;
	vars.inMenuFlagTime = timer.CurrentTime.RealTime;
}

split
{
	if (vars.isEnding && timer.CurrentTime.RealTime >= vars.endingTime + TimeSpan.FromSeconds(3.5))
	{
		return true;
	}
	else
	{
		if (vars.canSplit)
		{
			if (vars.levelNumber != 2 && vars.levelNumber != 6 && vars.levelNumber != 7)
			{
				if (current.chickensLeft ==  vars.chickensLevelList[vars.levelNumber] && current.levelTime == 0)
				{
					vars.levelNumber++;
					vars.canSplit = false;
					return true;
				}
			}
			else if (
				(vars.levelNumber == 2 && current.chickensLeft ==  vars.chickensLevelList[vars.levelNumber] && current.levelTime == 120) ||
				(vars.levelNumber == 6 && current.chickensLeft ==  vars.chickensLevelList[vars.levelNumber])
			)
			{
				vars.levelNumber++;
				vars.canSplit = false;
				return true;
			}
			else if (vars.levelNumber == 7 && current.finalBossHP == 0 && old.finalBossHP == 1)
			{
				vars.endingTime = timer.CurrentTime.RealTime;
				vars.isEnding = true;
			}
		}
		else if (current.chickensLeft == 0 || vars.levelNumber == 7)
		{
			vars.canSplit = true;
		}
	}
}

update
{
	if (!(current.isInMainMenuFlag == 1 && current.isLoadingNow == 0))
	{
		vars.inMenuFlagTime = timer.CurrentTime.RealTime;
	}
}

reset
{
	// if (timer.CurrentTime.RealTime >= vars.inMenuFlagTime + TimeSpan.FromSeconds(1))
	// {
	// 	print("elo");
	// 	return true;
	// }
	return (timer.CurrentTime.RealTime >= vars.inMenuFlagTime + TimeSpan.FromSeconds(1));
}

isLoading
{
	return (current.isLoadingNow == 1);
}
