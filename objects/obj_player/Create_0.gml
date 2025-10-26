#region variaveis


velh       = 0;
velv       = 0;
max_velh    = 2;
max_velv    = 7;
my_gravity  = 0.4;


is_grounded = false;

//input
right   = false;
left    = false;
jump    = false;
tab     = false;

//estado
state = noone;

#endregion
#region metodos
input_set = function()
{
    right   = keyboard_check(ord("D"));
    left    = keyboard_check(ord("A"));
    jump    = keyboard_check_pressed(vk_space);
    tab     = keyboard_check_pressed(vk_tab)
}

change_scale = function()
{
    if (velh < 0) image_xscale = -1;
    if (velh > 0) image_xscale = 1;
}

move_player = function()
{
    
    check_ground();
    
    velh = (right - left) * max_velh;
    //chechando colisão em y
    y_colision();
    //criar gravidade
    set_gravity();
    
    y -= round(velv);
    //checando colisão em x
    x_colision();
    
    x += round(velh);
}    

x_colision = function()
{
    if place_meeting(x + velh, y, obj_wall)
    {   
        var _velh = sign(velh);
        while(!place_meeting(x + _velh, y, obj_wall))
            {
                x += _velh;    
            }
        velh = 0;   
    }
}
y_colision = function()
{
    if (place_meeting(x , y - velv, obj_wall))
    {   
        var _velv = sign(velv);
        while(!place_meeting(x , y - _velv, obj_wall))
            {
                y -= _velv;    
            }
        velv = 0;
    }
}

check_ground = function()
{
    if place_meeting(x , y + 1, obj_wall)
    {
        is_grounded = true;    
    }else 
    {
        is_grounded = false;	
    }
}

//estados do player
idle_state = function()
{
    move_player();
    change_sprite(spr_idle_1);
    image_blend = -1;
    
    if (right) != (left)
    {
        state = running_state;    
    }
    
    if (jump) state = jumping_state; 
    
}
running_state = function()
{
    move_player();
    change_sprite(spr_running)
    if (velh == 0) state = idle_state;
}
jumping_state = function()
{
    move_player();
    change_sprite(spr_idle_1);
    //if velv > 0 sprite = subindo if velv < 0 sprite = descendo
    
    if (is_grounded) state = idle_state;

}

end_animation = function()
{
    var _spd = sprite_get_speed(sprite_index) / FPS;
    if (image_index + _spd >= image_number)
    {
        return true;
    }
}


power_up_state_start = function()
{
    change_sprite(spr_idle_1)
    
    if (end_animation())
    {
        state = power_up_state_middle;
    }
} 
power_up_state_middle = function()
{
    change_sprite(spr_idle_1)
    
    if (end_animation())
    {
        state = power_up_state_end;
    }
} 
power_up_state_end = function()
{
    if (end_animation())
    {
        state = idle_state;
    }
}

start_dive = function()
{
    change_sprite(spr_start_dive);
}

end_dive = function()
{
    change_sprite(spr_end_dive);
    
    if (end_animation())
        {
           state = idle_state; 
        }    
} 

set_gravity = function()
{
    if (!is_grounded)
    {
        velv -= my_gravity; 
        
    }else
    {
        velv = 0;
        
        y = round(y)
        
        if (jump)
        {
            velv = max_velv;
            y_colision();
        }
        
    } 
}

change_sprite = function(_sprite)
{
    if (sprite_index != _sprite)
    {
        sprite_index = _sprite;
        image_index = 0;    
    }
}



#endregion


#region debug

view_player = noone;

set_debug = function()
{
    //if (!global.debug) return;
    
    view_player = dbg_view("View Player", 1, 60, 80, 300, 300); 
    
    show_debug_overlay(view_player);
    
    dbg_watch(ref_create(id, "velv"), "velv");
    dbg_watch(ref_create(id, "y"), "y");
    
    dbg_slider(ref_create(id, "max_velv"), 0, 10, "max_velv", 0.1);
    dbg_slider(ref_create(id, "my_gravity"), 0, 1, "my_gravity", 0.01);
}

ativa_debug = function()
{
    if (!DEBUG_MODE) return;
    
    if (tab)
    {    
        global.debug = !global.debug;
        
        if (global.debug)
        {
            set_debug();
        }else
        {
            show_debug_overlay(0);
            
            if (dbg_view_exists(view_player))	
            {
               dbg_view_delete(view_player);   
            }
        }
    }
}

#endregion

state = idle_state;