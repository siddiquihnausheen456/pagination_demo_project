import 'package:dio/dio.dart';
import 'package:pagination_demo/pagination/model/response_model.dart';

class FetchData {
  static Future<List<ResponseModel>> getProductsData(
      int limit, int offset) async {
    Dio dio = Dio();

    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(LogInterceptor());

    List<ResponseModel>? model = [];
    dio.options.queryParameters = {"limit": limit, "offset": offset};

    var response = await dio.get("https://api.escuelajs.co/api/v1/products");
    List data = response.data;

    for (var item in data) {
      model.add(ResponseModel.fromJson(item));
    }

    return model;
  }
}
