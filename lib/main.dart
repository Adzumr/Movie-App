import 'package:flutter/material.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/screens/popular_movies_screen.dart';
import 'package:movie_app/utils/appColors.dart';
import 'package:movie_app/utils/appFonts.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

final appColors = AppColors();
final appFonts = AppFonts();

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<MovieProvider>(create: (_) => MovieProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          home: MovieDetailScreen(),
        );
      },
    );
  }
}
