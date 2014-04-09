library phx.pair ;

import 'body.dart' ;

abstract class Pair
{
  Body _a ;
  Body _b ;
  
  Pair(this._a, this._b) ;
  
  Body get A => _a ;
  Body get B => _b ;
}