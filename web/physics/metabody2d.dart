library metabody2d ;

//import '../../math/vec2.dart' ;
//
//import 'body.dart' ;
//
//class MetaBody2D /*extends Body*/
//{
//  // basis body
//  Body _a = null, _b = null, _c = null ;
//  
//  Vec2 _x = null ;
//  Vec2 _y = null ;
//  
//  Vec2 _p = null ;
//  
//  MetaBody2D(this._a, this._b, this._c, Vec2 p, double r) 
//  {
//    // define basis coordinate system
//    _x = _b.Position - _a.Position ;
//    _y = _c.Position - _a.Position ;
//    
//    Vec2 local = p - _a.Position ;
//    
//    _p = Vec2.LocalCoordinates(local, _x, _y) ; 
//  }
//}