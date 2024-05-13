// returns x and y of the viewcamera 0 in the rooms
var _camx = camera_get_view_x(view_camera[0]);
var _camy = camera_get_view_y(view_camera[0]);
var _p = .5; // parallax (higher number the more distant it will look)
// and then draws it at cords of camera
draw_sprite_tiled(spr_outsidebackground, 0, _camx*_p, _camy*_p);
//draw_sprite_tiled(spr_background, 1, _camx*.15, _camy*.15); // frames of sprites (layers)
//draw_sprite_tiled(spr_background, 2, _camx*.25, _camy*.25);


//**
// Parallax can be used when a lot of the surface is covered
// or like when its a set x value and ths camera height doesnt change you can do
// cool stuff like that one scene in undertale
// otherwise just use 1 layer in certain rooms and multiple in other
// experiment!
// example code below for specific room
//**

// keep in mind you would have to set every room that you wanted to be specific
//------------------------------------
//if room == rm_house
//	{
//	draw_sprite_tiled(spr_background, 0, _camx*_p, _camy*_p);
//	}
//if room != rm_house
//	{
//	draw_sprite_tiled(spr_outsidebackground, 0, _camx*_p, _camy*_p);
//	}
// yknow on second thought its more optimized to add a seperate object