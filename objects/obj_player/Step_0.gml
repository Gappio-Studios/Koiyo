right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);

// get xspd and yspd
xspd = (right_key - left_key) * global.move_spd;
yspd = (down_key - up_key) * global.move_spd;

// check if pauser exists to freeze player during transition
if instance_exists(obj_pause) 
	{
	xspd = 0;
	yspd = 0;
	}

// set the player sprite to direction
mask_index = sprite[DOWN]; // collision is always drawn from down_sprite
if yspd == 0
	{
	if xspd > 0 {face = RIGHT};
	if xspd < 0 {face = LEFT};
	}
if xspd > 0 and face == LEFT {face = RIGHT};
if xspd < 0 and face == RIGHT {face = LEFT};
if xspd == 0
	{
	if yspd > 0 {face = DOWN};
	if yspd < 0 {face = UP};
	}
if yspd > 0 and face == UP {face = DOWN};
if yspd < 0 and face == DOWN {face = UP};
sprite_index = sprite[face];

//collisions
if place_meeting(x + xspd, y, obj_wall)
	{
		xspd = 0;
	}
if place_meeting(x, y + yspd, obj_wall)
	{
		yspd = 0;
	}

// move the player themselves
x += xspd;
y += yspd;

//dont animate when not moving
if xspd == 0 and yspd == 0
	{
	image_index = 0;	
	}
	
// depth
depth = -bbox_bottom;

// funny haha speed (cheats)
if keyboard_check_pressed(vk_f1)
	{
	global.move_spd = 7; // high move speed
	//draw_text(0, 0, "Cheats activated!");
	}

if keyboard_check_pressed(ord("B"))
	{
	globa.setupinv = true;
	}