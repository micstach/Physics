library collision.map ;

import 'scene.dart';
import 'constraint.dart';
import 'body.dart';
import 'particle.dart';
import 'metabody1d.dart';
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