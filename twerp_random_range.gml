/// @param min
/// @param max
/// @param twerp_type
/// @param [invert=false]
///@func twerp_random_range(min, max, TwerpType, *invert?)
function twerp_random_range(_min, _max, _type, _invert) {
  if(false) argument[0]=undefined; //Optional Argument Warning Suppression
  _invert = _invert != undefined ? _invert : false;
  var _val = twerp_random(_max-_min,_type,_invert);
  return _min + _val;
}
