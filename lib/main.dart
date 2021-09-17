import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/blocs/entry_page_bloc/entry_page_bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/blocs/headers_bloc/headers_bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

void main() {
  init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<HeadersBloc>(
        create: (context) => sl<HeadersBloc>(),
      ),
      BlocProvider<EntryPageBloc>(
        create: (context) => sl<EntryPageBloc>(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ekşimsi',
      theme: ThemeData(
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: HomeScreen(),
    );
  }
}
