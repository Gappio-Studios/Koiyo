camera_set_view_pos(view_camera[0], xpos, 38);
xpos = max(xpos-0.1, 0); //reducing by 0.3 and giving limit of 0
if (!fadeout) a = max(a-0.005, 0.25); else a = min(a+0.005, 1);

l += 0.20; // 1 letter every 2 frames

print = string_copy(str, 1, l); 
if (l > string_length(str) + 50) && (next < array_length(strings) -1)
	{
	next++;
	l = 0;
	if (next == array_length(strings)-1) holdspace++;
	}
str = strings[next]; // variable "next" is 0 so when we change it, it will change the text

if (keyboard_check_direct(vk_space))
	{
	holdspace++;	
	}
	
if (holdspace > 80) || (xpos < 5) fadeout = 1;

if (a == 1) && (fadeout == 1) 
	{
	room_goto_next();
	}