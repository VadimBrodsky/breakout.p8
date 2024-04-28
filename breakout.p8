pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	cls()
	
	ball_x=3
	ball_y=10
	ball_dx=2
	ball_dy=2
	ball_r=2
	col=10

	pad_x=52
	pad_y=120
	pad_dx=0
	pad_w=24
	pad_h=3
	pad_c=7
end

function _update()
	local buttpress=false
	
	if btn(0) then
	  --left
	  pad_dx=-5
	  butpress=true
	  --pad_x-=5
	end
	if btn(1) then
	  --right
	  pad_dx=5
	  butpress=true
	  --pad_x+=5
	end
	if not(buttpress) then
		pad_dx=pad_dx/1.7
	end
	pad_x+=pad_dx
	
	ball_x+=ball_dx
	ball_y+=ball_dy
	
	if ball_x > 127 or ball_x < 0 then
		ball_dx=-ball_dx
		sfx(0)
	end
	if ball_y > 127 or ball_y < 0 then
		ball_dy=-ball_dy
		sfx(0)
	end
	
	pad_c=7
	-- check if ball hit pad
	if ball_box(pad_x,pad_y,pad_w,pad_h) then
		pad_c=8
		ball_dy=-ball_dy
	end
end

function _draw()
	rectfill(0,0,127,127,1)
	circfill(ball_x,ball_y,ball_r,col)
	rectfill(pad_x,pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
end

function ball_box(box_x, box_y,box_w,box_h)
	-- checks collioon of the ball with a rectangle
	if ball_y-ball_r > box_y+box_h then
		return false
	end
	if ball_y+ball_r < box_y then
		return false
	end	
	if ball_x-ball_r > box_x+box_w then
		return false
	end
	if ball_x+ball_r < box_x then
		return false
	end
	return true
end

function deflx_ballbox(bx,by,bdx,bdy,tx,ty,tw,th)
 -- calculate wether to deflect the ball
 -- horizontally or vertically when it hits a box
 if bdx == 0 then
  -- moving vertically
  return false
 elseif bdy == 0 then
  -- moving horizontally
  return true
 else
  -- moving diagonally
  -- calculate slope
  local slp = bdy / bdx
  local cx, cy
  -- check variants
  if slp > 0 and bdx > 0 then
   -- moving down right
   debug1="q1"
   cx = tx-bx
   cy = ty-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return true
   else
    return false
   end
  elseif slp < 0 and bdx > 0 then
   debug1="q2"
   -- moving up right
   cx = tx-bx
   cy = ty+th-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  elseif slp > 0 and bdx < 0 then
   debug1="q3"
   -- moving left up
   cx = tx+tw-bx
   cy = ty+th-by
   if cx>=0 then
    return false
   elseif cy/cx > slp then
    return false
   else
    return true
   end
  else
   -- moving left down
   debug1="q4"
   cx = tx+tw-bx
   cy = ty-by
   if cx>=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  end
 end
 return false
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001d3601e3601e3501e3401e3301d3101d30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000
