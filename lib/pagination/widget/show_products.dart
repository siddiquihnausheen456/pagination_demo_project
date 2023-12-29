import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pagination_bloc.dart';
import '../bloc/pagination_event.dart';
import '../bloc/pagination_state.dart';
import '../model/response_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  FetchDataBloc? _bloc;
  bool isLoading = false;
  List<ResponseModel>? responseModel = [];
  ScrollController scrollController = ScrollController();
  int offset = 0;
  int totalNumberOfProducts = 49;
  bool isPaginated = false;

  @override
  void initState() {
    _bloc = context.read<FetchDataBloc>();
    _bloc?.add(FetchPaginationData(offset: offset));
    loadNextData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: BlocBuilder<FetchDataBloc, FetchDataState>(
            builder: (BuildContext context, FetchDataState state){
              if(state is FetchDataInitialState){
                isLoading = isPaginated ? false : true;
              }else if(state is FetchDataSuccessState){
                isLoading = false;
                isPaginated = false;
                responseModel?.addAll(state.data);
              }else if(state is FetchDataErrorState){
                isLoading = false;
              }

              return buildUI();
            }
        )


    );
  }


  Widget buildUI(){
    return Stack(
      children: [
        Visibility(
            visible: isLoading,
            child: const Center(child: CircularProgressIndicator())),
        Visibility(
            visible: responseModel?.isNotEmpty ?? false,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:  responseModel?.length ?? 0,
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(responseModel?[index].images?[0] ?? "")),
                        title: Text(responseModel?[index].title ?? "") ,
                        subtitle: Text("\$${responseModel?[index].price}") ,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                        visible: isPaginated,
                        child: const Center(child: CircularProgressIndicator())),
                  )
                ],
              ),
            )
        )
      ],
    );
  }

  loadNextData(){
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels &&
          offset < totalNumberOfProducts){
        offset+=10;
        isLoading = false;
        isPaginated = true;
        _bloc?.add(FetchPaginationData(offset: offset));
      }
    });
  }
}