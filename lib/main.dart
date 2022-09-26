import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/font_styles.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sizer/sizer.dart';

import 'controllers/movie_controller.dart';
import 'utils/app_images.dart';

void main() async {
  // ErrorWidget.builder = (FlutterErrorDetails details) => const ErrorScreen();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

final appColors = AppColors();
final appFonts = FontStyles();
final appImages = AppImages();

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<MovieProvider>(create: (_) => MovieProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: ThemeData(
              textTheme: TextTheme(
            bodyText2: GoogleFonts.roboto(
              fontSize: 14.sp,
              color: appColors.whiteColor,
            ),
          )),
          home: const HomeScreen(),
        );
      },
    );
  }
}
