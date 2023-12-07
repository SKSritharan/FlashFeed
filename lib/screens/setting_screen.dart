import 'package:flutter/material.dart';

import '../helpers/app_theme.dart';
import '../helpers/my_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.fill),
                ),
              ),
              const SizedBox(height: 20),
              MyText.titleMedium("V 1.0.0",
                  fontWeight: 600, color: theme.colorScheme.onBackground),
            ],
          ),
        ),
      ),
    );
  }
}
