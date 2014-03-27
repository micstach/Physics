library phx.collision.map ;

import 'constraint.dart';
import 'particle.dart';
import 'collision.pair.dart' ;

class CollisionMap
{
  List<Particle> Particles = null ;
  
  List<Constraint> _constraints = null ;
  
  int _particlesCount = 0 ;
  
  Map<Particle, int> _index = null ;
  Map<int, CollisionPair> _pairs = null ;
  Map<Particle, List<CollisionPair>> _particlePairs = null ;
  
  CollisionMap(List<Particle> particles, List<Constraint> constraints)
  {
    Particles = particles ;
    _constraints = constraints ;
    
    _initialize() ;
  }
  
  void Update(List<Particle> particles, List<Constraint> constraints)
  {
    if (particles.length != _particlesCount)
    {
      Particles = particles ;
      
      _constraints = constraints ;
      
      _initialize() ;
    }
  }
  
  void _initialize()
  {
    _particlesCount = Particles.length ;

    _index = new Map<Particle, int>() ;
    
    _pairs = new Map<int, CollisionPair>() ;
    
    _particlePairs = new Map<Particle, List<CollisionPair>>() ;
    
    // initialize collision pairs
    for (int i=0; i<Particles.length; i++)
    {
      Particle a = Particles[i] ;
      
      for (int j=i+1; j<Particles.length; j++)
      {
        Particle b = Particles[j] ;
        
        if (a.IsFixed && b.IsFixed) continue ;
        
        int index = _getPairIndex(a, b);
        
        if (!_pairs.containsKey(index))
          _pairs[index] = new CollisionPair(a, b) ;
      }
    }

    // remove constraint pairs
    for (Constraint constraint in _constraints)
    {
      int index = _getPairIndex(constraint.A, constraint.B);
      
      _pairs.remove(index) ;
    }
  }
  
  int _getParticleIndex(Particle p)
  {
    if (!_index.containsKey(p))
      _index[p] = _index.values.length ;
    
    return _index[p] ;
  }
  
  void Reset()
  {
    for (CollisionPair pair in _pairs.values)
    {
      pair.Discard() ;
    }
  }

  int _getPairIndex(Particle a, Particle b)
  {
    var idxA = _getParticleIndex(a) ;
    var idxB = _getParticleIndex(b) ;
    
    if (idxB > idxA)
    {
      var tmp = idxB ;
      idxB = idxA ;
      idxA = tmp ;
      
      var c = b ;
      b = a ;
      a = c ;
    }

    // unique index
    return (idxB * Particles.length + idxA) ;    
  }
  
  List<CollisionPair> get Pairs => _pairs.values.toList(growable: false) ;
  
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