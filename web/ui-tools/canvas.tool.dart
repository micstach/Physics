library canvas.tool ;

import "../../renderer/renderer.dart" ;
import "../../math/vec2.dart" ;

import 'tool.dart' ;
import 'dart:html' ;

abstract class CanvasTool extends Tool
{
  int _gridX = 25 ;
  int _gridY = 25 ;
  
  CanvasElement _canvas ;
  
  MouseEvent _mouseEvent = null ;
  Vec2 _mousePosition = null ;
  
  var _onMouseUpStream = null ;
  var _onMouseDownStream = null ;
  var _onMouseMoveStream = null ;
  var _onMouseLeaveStream = null ;
  var _onClickStream = null ;
  
  CanvasTool(this._canvas) ;
  
  void Activate()
  {
    _onMouseUpStream = Canvas.onMouseUp.listen((e) => _onMouseUp(e)) ;
    _onMouseDownStream = Canvas.onMouseDown.listen((e) => _onMouseDown(e)) ;
    _onMouseMoveStream = _canvas.onMouseMove.listen((e) => _onMouseMove(e)) ;
    _onMouseLeaveStream = _canvas.onMouseLeave.listen((e) => _onMouseLeave(e)) ;
    _onClickStream = Canvas.onClick.listen((e) => _onClick(e)) ;
    
    OnActivate() ;
  }
  
  void Deactivate()
  {
    _onMouseMoveStream.cancel() ;
    _onMouseLeaveStream.cancel() ;
    _onMouseDownStream.cancel() ;
    _onMouseUpStream.cancel() ;
    _onClickStream.cancel() ;
    
    OnDeactivate() ;
  }
  
  void OnActivate() {} 
  void OnDeactivate() {} 
  
  void _onClick(MouseEvent e)
  {
    OnClick(e) ;
  }
  
  void _onMouseUp(MouseEvent e)
  {
    OnMouseUp(e) ;
  }
  
  void _onMouseMove(MouseEvent e)
  {
    _mouseEvent = e ;

    _mousePosition = _getMousePosition(_mouseEvent, _gridX, _gridY);
    
    OnMouseMove(_mouseEvent) ;
  }
  
  void _onMouseDown(MouseEvent e)
  {
    OnMouseDown(_mouseEvent) ;
  }
  
  void _onMouseLeave(MouseEvent e)
  {
    _mouseEvent = null ;
    
    OnMouseLeave() ;
  }
  
  void OnClick(MouseEvent e) {}
  
  void OnMouseMove(MouseEvent e) {}
  
  void OnMouseLeave() {}
  
  void OnMouseDown(MouseEvent e) {}
  
  void OnMouseUp(MouseEvent e) {}

  void Draw(Renderer renderer)
  {
    // render cursor
    if (_mouseEvent != null)
    {
      Vec2 point = _mousePosition ;
      
      String color = "rgba(0, 0, 255, 0.05)" ;
      
      renderer.drawVector(new Vec2(0.0, -point.y), point, color) ;
      renderer.drawVector(new Vec2(0.0, _canvas.clientHeight - point.y), point, color) ;
      renderer.drawVector(new Vec2(-point.x, 0.0), point, color) ;
      renderer.drawVector(new Vec2(_canvas.clientWidth - point.x, 0.0), point, color) ;
    }
  }
  
  Vec2 ConvertToWorldCoords(MouseEvent e)
  {
    return new Vec2(e.layer.x.toDouble(), _canvas.clientHeight - e.layer.y.toDouble()) ;
  }
  
  Vec2 _convertToWorldCoords(int x, int y)
  {
    return new Vec2(x.toDouble(), _canvas.clientHeight - y.toDouble()) ;
  }

  CanvasElement get Canvas => _canvas ; 

  Vec2 get Position => _mousePosition != null ? _mousePosition : null ;
  
  Vec2 _getMousePosition(MouseEvent e, gridX, gridY)
  {
    int x, y ;
    
    if (e.altKey)
    {
      int modx = (e.layer.x % gridX).toInt() ;
      int mody = (e.layer.y % gridY).toInt() ;
      
      if (modx < (gridX / 2))
        x = ((e.layer.x ~/ gridX) * gridX).toInt() ;
      else 
        x = (((e.layer.x ~/ gridX) + 1) * gridX).toInt() ;
  
      if (mody < (gridY / 2))
        y = ((e.layer.y ~/ gridY) * gridY).toInt() ;
      else 
        y = (((e.layer.y ~/ gridY) + 1) * gridY).toInt() ;
    }
    else
    {
      x = e.layer.x ;
      y = e.layer.y ;
    }

    return _convertToWorldCoords(x, y) ;
  }
}