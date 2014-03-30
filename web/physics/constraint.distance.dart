library phx.constraint.distance;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart' ;
import 'particle.dart' ;
import 'constraint.dart' ;

class Distance extends Constraint
{
  double _distance = 0.0 ;
  
  Distance(Particle a, Particle b) : super(a, b)
  {
    _distance = (A.Position - B.Position).Length ;
  }
  
  void Resolve()
  {
    Vec2 dp = B.Position - A.Position ;
    double len = dp.Length ;
    double diff = (_distance - len) ;
    
    Vec2 delta = dp * ((diff / len)) ;
    
    if (!A.IsFixed)
    {
      double s = A.MassInv / (A.MassInv + B.MassInv) ;
      A.Position -= delta * s;
      A.Velocity -= delta * s;
    }
    
    if (!B.IsFixed)
    {
      double s = B.MassInv / (A.MassInv + B.MassInv) ;
      B.Position += delta * s ;
      B.Velocity += delta * s;
    }
  }
  
  void Render(Renderer renderer)
  {
    renderer.drawPath([A.Position, B.Position], false, "rgb(128, 128, 128)", "rgb(128, 128, 128)") ;
  }
  
  toJSON()
  {
    return {"type": "distance", "a": A.hashCode, "b" : B.hashCode} ;
  }
}