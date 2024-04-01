class DropDownObject extends Object {
  final int itemId;
  final String itemName;

  DropDownObject({
    required this.itemId,
    required this.itemName,
  });

  bool subItems() {
    return false;
  }

  @override
  String toString() {
    return itemName;
  }

  @override
  bool operator ==(dynamic other) {
    return other != null && itemId == other.itemId;
  }

  @override
  int get hashCode => super.hashCode;
}

class DropDownStrObject extends Object {
  final String itemId;
  final String itemName;

  DropDownStrObject({
    required this.itemId,
    required this.itemName,
  });

  bool subItems() {
    return false;
  }

  @override
  String toString() {
    return itemName;
  }

  @override
  bool operator ==(dynamic other) {
    return other != null && itemId == other.itemId;
  }

  @override
  int get hashCode => super.hashCode;
}
