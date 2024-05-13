accept_key = keyboard_check_pressed(ord("Z"));
autofill_key = keyboard_check_pressed(ord("X"));
textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 144; // 144 = camera offset, only y as the x cord doesnt change

//--------------------------------------------------setup--------------------------------------------------//
// GREAT example of how to do something for only one frame, immediately set the var to false
if setup == false{
	setup = true; 
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	global.move_spd = 0;
	//looping through the pages
	for(var p = 0; p < page_number; p++)
		{
		// find how manby character are on each page and store that number in the "text_length" array
		text_length[p] = string_length(text[p])	;

		// get x pos of textbox when character is not speaking (centering the textbox)
			//character on the left
			text_x_offset[p] = 80;
			portrait_x_offset[p] = 8;
			//character on the right
			if speaker_side[p] == -1{
			text_x_offset[p] = 8;
			portrait_x_offset[p] = 216;	
				}
			// 44 is the number of pixels away from the left side of screen 
			if speaker_sprite[p] == noone {
				text_x_offset[p] = 44; 
				}
		//setting the individual characters and finding where the lines of text should break
		for (var c = 0; c < text_length[p]; c++)
			{
			var _char_pos = c+1;
			
			//store individual characters in the "char" array
			char[c, p] = string_char_at( text[p], _char_pos );
			
			//get current width of the line
			var _txt_up_to_char = string_copy( text[p], 1, _char_pos );
			var _current_txt_w = string_width( _txt_up_to_char) - string_width( char[c, p] );
			
			//get the last free space
			if char[c, p] == " " { last_free_space = _char_pos+1 };
			
			//get the line breaks
			if _current_txt_w - line_break_offset[p] > line_width
				{
				line_break_pos[ line_break_num[p], p ] = last_free_space;
				line_break_num[p]++;
				var _txt_up_to_last_space = string_copy( text[p], 1, last_free_space );
				var _last_free_space_string = string_char_at( text[p], last_free_space );
				line_break_offset[p] = string_width( _txt_up_to_last_space ) - string_width( _last_free_space_string );
				}
			
			}
			
		//getting each characters coordinates
		for (var c = 0; c < text_length[p]; c++)
			{
			var _char_pos = c+1;	
			var _txt_x = textbox_x + text_x_offset[p] + border;
			var _txt_y = textbox_y + border;
			//get current width of the line v2
			var _txt_up_to_char = string_copy( text[p], 1, _char_pos );
			var _current_txt_w = string_width( _txt_up_to_char) - string_width( char[c, p] );
			var _txt_line = 0;
			
			//compensate for string breaks
			for (var lb = 0; lb < line_break_num[p]; lb++)
				{
				//if the current looping character is after a line break
				if _char_pos >= line_break_pos[lb, p]
					{
					var _str_copy = string_copy( text[p], line_break_pos[lb, p], _char_pos-line_break_pos[lb, p] );
					_current_txt_w = string_width( _str_copy );
					
					//record the "line" this character should be on
					_txt_line = lb+1 // +1 since lb starts at 0
					}
				}
			//add to the x and y coordinates based on the new info
			char_x[c, p] = _txt_x + _current_txt_w;
			char_y[c, p] = _txt_y + _txt_line*line_sep;
			}
		
		}
}

//-------------------------typing the text in the textbox-------------------------//
if text_pause_timer <= 0
	{
		if draw_char < text_length[page]
			{
			draw_char += text_spd;
			draw_char = clamp(draw_char, 0, text_length[page]);
			var _check_char = string_char_at( text[page], draw_char );
			if _check_char == "." || _check_char == "?" || _check_char == "!" || _check_char == ","
				{
				text_pause_timer = text_pause_time;	
		//		if !audio_is_playing(snd[page]) {
		//			audio_play_sound(snd[page], 8, false); 
		//disabled rn but makes it so it makes a sound on punctuation.
		// change to a smaller, different audio file later!
				}
		else
				{
				//typing sound
				if snd_count < snd_delay {
				snd_count++;
				} else {
				snd_count = 0;
				audio_play_sound(snd[page], 8, false);
				}
			}		
		} 
		
	}else {
		text_pause_timer--;
	}

// skipping the rest of the text with autofill key
if autofill_key{
	draw_char = text_length[page];	
}

//flipping through the pages using accept_key
if accept_key{
	//if the typing is done
	if draw_char == text_length[page]
		{
		//next page
		if page < page_number-1
			{
			page++;
			draw_char = 0;
			}
		//destroy the textbox at the end
		else
			{
				if page < page_number // wont immediately delete if z is interact
					{
						//link text for options (BE CAREFUL THIS IS VERY SHITTY CODE BUT IDK HOW 2 FIX)
						if option_number > 0 { 
							create_textbox(option_link_id[option_pos]);	
						}
					instance_destroy();
					global.move_spd = 1;
					}
			}
		}
}

	
//-------------------------draw the textbox-------------------------//
var _txtb_x = textbox_x + text_x_offset[page];
var _txtb_y = textbox_y;
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr[page]);
txtb_spr_h = sprite_get_height(txtb_spr[page]);
//draw the speaker
if speaker_sprite[page] != noone 
	{
	sprite_index = speaker_sprite[page];
	if draw_char == text_length[page] {image_index = 0};
	var _speaker_x = textbox_x + portrait_x_offset[page];
	if speaker_side[page] == -1 {_speaker_x += sprite_width};
	//draw the speaker
	draw_sprite_ext(txtb_spr[page], txtb_img, textbox_x + portrait_x_offset[page], textbox_y, sprite_width/txtb_spr_w, sprite_height/txtb_spr_h, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, _speaker_x, textbox_y, speaker_side[page], 1, 0, c_white, 1);
	}
//drawing the back of the textbox
draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x, _txtb_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1);
//-------------------------options-------------------------//
if draw_char == text_length[page] && page == page_number - 1
	{
		
	//option selection
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	option_pos = clamp(option_pos, 0, option_number-1);
		
	//drawing the options
	var _op_space = 15;
	var _op_bord = 4;
	//var _imginde = sprite_set_speed(sprite_index, 8, spritespeed_framespersecond);
	for (var op = 0; op < option_number; op++)
		{
		// drawing the option box
		var _o_w = string_width(option[op]) + _op_bord*2;
		global.move_spd = 0;
		// variable to control the movement when arrow has an option selected
		_x_temp = 8;	
		_selected_col = c_white;
		//the arrow
		if option_pos == op	
			{
			draw_sprite_ext(spr_textbox_arrow, image_index+image_speed++/3.5, _txtb_x,  _txtb_y - _op_space*option_number + _op_space*op, 1, 1, 0, c_white, 1);
			_x_temp = 16;
			_selected_col = c_yellow;
			}
		// to change the sprite of little option change txtb_spr to another variable
		draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x + _x_temp, _txtb_y - _op_space*option_number + _op_space*op, _o_w/txtb_spr_w, (_op_space-1)/txtb_spr_h, 0, _selected_col, 1); 

		//the option text
		draw_text_colour(_txtb_x + _x_temp + _op_bord, _txtb_y - _op_space*option_number + _op_space*op - 2, option[op], _selected_col, _selected_col, _selected_col, _selected_col, 1); // -2 can change for text ehight
		}
	}
//draw the text itself
for (var c = 0; c < draw_char; c++)
	{
	// FX
	//--------------FLOATING TEXT--------------//
	var _float_y = 0;
	if float_text[c, page] == true
		{
		float_dir[c, page] += -6;
		_float_y = dsin( float_dir[c, page] ); // y value based off 360 circle like a radar going around
		// can do *2 at the end for more wavy
		}
	//--------------SHAKY TEXT--------------//
	var _shake_x = 0;
	var _shake_y = 0;
	if shake_text[c, page] == true
		{
		shake_timer[c, page]--;
		if shake_timer[c, page] <=4 {
			shake_timer[c, page] = irandom_range(4, 8);
			shake_dir[c, page] = irandom(360);
			_shake_x = lengthdir_x(1, shake_dir[c, page]);
			_shake_y = lengthdir_y(1, shake_dir[c, page]);
			}
		}

	
	//the text
	draw_text_colour( char_x[c, page] + _shake_x, char_y[c, page] + _float_y + _shake_y, char[c, page], col_1[c, page], col_2[c, page], col_3[c, page], col_4[c, page], 1 );
	}