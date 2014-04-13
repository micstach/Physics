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

  Vec2.fromJSON(var json) 
  {
    this.x = json['x'];
    this.y = json['y'] ;
  }

  Vec2.fromVec2(Vec2 v) 
  {
    this.x = v.x;
    this.y = v.y ;
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
  
  static Vec2 LocalCoordinates(Vec2 v, Vec2 a, Vec2 b)
  {
    // find x and y where
    // v = x * a + y * b 
    double ood = 1.0 / (a.x * b.y - b.x * a.y) ;

    return new Vec2((v.x * b.y - b.x * v.y) * ood, (a.x * v.y - v.x * a.y) * ood ) ;
  }
  
  static Vec2 Rot270(Vec2 v)
  {
    return new Vec2(-v.y, v.x) ;
  }
}
