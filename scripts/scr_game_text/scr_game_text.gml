/// @param text_id
function scr_game_text(_text_id){
switch(_text_id) {


//-------KEY FOR CREATING DIALOGUE-------//
#region
// ---- = New Case
// === = Continuation / Option of a case
/// scr_text "STRING", "CHARACTER PORTRAIT (OPTIONAL", IF ON OTHER SIDE OR NOT (-1 = Right)
// do this region stuff for collapsable code
#endregion

//--------------"Test Dialogue 1"-------//
#region
//-------------------------------------------------------------//
	case "npc 1":
		scr_text("Hello there, my fellow Americans!", "Youee Default");
			scr_text_colour(0, 12, c_red, c_red, c_red, c_red); // 1st and last character to start and 4 colours for the corners
		// you can get your own colours just search up to make customs
		scr_text("So, I need a favour... I need you to grab your credit card.", "Youee Blonde", -1);
		scr_text("... What? My credit card?", "Youee Default");
			scr_text_float(31, 39);
		scr_text("Yeah, and read out the digits on the front and back.", "Youee Blonde", -1);
			scr_text_shake(0, 8);
		scr_text("You got that?", "Youee Default");
			scr_text_colour(16, 19, c_red, c_red, c_red, c_red);
			scr_option("Yeah sure its 373, 195-25...", "npc 1 - good"); // first string is text, second string is case of continuation
			scr_option("Silence, wench.", "npc 1 - bad");
		break;
		//==================================//
			case "npc 1 - good":
				scr_text("lol thanks.", "Youee Blonde", -1);
				scr_text_colour(0, 4, c_green, c_green, c_green, c_green);
				break;
		//==================================//
			case "npc 1 - bad":
				scr_text("Your mother will be dipped in peanut butter and consumed by the rot... Have at thee!", "Youee Blonde Angry", -1);
				break;
#endregion

//-------------------------------------------------------------//
	case "npc 3":
		
		break;
//-------------------------------------------------------------//
	case "npc 4":
		
		break;
//-------------------------------------------------------------//
}
}