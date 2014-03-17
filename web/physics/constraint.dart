library phx_constraint;

import "../../renderer/renderer.dart" ;
import 'particle.dart' ; 

abstract class Constraint
{
  double order = 0.0 ;
  Particle _a, _b ;
  
  Constraint(this._a, this._b) ;
  
  Particle get A => _a ;
  
  Particle get B => _b ;
  
  void Resolve() ;
  
  double get Order => order ;
  
  void ResolveForces() ;
  
  void Render(Renderer renderer) ;
}