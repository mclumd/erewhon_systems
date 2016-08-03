
(setf (current-problem)
      (create-problem
       (name abstrips)
       (objects
	(dunimys dmysram dmyspdp dpdpclk dmysclk dramclk dclkril
		 dramhal Door)
	(runi rmys rram rhal rpdp rclk rril Room)
	(box1 box2 box3 Object)
	(middle LocX)
	(end    LocY))
       (state
	(and
	 (connects dunimys runi rmys)
	 (connects dmysram rmys rram)
	 (connects dramhal rram rhal)
	 (connects dmyspdp rmys rpdp)
	 (connects dpdpclk rpdp rclk)
	 (connects dmysclk rmys rclk)
	 (connects dramclk rram rclk)
	 (connects dclkril rclk rril)
	 (statis dunimys open)
	 (statis dmysram open)
	 (statis dramhal open)
	 (statis dmyspdp open)
	 (statis dpdpclk open)
	 (statis dmysclk open)
	 (statis dramclk open)
	 (statis dclkril closed)
	 (in-room robot rril)
	 (in-room box1 rpdp)
	 (in-room box2 rpdp)
	 (in-room box3 rclk)
	 (pushable box1)
	 (pushable box2)
	 (pushable box3)))
       (igoal
;	(and (next-to box1 box2) (in-room robot runi))
;	(in-room robot runi)
	(next-to box1 box2)
;	(in-room robot rmys)
	)))
	 

    
