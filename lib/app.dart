import 'package:demo/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
          appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.playfairDisplayTextTheme().titleLarge,
              backgroundColor: Colors.white),
          textTheme: GoogleFonts.poppinsTextTheme(),
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            iconColor: MaterialStatePropertyAll(Colors.black),
          )),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
              ),
              contentPadding: EdgeInsets.zero,
              focusColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              )),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
