// returns x and y of the viewcamera 0 in the rooms
var _camx = camera_get_view_x(view_camera[0]);
var _camy = camera_get_view_y(view_camera[0]);
var _p0 = .5; // parallax (higher number the more distant it will look)
var _p1 = .25;
// and then draws it at cords of camera
draw_sprite_tiled(spr_topdownview_1, 0, _camx*_p0, _camy*_p0);
draw_sprite_tiled(spr_topdownview_1, 1, _camx*_p1, _camy*_p1);
//draw_sprite_tiled(spr_background, 1, _camx*.15, _camy*.15); // frames of sprites (layers)
//draw_sprite_tiled(spr_background, 2, _camx*.25, _camy*.25);
