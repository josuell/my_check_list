import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:my_check_list/bloc/check_list_bloc.dart';
import 'package:my_check_list/service/my_to_do_list_service.dart';
import 'package:my_check_list/view/home_page.dart';

void main()async {
  Intl.defaultLocale = 'fr';
  await initializeDateFormatting('fr_FR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return RepositoryProvider(
  create: (context) => MyToDoListService(),
    child: BlocProvider(
  create: (context) => CheckListBloc(),
  child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const HomePage( 'My check list service'),
    ),
),
);
  }
}
