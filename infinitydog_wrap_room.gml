/// @description infinitydog_wrap_room()
function infinitydog_wrap_room() {

	/*
	    Run this script in one object's step event.
    
	    The room must have views enabled and the room
	    must be at least 160 pixels wider and taller
	    (based on the variables X_BUFFER and Y_BUFFER
	    below) than the view rectangle.
	*/

	var VIEW_WIDTH = __view_get( e__VW.WView, view_current );
	var VIEW_HEIGHT = __view_get( e__VW.HView, view_current );

	var VIEW_LEFT = __view_get( e__VW.XView, view_current );
	var VIEW_RIGHT = __view_get( e__VW.XView, view_current ) + VIEW_WIDTH;
	var VIEW_TOP = __view_get( e__VW.YView, view_current );
	var VIEW_BOTTOM = __view_get( e__VW.YView, view_current ) + VIEW_HEIGHT;

	var VIEW_CENTER_X = VIEW_LEFT + VIEW_WIDTH/2;
	var VIEW_CENTER_Y = VIEW_TOP + VIEW_HEIGHT/2;

	// adjust these to be smaller for smaller rooms
	var X_BUFFER = 10;
	var Y_BUFFER = 200;

	// wrap X
	if( abs(room_width - VIEW_RIGHT) < X_BUFFER )
	{
	    with(all)
	    {
	        x -= X_BUFFER;
	        if(x < 0)
	            x += room_width;
	    }
        
	    __view_set( e__VW.XView, view_current, __view_get( e__VW.XView, view_current ) - (X_BUFFER) );
	}
	else if( abs(VIEW_LEFT) < X_BUFFER )
	{
	    with(all)
	    {
	        x += X_BUFFER;
	        if(x > room_width)
	            x -= room_width;
	    }
        
	    __view_set( e__VW.XView, view_current, __view_get( e__VW.XView, view_current ) + (X_BUFFER) );
	}

	// wrap Y
	if( abs(room_height - VIEW_BOTTOM) < Y_BUFFER )
	{
	    with(all)
	    {
	        y -= Y_BUFFER;
	        if(y < 0)
	            y += room_height;
	    }
        
	    __view_set( e__VW.YView, view_current, __view_get( e__VW.YView, view_current ) - (Y_BUFFER) );
	}
	else if( abs(VIEW_TOP) < Y_BUFFER )
	{
	    with(all)
	    {
	        y += Y_BUFFER;
	        if(y > room_height)
	            y -= room_height;
	    }
        
	    __view_set( e__VW.YView, view_current, __view_get( e__VW.YView, view_current ) + (Y_BUFFER) );
	}



}
