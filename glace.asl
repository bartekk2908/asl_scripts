
state("Glace")
{
	byte scene : 0x09B31C, 0xAC, 0x00;
	byte bossHP : 0x09B2F0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x063C; 
	byte isDialogBox : 0x09B3E8;
}

startup
{
	vars.levelNumber = 1;
	vars.sceneNumbers = new int[] { 4, 5, 6, 7, 9, 10, 11, 17, 18, 19, 20, 23, 24, 26, 27, -1 };

	settings.Add("levelSplits", true, "Level Splits");
	settings.SetToolTip("levelSplits", "Splits between every playable level. \nDoes not apply to the last split after defeating the final boss.");
}

init
{
	vars.canReset = true;
}

start
{
	return current.isDialogBox == 1  && current.scene == 0;
}

onStart
{
	vars.levelNumber = 1;
	vars.canReset = false;
}

reset
{
	return current.isDialogBox == 1  && current.scene == 0 && vars.canReset;
}

update
{
	if (current.scene != 0 && !vars.canReset)
	{
		vars.canReset = true;
	}
}

split
{
	if (current.bossHP <= 0 && (old.bossHP == 5 || old.bossHP == 10 || old.bossHP == 15) && vars.levelNumber == 15)
	{
		return true;
	}
	if (current.scene == vars.sceneNumbers[vars.levelNumber])
	{
		vars.levelNumber++;
		return settings["levelSplits"];
	}	
}
