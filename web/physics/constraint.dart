library phx.constraint;

import "../../renderer/renderer.dart" ;

import 'pair.dart';
import 'particle.dart' ; 

abstract class Constraint extends Pair
{
  Constraint(Particle a, Particle b) : super(a, b) ;

  void Resolve() ;
  
  void Render(Renderer renderer) ;
}