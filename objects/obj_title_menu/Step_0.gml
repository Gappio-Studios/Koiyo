//get inputs
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(ord("Z"));

//sfx
if keyboard_check_pressed(ord("Z")) {
	audio_play_sound(mus_accept_key_sfx, 1000, false);
} // redo this to make it so its not step by step

//store number of options in the current menu & submenu
op_length = array_length(option[menu_level]);

// move through the menu
pos += down_key - up_key;
if pos >= op_length {pos = 0};
if pos < 0 {pos = op_length -1};

//using the options
	if accept_key{
		
	var _sml = menu_level;
	
	switch(menu_level) {
	// PAUSE MENU
		case 0:
			switch(pos){
				//start game
				case 0: room_goto_next(); break;
				//load game
				case 1: break;
				//settings
				case 2: menu_level = 2; break;
				//quit game
				case 3: game_end(); break;
				}
			break;
	//SETTINGS
		case 2:
				switch(pos) {
					//video
					case 0: menu_level = 3; break;
					//audio
					case 1: break;
					//controls
					case 2: menu_level = 5; break;
					//back
					case 3: menu_level = 0; break;
				}
			break;
		//VIDEO SETTINGS
		case 3:
			switch(pos){
					//aspect ratio
					case 0: menu_level = 4; break;
					//alternative textures
					case 1: break;
					//back
					case 2: menu_level = 2; break;
				}
			break;
			//ASPECT RATIO (VIDEO SETTINGS)
					case 4:
			switch(pos){
					//(Default) 4:3 (864 x 648)
					case 0:  break;
					//4:3 (1728 x 1296)
					case 1: 
					camera_destroy(view_camera[0]);
					view_camera[0] = camera_create_view(0, 0, 1728, 1296, 0, obj_player, 144, 108, -1, -1);
						break;
					//
					case 2: break;
					//
					case 3: break;
					//back
					case 4: menu_level = 3; break;
				}
			break;
			//CONTROLS
					case 5:
			switch(pos){
					case 0: draw_text(pos, pos, newkey); break;
						//Make it so that when you press ENTER it will ask for a new key
					case 1: break;

					case 2: break;

					case 3: break;

					case 4: break;

					case 5: menu_level = 2; break;

				}
			break;
			}
		}
		
	//set position back
//	if _sml != menu_level {pos = 0};

// this is needed, dunno why but gives error if commented out.
	
	//correct the option length
	op_length = array_length(option[menu_level]);
