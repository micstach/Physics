library math.vec2 ;

import 'dart:math' ;

class Vec2 {
  double x;
  double y;
  
  Vec2(this.x, this.y) ;

  Vec2.fromPoint(Point<double> p) 
  {
    this.x = p.x;
    this.y = p.y ;
  }

  double get SqLength => x * x + y * y ;

  double get Length => sqrt(SqLength) ;
  
  Vec2 operator + (Vec2 v) {
    return new Vec2(x + v.x, y + v.y);
  }

  Vec2 operator - (Vec2 v) {
    return new Vec2(x - v.x, y - v.y);
  }
  
  Vec2 operator * (double f) {
    return new Vec2(x * f, y * f);
  }

  void Zero()
  {
    x = 0.0 ;
    y = 0.0 ;
  }
  
  double operator | (Vec2 v)
  {
    return (x * v.x + y * v.y) ;
  }
  
  Vec2 Normalize()
  {
    double f = 1.0 / Length ;
    x *= f ;
    y *= f ;
    return this;
  }
  
  Vec2 Neg()
  {
    x = -x ;
    y = -y ;
    return this ;
  }
  
  static Vec2 Reflect(Vec2 v, Vec2 n)
  {
    // n must be unit-length
    return ((n * (2.0 * (n | v))) - v) ; 
  }
  
  static Vec2 Project(Vec2 v, Vec2 n)
  {
    // n must be unit-length
    return (v - n * (v|n)) ; 
  }
  
}
