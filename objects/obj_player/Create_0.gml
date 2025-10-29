//inicia efeitos
start_stretch();


#region variaveis

velh       = 0;
velv       = 0;
max_velh    = 2;
max_velv    = 7;
my_gravity  = 0.4;

dir = 1;

is_grounded = false;

//input
right   = false;
left    = false;
jump    = false;
tab     = false;
dive    = false;

//estado
state = noone;

//colisoes array
var _tiles = layer_tilemap_get_id("TS_wall");
colision = [obj_wall, _tiles];

#endregion
#region metodos
input_set = function()
{
    right   = keyboard_check(ord("D"));
    left    = keyboard_check(ord("A"));
    jump    = keyboard_check_pressed(vk_space);
    tab     = keyboard_check_pressed(vk_tab);
    dive    = keyboard_check_pressed(ord("S"));
}

change_scale = function()
{
    if (velh != 0) dir = sign(velh);

}

move_player = function()
{
    
    check_ground();
    
    velh = (right - left) * max_velh;
    velv = clamp(velv, -max_velv, max_velv);
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
    if place_meeting(x + velh, y, colision)
    {   
        var _velh = sign(velh);
        while(!place_meeting(x + _velh, y, colision))
            {
                x += _velh;    
            }
        velh = 0;   
    }
}
y_colision = function()
{
    if (place_meeting(x , y - velv, colision))
    {   
        var _velv = sign(velv);
        while(!place_meeting(x , y - _velv, colision))
            {
                y -= _velv;    
            }
        velv = 0;
    }
}

check_ground = function()
{
    if place_meeting(x , y + 1, colision)
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
        stretch_effect(0.9, 1.1);    
    }
    
    
    if (jump) && (is_grounded)
    {
        state = jumping_state;
        stretch_effect(0.8, 1.5); 
    }
    
    
    if (dive) && (is_grounded)
    {
        state = start_dive;
    } 
    
}
running_state = function()
{
    move_player();
    change_sprite(spr_running)
    if (velh == 0) state = idle_state;
        
    if (dive) && (is_grounded)
    {
        state = start_dive;
    } 
}
jumping_state = function()
{
    move_player();
    change_sprite(spr_idle_1);
    //if velv > 0 sprite = subindo if velv < 0 sprite = descendo
    if (velv > 0) 
    {
        change_sprite(spr_jump_start);    
    }else{
        change_sprite(spr_jump_end);
    }
    
    
    if (is_grounded) 
    {
        state = idle_state;
        stretch_effect(1.5, 0.8); 
    }
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
    check_ground();
    change_sprite(spr_start_dive);
    
    if (end_animation())
    {
        state = underground_state;
    } 

}

underground_state = function()
{
    change_sprite(spr_underground);
    check_ground();
    
    velh = (right - left) * max_velh;
    
    var _stop = !place_meeting(x + sprite_width/2 * dir + velh, y + 1 , colision)
    if (_stop)
    {
        velh = 0;
    }
    
    x_colision();
    
    x += round(velh);
    
    if (dive) && (is_grounded)
    {
        state = end_dive;
    }
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