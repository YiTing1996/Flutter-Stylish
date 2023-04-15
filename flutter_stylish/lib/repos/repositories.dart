import 'package:http/http.dart';
import 'package:flutter_stylish/helper/common_export.dart';

class ProductRepository {
  String baseUrl = 'https://api.appworks-school.tw/api/1.0/products/';

  Future<List<Detail>> getProducts(EndPoint endpoint, {id}) async {
    if (endpoint == EndPoint.all) {
      Response response = await get(Uri.parse(baseUrl + endpoint.rawValue()));
      if (response.statusCode == 200) {
        return parseListFromJson(response.body).data;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } else {
      Response response = await get(Uri.parse(baseUrl + endpoint.rawValue(id: id)));
      if (response.statusCode == 200) {
        final result = parseSingleFromJson(response.body).data;
        List<Detail> array = [];
        array.add(result);
        return array;
      } else {
        throw Exception(response.reasonPhrase);
      }
    }
  }
}
