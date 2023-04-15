import 'package:http/http.dart';
import 'package:flutter_stylish/helper/common_export.dart';

class ProductRepository {
  String baseUrl = 'https://api.appworks-school.tw/api/1.0/';

  Future<List<Product>> getProducts(EndPoint endpoint, {id}) async {
    if (endpoint == EndPoint.all) {
      Response response = await get(Uri.parse(baseUrl + endpoint.rawValue()));
      if (response.statusCode == 200) {
        return parseListFromJson(response.body).data;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } else if (endpoint == EndPoint.hots) {
      Response response = await get(Uri.parse(baseUrl + endpoint.rawValue()));
      if (response.statusCode == 200) {
        List<Product> hots = [];
        for (var hot in parseHotsFromJson(response.body).data) {
          hots.addAll(hot.products); // combine list
        }
        return hots;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } else {
      Response response = await get(Uri.parse(baseUrl + endpoint.rawValue(id: id)));
      if (response.statusCode == 200) {
        final result = parseSingleFromJson(response.body).data;
        List<Product> array = [];
        array.add(result);
        return array;
      } else {
        throw Exception(response.reasonPhrase);
      }
    }
  }
}
