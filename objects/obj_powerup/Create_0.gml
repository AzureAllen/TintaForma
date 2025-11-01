target = noone;

move = function()
{
    if (!target) return;
        
    x = target.x;
    y = target.y - sprite_height *1.5;
}

explosion = function()
{
    repeat(20)
    {
        var _inst       = instance_create_layer(target.x , target.y - sprite_height *2, layer, obj_part_power_up);
        _inst.speed     = random_range(2, 4);
        _inst.direction = random_range(1, 359);
        
        _inst.target = target;
    }
}