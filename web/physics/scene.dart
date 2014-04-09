library phxscene ;

import '../../renderer/renderer.dart' ;

import "body.dart" ;
import "constraint.dart" ;
import "collision.map.dart" ; 

class ObservableList<E>
{
  List<E> _items = new List<E>() ;
  Function _addObserver = null ;
  Function _removeObserver = null ;
  Function _clearObserver = null ;
  
  ObservableList([Function add = null, Function remove = null, Function clear = null])
  {
    _addObserver = add ;
    _removeObserver = remove ;
    _clearObserver = clear ;
  }
  
  int get length => _items.length ;
  
  void add(E value)
  {
    _items.add(value) ;
    
    if (_addObserver != null)
      _addObserver(value) ;
  }
  
  void remove(E value)
  {
    _items.remove(value) ;
    
    if (_removeObserver != null)
      _removeObserver(value) ;
  }
  
  void clear()
  {
    _items.clear() ;
    
    if (_clearObserver != null)
      _clearObserver() ;
  }
  
  Iterator<E> get iterator => _items.iterator ;
}

class Scene
{
  CollisionMap Collisions = null ;
  ObservableList<Body> _bodies = null ;
  ObservableList<Constraint> _constraints = null ;  
  
  Scene()
  {
    Clear() ;
  }
  
  void Render(Renderer renderer)
  {
    for (var body in bodies)
    {
      body.Render(renderer) ;
      
//      if (!IsRunning)
//        renderer.drawVector(particle.Velocity * 10.0, particle.Position, "rgba(255, 128, 0, 0.5)") ;    
    }
    
    for (var constraint in constraints)
    {
      constraint.Render(renderer) ;
    }    
  }
  
  void Clear()
  {
    Collisions = new CollisionMap(this) ;

    _bodies = new ObservableList<Body>(Collisions.AddBody, Collisions.RemoveBody) ;
    
    _constraints = new ObservableList<Constraint>(Collisions.AddConstraint, Collisions.RemoveConstraint) ;
  }
  
  ObservableList<Body> get bodies => _bodies ; 
  ObservableList<Constraint> get constraints => _constraints ; 
}

