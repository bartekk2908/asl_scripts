state("Ciapek")
{
    byte isLoading : 0xDC6F0, 0x6F8;
    byte isEnding : 0xDC7F4, 0x504, 0x20;

    float x : 0xDC7F4, 0x1C, 0xB4;
    float y : 0xDC7F4, 0x1C, 0xBC;
    
    byte eq0 : 0xDC7F4, 0x500, 0x80;
    byte eq1 : 0xDC7F4, 0x500, 0x81;
    byte eq2 : 0xDC7F4, 0x500, 0x82;
    byte eq3 : 0xDC7F4, 0x500, 0x83;
    byte eq4 : 0xDC7F4, 0x500, 0x84;
}

startup
{
    vars.margin = 0.1f;
}

init
{
    vars.splitIndex = 0; 
}

start
{
    if (current.isLoading == 0 && old.isLoading == 1)
    {
        vars.splitIndex = 0;
        return true;
    }
}

reset
{
    if (current.isLoading == 0 && old.isLoading == 1)
    {
        return true;
    }
}

split
{
    if (current.isEnding == 1 && old.isEnding == 0)
    {
        return true;
    }

    switch ((int)vars.splitIndex)
    {
        case 0:
            if (current.eq0 == 1 && old.eq0 == 0)
            {
                vars.splitIndex++;
                return true;
            }
            break;

        case 1:
            if (current.eq2 == 1 && old.eq2 == 0)
            {
                vars.splitIndex++;
                return true;
            }
            break;

        case 2:
            if (current.eq3 == 1 && old.eq3 == 0)
            {
                vars.splitIndex++;
                return true;
            }
            break;

        case 3:
            if (Math.Abs(current.x - 24.95f) <= vars.margin && Math.Abs(current.y - 41.55f) <= vars.margin)
            {
                vars.splitIndex++;
                return true;
            }
            break;
    }
}
