
//estados da porta
enum door_state
{
    closed, unlock, open
}

state_door = door_state.closed;

state_machine = function()
{
    switch state_door
    {
        case 0: // fechada
            
        break;
        case 1: //subindo
            vspeed -= 0.1;
            x = xstart + random_range(-3, 3);
            screenshake(10);
            
            if (y < ystart - sprite_height) state_door = 2;
        break; 
        case 2: //aberta
            x = xstart;
            vspeed = 0;
            
        break; 
    }
}