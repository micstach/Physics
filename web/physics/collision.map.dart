library collision.map ;

import 'scene.dart';
import 'constraint.dart';
import 'body.dart';
import 'particle.dart';
import 'metabody1d.dart';
import 'collision.pair.dart' ;


import '../../math/vec2.dart' ;
import '../../math/box2.dart' ;

class Group
{
  List<Body> _boxParticles = new List<Body>() ;
  List<Body> _bodies = new List<Body>() ;
  Box2 _box = null ;
  
  Box2 get Box => _box;

  void initialize() 
  {
    if (_boxParticles.length > 0)
      _box = new Box2(_boxParticles[0].Position, new Vec2(0.0, 0.0)) ;
    
    for (int i=1; i<_boxParticles.length; i++)
    {
      _box.ExtendWithPoint(_boxParticles[i].Position) ;
    }
    
    _box.Extend(20.0) ;
  }
  
  void addBody(Body body)
  {
    _bodies.add(body) ;
    
    if (body is Particle)
      _boxParticles.add(body) ;
  }
  
  List<Body> get Bodies => _bodies ; 
}

class CollisionMap
{
  Scene _scene = null ;
  
  Map<String, Group> _groups = new Map<String, Group>() ;
  List<CollisionPair> _pairs = null ;
  
  CollisionMap(this._scene)
  {
    _pairs = new List<CollisionPair>() ;
  }

  void AddBody(Body body)
  {
    if (body.GroupName != null)
    {
      Group group = null ;
      if (!_groups.containsKey(body.GroupName))
      {
        group = new Group() ;
        _groups[body.GroupName] = group ;
      }
      else
        group = _groups[body.GroupName] ;
      
      group.addBody(body) ;
    }
    
    for (Body b in _scene.bodies)
    {
      if (b.hashCode == body.hashCode) continue ;
      
      if (b.IsFixed && body.IsFixed) continue ;
      
      if (body.IsRelatedTo(b)) continue ;
      
      if (body.GroupName != null && b.GroupName != null && body.GroupName == b.GroupName) continue ;
      
      _pairs.add(new CollisionPair(b, body)) ;
    }
  }
  
  void RemoveBody(Body body)
  {
    for (int i=_pairs.length-1; i >= 0; i--)
    {
      if (_pairs[i].A == body || _pairs[i].B == body)
      {
        _pairs.removeAt(i) ;
      }
      else if (body is Particle)
      {
        if (_pairs[i].A.IsRelatedTo(body) || _pairs[i].B.IsRelatedTo(body))
        {
          _pairs.removeAt(i) ;
        }          
      }
    }
  }
  
  void AddConstraint(Constraint constraint)
  {
    for (int i=_pairs.length-1; i >= 0; i--)
    {
      if (_pairs[i].IsEqual(constraint))
      {
        _pairs.removeAt(i);
      }
    }
  }

  void RemoveConstraint(Constraint body)
  {
    
  }
  
  void Reset()
  {
    for (CollisionPair pair in _pairs)
    {
      pair.Discard() ;
    }
  }

  List<CollisionPair> get Pairs => _pairs ;
  
  void initializeGroups()
  {
    for (Group group in _groups.values)
    {
      group.initialize() ;
    }
  }
  
  Group GetGroup(String name) => _groups[name] ;
  List<Group> get Groups => _groups.values.toList(growable: false) ;
}