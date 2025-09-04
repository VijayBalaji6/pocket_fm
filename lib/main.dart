import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_fm/modules/cart/bloc/cart_bloc.dart';
import 'package:pocket_fm/modules/home/bloc/home_bloc.dart';
import 'package:pocket_fm/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc()..add(FetchProducts()),
          ),
          BlocProvider<CartBloc>(
            create: (BuildContext context) => CartBloc()..add(CartFetchItems()),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.appRoutes,
          debugShowCheckedModeBanner: false,
          title: 'To-Do',
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}
