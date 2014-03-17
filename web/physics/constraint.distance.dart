library phx_constraint_distance;

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
    
    //if (diff != 0.0)
    {
      Vec2 delta = dp * ((diff / len) * 0.5) ;
      
      if (!A.IsFixed)
      {
        A.Position -= delta ;
      }
      
      if (!B.IsFixed)
      {
        B.Position += delta ;
      }
      
      double j = Distance.Impulse(0.1, 0.0, diff / len, A.MassInv, B.MassInv) ;
          
      A.AddForce(dp * (-j)) ;
      
      B.AddForce(dp * (j)) ;
    }
  }
  
  void ResolveForces() 
  {
//    Vec2 dp = B.Position - A.Position ;
//    dp.Normalize() ;
//    
//    double j = Distance.Impulse(0.1, 0.0, (B.Velocity - A.Velocity) | dp, A.MassInv, B.MassInv) ;
//    
//    A.AddForce(dp * (j)) ;
//    B.AddForce(dp * (-j)) ;
  }
  
  void Render(Renderer renderer)
  {
    renderer.drawPath([A.Position, B.Position], false, "rgb(128, 128, 128)", "rgb(128, 128, 128)") ;
  }
  
  static double Impulse(double dt, double e, double relVel, double invMassA, double invMassB) 
  {
    return ((1.0 + e) / (dt * dt * 0.5)) * (relVel / (invMassA + invMassB)) ; 
  }   
}