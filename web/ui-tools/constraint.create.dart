library constraint.create;

import "../../renderer/renderer.dart" ;
import '../../math/vec2.dart';
import '../physics/particle.dart';

import '../physics/constraint.dart';
import '../physics/constraint.distance.dart';

import 'canvas.tool.dart' ;

import 'dart:html';

class CreateConstraint extends CanvasTool
{
  double _alpha = 1.0 ;
  
  final List<Particle> _particles ;
  final List<Constraint> _constraints ;
  
  Particle _a = null ;
  Particle _b = null ;
  Particle _selected = null ;

  MouseEvent _mouseEvent = null ;
  
  CreateConstraint(CanvasElement canvas, this._particles, this._constraints) : super(canvas)
  {
  }
  
  var _onMouseDownStream = null ;
  var _onMouseUpStream = null ;
  
  void Activate()
  {
    super.Activate() ;
    
    _onMouseDownStream = Canvas.onMouseDown.listen((e) => onMouseDown(e)) ;
    _onMouseUpStream = Canvas.onMouseUp.listen((e) => onMouseUp(e)) ;
  }

  void Deactivate()
  {
    super.Deactivate() ;
    
    _onMouseDownStream.cancel() ;
    _onMouseUpStream.cancel() ;
  }

  void addConstraint()
  {
    if (_a != null && _b != null && _a != _b)
    {
      _constraints.add(new Distance(_a,  _b)) ;
      _a = _b = null ;
    }
  }
  
  void onMouseDown(MouseEvent e)
  {
    Vec2 point = ConvertToWorldCoords(e)  ;

    Particle p = _findClosest(point) ;
    
    if (p != null)
    {
      if (_a == null)
        _a = p ;
      else if (_b == null)
        _b = p ;
    }
  }
  
  Particle _findClosest(Vec2 point)
  {
    Particle closest = null ;
    double distance = double.INFINITY ;
       
    for (Particle p in _particles)
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

  void onKeyDown(KeyboardEvent e)
  {
  }
  
  void onKeyUp(KeyboardEvent e)
  {
  }
  
  void onMouseMove(MouseEvent e)
  {
    super.onMouseMove(e) ;
    
    Vec2 point = ConvertToWorldCoords(e) ;
    
    _selected = _findClosest(point) ;
  }

  void onMouseUp(MouseEvent e)
  {
    addConstraint() ;
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
}