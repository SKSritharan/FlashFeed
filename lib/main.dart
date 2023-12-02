import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './screens/home_screen.dart';
import './helpers/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      builder: (context, child) {
        return Directionality(
          textDirection: AppTheme.textDirection,
          child: child ?? Container(),
        );
      },
      home: const HomeScreen(),
    );
  }
}
