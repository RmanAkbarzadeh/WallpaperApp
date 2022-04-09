import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/repository/wallpaper_repository.dart';
import 'package:test_app/logic/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:test_app/presentation/pages/home_page.dart';
import 'package:test_app/res/wallpaper_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => WallPaperRepository(),)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => WallpaperBloc(RepositoryProvider.of<WallPaperRepository>(context)),)
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: WallpaperColors.primaryColor,
            primaryColor: WallpaperColors.primaryColor,
            primarySwatch: Colors.orange,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}