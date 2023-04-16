enum CategoryType { women, men, accessories }
extension CategoryTypeExtension on CategoryType {
  String rawValue() {
    switch (this) {
      case CategoryType.men:
        return "men";
      case CategoryType.women:
        return "women";
      case CategoryType.accessories:
        return "accessories";
    }
  }
}

enum EndPoint { all, details }
extension EndPointExtension on EndPoint {
  String rawValue({String id = ""}) {
    switch (this) {
      case EndPoint.all:
        return "all";
      case EndPoint.details:
        return "details?id=$id";
    }
  }
}