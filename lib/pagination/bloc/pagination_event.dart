abstract class FetchDataEvent{}

class FetchPaginationData extends FetchDataEvent{
  int? offset;
  FetchPaginationData({this.offset});
}

