library pxh.simulation ;

import "../math/vec2.dart" ;

import "scene.dart" ;
import "body.dart" ;
import 'collision.map.dart';
import 'collision.pair.dart';
import 'contact.dart';

import 'force.dart' ;
import 'force.gravity.dart' ;
import 'force.damping.dart' ;

import 'constraint.world.dart' ;

import 'dart:core';

class Simulation
{
  bool _breakOnCollision = false ;
  
  get BreakOnCollision => _breakOnCollision ;
  set BreakOnCollision(bool value) => _breakOnCollision = value ;
  
  int _worldWidth ;
  int _worldHeight ;
  
  double _dt = 0.0 ;
  double _e = 0.25 ;

  List<Force> _forces = new List<Force>() ;
  
  CollisionMap _collisionMap = null ;
  
  final Vec2 gravityForce = new Vec2(0.0, -0.0981) ;
  
  Stopwatch _collisionDetectionStopwatch ;
  Stopwatch _resolveCollisionsStopwatch ;
  Stopwatch _runStopwatch ;
  Stopwatch _queryPairsStopwatch ;
  Stopwatch _queryMinPairsStopwatch ;
  
  Simulation() 
  {
    _forces.add(new Gravity(gravityForce)) ;
    
    _forces.add(new Damping(0.9999)) ;
    
    _collisionDetectionStopwatch = new Stopwatch() ;
    _resolveCollisionsStopwatch = new Stopwatch() ;
    _runStopwatch = new Stopwatch() ;
    _queryPairsStopwatch = new Stopwatch() ;
    _queryMinPairsStopwatch = new Stopwatch() ;
  }

  set WorldWidth(int value) => _worldWidth = value ;
  set WorldHeight(int value) => _worldHeight = value ;
  
  bool get IsRunning => _dt > 0.0 ;
  
  void Start({double dt : 0.1}) 
  {
    _dt = dt ;
  }
  
  void Stop()
  {
    _dt = 0.0 ;
  }
       
  void _simulateParticle(Body body)
  {
    // action
    for (var force in _forces)
    {
      force.Apply(body) ;
    }
    
    body.Integrate(_dt) ;
  }
  
  int _detectedCollsionsCount = 0;
  int get DetectedCollisionsCount => _detectedCollsionsCount ; 
  
  void Run(Scene scene)
  {
    if (!IsRunning) 
      return ;
    
    _runStopwatch..reset()..start();
    for (var body in scene.bodies)
    {
      _simulateParticle(body);
    }

    // detect collisions
    _collisionDetectionStopwatch..reset()..start() ;
    Set<CollisionPair> pairs = _detectCollisions(scene) ;
    _collisionDetectionStopwatch.stop();
    
    _detectedCollsionsCount = pairs.length ;
    
    // resolve collisions
    _resolveCollisionsStopwatch..reset()..start() ;
    _resolveCollisions(scene, pairs) ;
    _resolveCollisionsStopwatch.stop();

    for (var body in scene.bodies)
    {
      ResolveWorldConstraints(_e, body, _worldWidth, _worldHeight) ;
    }

    if (_breakOnCollision)
      if (pairs.length > 0) Stop();
    _runStopwatch..stop();
  }
  
  Set<CollisionPair> _detectCollisions(Scene scene)
  {
    _queryPairsStopwatch..reset()..start() ;
    Set<CollisionPair> pairs = new Set<CollisionPair>() ;
    
    // discard collsion pairs based on groups bounding box collisions
    scene.Collisions.initializeGroups() ;
    List<CollisionPair> group_pairs = new List<CollisionPair>() ;
    var groups = scene.Collisions.Groups ;
    for (int i=0; i<groups.length; i++)
    {
      Group gi = groups[i] ; 

      for (int j=i+1; j<groups.length; j++)
      {
        Group gj = groups[j] ; 

        if ((gi.Box * gj.Box))
        {
          for (int bi=0; bi < gi.Bodies.length; bi++)
            for (int bj=0; bj < gj.Bodies.length; bj++)
            {
              if (gi.Bodies[bi].Box * gj.Bodies[bj].Box)
              {
                group_pairs.add(new CollisionPair(gi.Bodies[bi], gj.Bodies[bj])) ;
              }
            }
        }
      }
    }

    Map<Body, List<CollisionPair>> particle_pairs = new Map<Body, List<CollisionPair>>();
    
    for (CollisionPair pair in group_pairs/*scene.Collisions.Pairs*/)
    {
      Contact contact = Contact.Find(pair.A, pair.B) ;
      
      if (contact != null)
      {
        pair.SetContact(contact) ;
        pairs.add(pair) ;
        
        if (!contact.IsResting)
        {
          if (!particle_pairs.containsKey(pair.A))
            particle_pairs[pair.A] = new List<CollisionPair>() ;
          
          if (!particle_pairs.containsKey(pair.B))
            particle_pairs[pair.B] = new List<CollisionPair>() ;

          particle_pairs[pair.A].add(pair) ;
          particle_pairs[pair.B].add(pair) ;
        }
        else
        {
          pairs.add(pair) ;
        }
      }
    }
    _queryPairsStopwatch.stop();
    
    _queryMinPairsStopwatch..reset()..stop();
    for (Body p in particle_pairs.keys)
    {
      if (p.IsFixed) continue ;
      
      List<CollisionPair> p_pairs = particle_pairs[p] ;
      
      CollisionPair min = null ;
      
      for (CollisionPair pair in p_pairs)
      {
        if (min == null)
        {
          if (pair.GetContact() != null)
            min = pair ;
        }
        else
        {
          if (pair.GetContact() != null)
          {
            if (min.GetContact().Dt > pair.GetContact().Dt)
            {
              min.Discard() ;
              min = pair ;
            }
            else
            {
              pair.Discard() ;
            }
          }
        }
      }
      
      if (min != null)
        if (min.GetContact() != null)
          pairs.add(min) ;
    }
    _queryMinPairsStopwatch.stop();

    return pairs ;
  }

  void _resolveCollisions(Scene scene, Set<CollisionPair> contact_pairs)
  {
    // resolve
    // - contact separation
    // - constaints
    for (int i=0; i<5; i++)
    {
      for (CollisionPair pair in contact_pairs)
      {
        if (pair.GetContact() != null)
          pair.GetContact().Separate();
      }

      for (var constraint in scene.constraints)
      {
        constraint.Resolve() ;
      }
    }

    // resolve contact forces
    if (contact_pairs.length > 0)
    {
      for (CollisionPair pair in contact_pairs)
      {
        if (pair.GetContact() != null)
          pair.GetContact().Resolve(_dt, _e) ;
      }
    }
  }
  
  int _convertToPercent(Stopwatch eventTime, Stopwatch overall)
  {
    if (overall.elapsedMilliseconds > 0)
      return ((eventTime.elapsedMilliseconds * 100) ~/ overall.elapsedMilliseconds) ;
    else
      return 0 ;
  }
  
  int get CollisionDetectionTime
  {
    return _convertToPercent(_collisionDetectionStopwatch, _runStopwatch) ;
  } 
  
  int get QueryPairsTime
  {
    return _convertToPercent(_queryPairsStopwatch, _collisionDetectionStopwatch) ;
  }

  int get QueryMinPairsTime
  {
    return _convertToPercent(_queryMinPairsStopwatch, _collisionDetectionStopwatch) ;
  }
  
  int get CollisionResolveTime
  {
    return _convertToPercent(_resolveCollisionsStopwatch, _runStopwatch) ;
  } 
}
