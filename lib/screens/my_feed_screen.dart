import 'package:flutter/material.dart';

import '../helpers/app_theme.dart';
import '../services/news_service.dart';

class MyFeedScreen extends StatefulWidget {
  const MyFeedScreen({super.key});

  @override
  State<MyFeedScreen> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late NewsService newsService;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    newsService = NewsService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold());
  }
}
