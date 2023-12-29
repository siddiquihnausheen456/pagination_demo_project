import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_demo/pagination/bloc/pagination_bloc.dart';
import 'package:pagination_demo/pagination/bloc/pagination_repo.dart';
import 'package:pagination_demo/pagination/widget/show_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => FetchDataBloc(FetchDataRepositoryImp()),
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}


