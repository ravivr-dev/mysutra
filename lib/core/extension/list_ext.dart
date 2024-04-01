


extension ListExt on List<Object>?{

  Object? get firstElement {
    this != null && this!.isNotEmpty? this!.first : null;
    return null;
  }



}