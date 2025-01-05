import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskoopia/common/utils/constants.dart';
import 'package:taskoopia/features/onboarding/pages/onboarding.dart';
import 'package:taskoopia/features/todo/pages/homepage.dart';
import 'package:taskoopia/features/todo/pages/view_not.dart';

import 'features/auth/pages/test_page.dart';
import 'firebase_options.dart';

//com.googleusercontent.apps.1:955203154858:ios:f88d92c3154758866471d3-taskoopia

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme =
  ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final defaultDarkColorScheme =
  ColorScheme.fromSwatch(
    brightness: Brightness.dark,
      primarySwatch: Colors.blue);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp(
              title: 'Taskopia',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppConst.kBkDark,
                colorScheme: lightColorScheme ?? defaultLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme??defaultDarkColorScheme,
                scaffoldBackgroundColor: AppConst.kBkDark,
                useMaterial3: true,
              ),
              themeMode: ThemeMode.dark,
              home: const OnBoarding(),
              //home: users.isEmpty? const OnBoarding(): const HomePage(),
            );
          }
        );
      }
    );
  }
}
