library collision.map ;

import 'scene.dart';
import 'constraint.dart';
import 'body.dart';
import 'collision.pair.dart' ;

class CollisionMap
{
  Scene _scene = null ;
  
  List<CollisionPair> _pairs = null ;
  
  CollisionMap(this._scene)
  {
    _pairs = new List<CollisionPair>() ;
  }

  void AddBody(Body body)
  {
    for (Body b in _scene.bodies)
    {
      if (b.hashCode == body.hashCode) continue ;
      
      if (b.IsFixed && body.IsFixed) continue ;
      
      if (body.IsRelatedTo(b)) continue ;
      
      _pairs.add(new CollisionPair(b, body)) ;
    }
  }
  
  void RemoveBody(Body body)
  {
    for (CollisionPair pair in _pairs)
    {
      if (pair.A == body || pair.B == body)
      {
        _pairs.remove(pair) ;
        break ;
      }
    }
  }
  
  void AddConstraint(Constraint constraint)
  {
    for (CollisionPair pair in _pairs)
    {
      if (pair.IsEqual(constraint))
      {
        _pairs.remove(pair) ;
        break ;
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
  
  int get DynamicCollisionsCount 
  {
    int result = 0 ;
    for (CollisionPair pair in Pairs)
    {
      result += (pair.GetContact() != null) ? 1 : 0 ;
    }
    return result ;
  }
}