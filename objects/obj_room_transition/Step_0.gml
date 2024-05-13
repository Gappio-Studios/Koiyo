if place_meeting(x, y, obj_player) and !instance_exists(obj_warp)
	{
	var inst = instance_create_depth(0, 0, -9999, obj_warp); // local var in C++ / GML looks like this not like the lua local
	inst.target_x = target_x;
	inst.target_y = target_y;
	inst.target_rm = target_rm;
	inst.target_face = target_face;
	}