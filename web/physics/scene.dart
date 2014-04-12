library phxscene ;

import '../../common/observable.list.dart' ;
import '../../renderer/renderer.dart' ;

import "body.dart" ;
import "particle.dart" ;
import "metabody1d.dart" ;
import "constraint.dart" ;
import "constraint.distance.dart" ;
import "collision.map.dart" ; 

class Scene
{
  bool IsRunning = false ;
  
  CollisionMap Collisions = null ;
  ObservableList<Body> _bodies = null ;
  ObservableList<Constraint> _constraints = null ;  
  
  Scene()
  {
    _initialize() ;
  }
  
  Scene.fromJSON(json)
  {
    readJSON(json) ;
  }
  
  void Render(Renderer renderer)
  {
    for (var body in bodies)
    {
      body.Render(renderer) ;
      
      if (!IsRunning)
        renderer.drawVector(body.Velocity * 10.0, body.Position, "rgba(255, 128, 0, 0.5)") ;    
    }
    
    for (var constraint in constraints)
    {
      if (IsRunning)
        constraint.Render(renderer) ;
      else
        constraint.RenderStopped(renderer) ;
    }    
  }
  
  void Clear()
  {
    _initialize() ;
  }
  
  void _initialize()
  {
    Collisions = new CollisionMap(this) ;

    _bodies = new ObservableList<Body>() ;
    _bodies.AddObservers.add(Collisions.AddBody) ;
    _bodies.RemoveObservers.add(Collisions.RemoveBody) ;
    _bodies.RemoveObservers.add(_bodyRemoved) ;
    
    _constraints = new ObservableList<Constraint>() ;
    _constraints.AddObservers.add(Collisions.AddConstraint) ;
    _constraints.RemoveObservers.add(Collisions.RemoveConstraint) ;    
  }
  
  void _bodyRemoved(Body body)
  {
    if (body is Particle)
    {
      for (int i=_bodies.length-1; i>=0; i--)
      {
        if (_bodies[i].IsRelatedTo(body))
        {
          _bodies.removeAt(i) ;
        }
      }
    }
    else if (body is MetaBody1D)
    {
    }
  }
  
  ObservableList<Body> get bodies => _bodies ; 
  ObservableList<Constraint> get constraints => _constraints ; 
  
  toJSON() 
  {
    var jsonBodies = [] ;
    for (var body in _bodies)
    {
      jsonBodies.add(body.toJSON()) ;
    }
    
    var jsonConstraints = [] ;
    for (var constraint in _constraints)
    {
      jsonConstraints.add(constraint.toJSON());
    }
    
    var jsonScene = {'bodies': jsonBodies, 'constraints': jsonConstraints} ;
    
    return jsonScene ;
  }
  
  void readJSON(jsonScene)
  {
    Clear() ;
    
    var jsonBodies = jsonScene['bodies'] ;
    
    Map<int, Body> hashCodeMap = new Map<int, Body>() ;
    
    for (var jsonBody in jsonBodies)
    {
        Body body = null ;  
    
        if (jsonBody['type'] == "particle")
        {
          body = new Particle.fromJSON(jsonBody) ;
          
        }
        else if (jsonBody['type'] == "metabody1d")
        {
          int a = jsonBody['a'] ;
          int b = jsonBody['b'] ;
          double f = jsonBody['f'] ;
          
          body = new MetaBody1D(hashCodeMap[a], hashCodeMap[b], f) ;
        }

        hashCodeMap[jsonBody['hash-code']] = body ;
        
        bodies.add(body) ;
    }
    
    var jsonConstraints = jsonScene['constraints'] ;
    
    for (var jsonConstraint in jsonConstraints)
    {
      var type = jsonConstraint['type'] ;
      
      if (type == "distance")
      {
        int a = jsonConstraint['a'] ;
        int b = jsonConstraint['b'] ;
        
        constraints.add(new ConstraintDistance(hashCodeMap[a], hashCodeMap[b])) ;
      }
    }
  }    
}

