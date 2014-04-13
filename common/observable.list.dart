library observablelist ;

class ObservableList<E>
{
  List<E> _items = new List<E>() ;
  
  List<Function> _addObservers = new List<Function>() ;
  List<Function> _removeObservers = new List<Function>() ;
  List<Function> _clearObservers = new List<Function>() ;
  
  List<Function> get AddObservers => _addObservers ;
  List<Function> get RemoveObservers => _removeObservers ;
  List<Function> get ClearObservers => _clearObservers ;
  
  ObservableList()
  {
  }
  
  void add(E value)
  {
    _items.add(value) ;

    for (var observer in _addObservers)
    {
      observer(value) ;
    }
  }

  void addAll(Iterable<E> iterable)
  {
    _items.addAll(iterable) ;

    for (var observer in _addObservers)
    {
      for (var value in iterable)
      {
        observer(value) ;
      }
    }
  }
  
  void remove(E value)
  {
    _items.remove(value) ;
    
    for (var observer in _removeObservers)
    {
      observer(value) ;
    }
  }
  
  void clear()
  {
    _items.clear() ;
    
    for (var observer in _clearObservers)
    {
      observer() ;
    }
  }
  
  int get length => _items.length ;

  Iterator<E> get iterator => _items.iterator ;
  
  E operator [](int index)
  {
    return _items[index] ;
  }
  
  E removeAt(int index)
  {
    return _items.removeAt(index) ;
  }
}
