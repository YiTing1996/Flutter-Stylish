// Helper: https://app.quicktype.io/
// https://github.com/AppWorks-School/API-Doc/tree/master/Stylish#product-list-api
import 'dart:convert';

MarketingRsp parseHotsFromJson(String str) => MarketingRsp.fromJson(json.decode(str));
ProductsRsp parseListFromJson(String str) => ProductsRsp.fromJson(json.decode(str));
DetailRsp parseSingleFromJson(String str) => DetailRsp.fromJson(json.decode(str));
String convertToJson(ProductsRsp data) => json.encode(data.toJson());

/// For home page row
class MarketingRsp {
    @override // 複寫以印出Object內容
    String toString() {
    return 'MarketingRsp: {data: $data}';
    }

    MarketingRsp({
        required this.data,
    });

    final List<Hots> data;

    factory MarketingRsp.fromJson(Map<String, dynamic> json) => MarketingRsp(
        data: List<Hots>.from(json["data"].map((x) => Hots.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Hots {
    Hots({
        required this.title,
        required this.products,
    });

    final String title;
    final List<Product> products;

    factory Hots.fromJson(Map<String, dynamic> json) => Hots(
        title: json["title"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

/// For home page category column
class ProductsRsp {
  @override
  String toString() {
    return 'ProductsRsp: {data: $data, nextPaging: $nextPaging}';
  }

  ProductsRsp({
    required this.data,
    required this.nextPaging,
  });

  List<Product> data;
  int nextPaging;

  factory ProductsRsp.fromJson(Map<String, dynamic> json) => ProductsRsp(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        nextPaging: json["next_paging"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "next_paging": nextPaging,
      };
}

/// For detail page
class DetailRsp {
  @override
  String toString() {
    return 'DetailRsp: {data: $data}';
  }

  DetailRsp({
    required this.data,
  });

  final Product data;

  factory DetailRsp.fromJson(Map<String, dynamic> json) => DetailRsp(
        data: Product.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Product {
  @override
  String toString() {
    return 'Product: {id: $id, category: $category, title: $title}';
  }

  Product({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.colors,
    required this.sizes,
    required this.variants,
    required this.mainImage,
    required this.images,
  });

  int id;
  String category;
  String title;
  String description;
  int price;
  String texture;
  String wash;
  String place;
  String note;
  String story;
  List<Color> colors;
  List<String> sizes;
  List<Variant> variants;
  String mainImage;
  List<String> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        category: json["category"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        texture: json["texture"],
        wash: json["wash"],
        place: json["place"],
        note: json["note"],
        story: json["story"],
        colors: List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
        sizes: List<String>.from(json["sizes"].map((x) => x)),
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
        mainImage: json["main_image"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "title": title,
        "description": description,
        "price": price,
        "texture": texture,
        "wash": wash,
        "place": place,
        "note": note,
        "story": story,
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "main_image": mainImage,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
  
  /// Get color code list (for detail desc menu)
  List<String> colorCodeList() {
    List<String> codeList = [];
    for (var color in colors) {
      codeList.add(color.code);
    }
    return codeList;
  }
}

class Color {
  Color({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class Variant {
  Variant({
    required this.colorCode,
    required this.size,
    required this.stock,
  });

  String colorCode;
  String size;
  int stock;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        colorCode: json["color_code"],
        size: json["size"],
        stock: json["stock"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "color_code": colorCode,
        "size": size,
        "stock": stock,
      };
}
