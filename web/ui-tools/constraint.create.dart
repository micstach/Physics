library constraint.create;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/metabody1d.dart';

import '../physics/body.dart';
import '../physics/scene.dart';
import '../physics/constraint.distance.dart';

import 'canvas.tool.dart' ;

import 'dart:html';

class CreateConstraint extends CanvasTool
{
  double _alpha = 1.0 ;
  
  final Scene _scene ;
  
  Body _a = null ;
  Body _b = null ;
  Body _selected = null ;

  MouseEvent _mouseEvent = null ;
  
  CreateConstraint(CanvasElement canvas, this._scene) : super(canvas)
  {
  }

  void OnMouseDown(MouseEvent e)
  {
    Vec2 point = ConvertToWorldCoords(e)  ;

    Body p = _findClosest(point) ;
    
    if (p != null)
    {
      if (_a == null)
        _a = p ;
      else if (_b == null)
        _b = p ;
    }
  }
  
  void OnMouseMove(MouseEvent e)
  {
    Vec2 point = ConvertToWorldCoords(e) ;
    
    _selected = _findClosest(point) ;
  }

  void OnMouseUp(MouseEvent e)
  {
    addConstraint(e.ctrlKey) ;
  }
  
  bool get IsActive => true ; 
  
  void Draw(Renderer renderer)
  {
    super.Draw(renderer) ;

    if (IsActive)
    {
      if (_selected != null)
      {
        renderer.drawBox(_selected.Box, "rgba(255, 0, 0, 0.75)") ;
      }
      
      if (_a != null && _selected != null && _a != _selected)
      {
        renderer.drawLine(_a.Position, _selected.Position, "rgba(128, 128, 128, 0.5)") ;
      }
    }
  }
  
  String get Name => "select two particles to create distance constraint" ;

  Body _findClosest(Vec2 point)
  {
    Body closest = null ;
    double distance = double.INFINITY ;
       
    for (Body p in _scene.bodies)
    {
      double d = (p.Position - point).SqLength ;
      if (d < distance)
      {
        closest = p ;
        distance = d; 
      }
    }
    
    if (closest != null)
    {
      if (distance < (closest.Radius * closest.Radius))
        return closest ;
      else
        return null ;
    }
    else
    {
      return null ;
    }
  }
  
  void addConstraint(bool filled)
  {
    if (_a != null && _b != null && _a != _b)
    {
      _scene.constraints.add(new ConstraintDistance(_a,  _b)) ;
      
      if (filled)
      {
        double distance = (_b.Position - _a.Position).Length ;
        double distributableDistance = distance - _a.Radius - _b.Radius ;
        
        int items = (1 + (distributableDistance ~/ (_a.Radius  + _b.Radius)).toInt()) ;
        
        double step = distributableDistance / items ;
        
        double start = _a.Radius;
        for (int i=0; i<items; i++)
        {
          double f = (start + step / 2.0) / distance;
          _scene.bodies.add(new MetaBody1D(_a, _b, f)) ;
          
          start += step ;
        }
      }
      
      _a = _b = null ;
    }
  }  
}