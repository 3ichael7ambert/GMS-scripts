/// @param x
/// @param twerp_type
/// @param [invert=false]
///@func twerp_random(x, TwerpType, *invert?)
function twerp_random(_x, _type, _invert) {
  if(false) argument[0] = undefined; //Optional Argument Warning Suppression
  _invert = _invert != undefined ? _invert : false;
  while(true)
  { 
    var _ran = random(1);
    var _twerp = twerp(_type,0,_x,_ran);
    var _random = random(_x);
	
  	if(_invert && _random>_twerp) 
  		return _random;
  	else if(!_invert && _random < _twerp)
  		return _random;
  }
}