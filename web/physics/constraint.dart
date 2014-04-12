library constraint;

import "../../renderer/renderer.dart" ;

import "body.dart";
import "pair.dart";

abstract class Constraint extends Pair
{
  Constraint(Body a, Body b) : super(a, b) ;

  void Resolve() ;
  
  void Render(Renderer renderer) ;
  
  void RenderStopped(Renderer renderer) ;
  
  toJSON() ;
}