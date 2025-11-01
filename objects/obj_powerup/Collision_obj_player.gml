


if (target == noone)
{ 
    target = other.id;
    other.power_up_pick_up();  
    explosion();
    move(); 
    other.power_dive = true;
}