import 'package:flutter/cupertino.dart';
import 'package:pagination_demo/pagination/model/response_model.dart';
import 'package:pagination_demo/pagination/networking/fetch_data.dart';

abstract class FetchDataRepository {
  Future<List<ResponseModel>> getData(int offset);
}

class FetchDataRepositoryImp implements FetchDataRepository {
  @override
  Future<List<ResponseModel>> getData(int offset) async {
    List<ResponseModel> data = await FetchData.getProductsData(10, offset);
    return data;
  }
}
