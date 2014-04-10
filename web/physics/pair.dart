library phx.pair ;

import 'body.dart' ;

abstract class Pair
{
  Body _a ;
  Body _b ;
  
  Pair(this._a, this._b) ;
  
  Body get A => _a ;
  Body get B => _b ;
  
  bool IsEqual(Pair pair)
  {
    return (_a == pair._a && _b == pair._a) || (_a == pair._b && _b == pair._a) ; 
  }
}