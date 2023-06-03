import 'package:http/http.dart';
import 'package:flutter_stylish/helper/export/bloc_export.dart';

class Repository {
  String baseUrl = 'https://api.appworks-school.tw/api/1.0/';

  Future<Product> getDetail(int id) async {
      Response response = await get(Uri.parse(baseUrl + EndPoint.details.rawValue(id: id)));
      if (response.statusCode == 200) {
        final result = parseSingleFromJson(response.body).data;
        return result;
      } else {
        throw Exception(response.reasonPhrase);
      }
  }

  Future<List<Product>> getProducts(EndPoint endpoint) async {
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
    }
    return [];
  }
}
