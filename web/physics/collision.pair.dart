library phx.collision.pair;

import 'body.dart' ;
import 'contact.dart' ;
import 'pair.dart' ;

class CollisionPair extends Pair
{
  Contact _contact = null ;
  
  CollisionPair(Body a, Body b) : super(a, b)
  {
    _contact = null ;
  }
  
  void SetContact(Contact contact)
  {
    if (contact == null) return ;
    
    _contact = contact ;
  }
  
  Contact GetContact()
  {
    return _contact ;
  }
  
  void Discard()
  {
    _contact = null ;
  }
}

