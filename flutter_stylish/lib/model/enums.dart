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

enum EndPoint { all, details, hots }
extension EndPointExtension on EndPoint {
  String rawValue({int id = 0}) {
    switch (this) {
      case EndPoint.hots:
        return "marketing/hots";
      case EndPoint.all:
        return "products/all";
      case EndPoint.details:
        return "products/details?id=$id";
    }
  }
}