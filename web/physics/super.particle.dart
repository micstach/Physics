library phx.superparticle ;

import '../../renderer/renderer.dart' ;
import '../../math/vec2.dart' ;

import 'particle.dart' ;
import 'Body.dart' ;

class SuperParticle extends Body
{
  Particle _a = null ;
  double _af = 0.0 ;
 
  Particle _b = null ;
  double _bf = 0.0 ;
  
  SuperParticle(this._a, this._af, this._b, this._bf) : super() 
  {
  }
  
  void Render(Renderer renderer)
  {
    double radius = _a.Radius * _af + _b.Radius * _bf ; 
        
    renderer.drawCircle(Position, radius, "rgba(0,0,128, 0.5)") ;
  }

  @override
  Vec2 get Velocity => (_a.Velocity * _af + _b.Velocity * _bf) ;

  @override
  Vec2 get Position => (_a.Position * _af + _b.Position * _bf) ;
}