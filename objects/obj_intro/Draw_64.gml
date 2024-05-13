draw_sprite_ext(spr_pixel, 0, 0, 0, 999 ,100, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, 0, 550, 999 ,100, 0, c_black, 1);


draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(420, 590, print);

if (holdspace > 0)
{
		draw_set_alpha(wave(0.2, 0.8, 1, 0));
		draw_text(420, 610, "Hold space to skip.")
		draw_set_alpha(1);
}

draw_sprite_ext(spr_pixel, 0, 0, 0, 1920 ,1080, 0, c_black, a);
