

import '../model/response_model.dart';

abstract class FetchDataState{}

class FetchDataInitialState extends FetchDataState{}

class FetchDataSuccessState extends FetchDataState{
  List<ResponseModel> data;

  FetchDataSuccessState(this.data);

}

class FetchDataErrorState extends FetchDataState{
  String? error;
  FetchDataErrorState(this.error);

}