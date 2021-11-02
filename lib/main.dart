import 'core/constants/colors.dart';
import 'features/agenda/presentation/blocs/entry_page_bloc/entry_page_bloc.dart';
import 'features/agenda/presentation/blocs/headers_bloc/headers_bloc.dart';
import 'home_screen.dart';

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
  // (57	58	62	)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ekşimsi',
      theme: ThemeData(
        primaryColor: MAIN_COLOR,
        primarySwatch: MAIN_COLOR,
        scaffoldBackgroundColor: MAIN_COLOR,
      ),
      home: HomeScreen(),
    );
  }
}
