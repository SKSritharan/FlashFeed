import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../helpers/app_theme.dart';
import '../helpers/loading_effect.dart';
import '../helpers/my_text.dart';
import '../models/article.dart';
import '../services/news_service.dart';

class HeadlineScreen extends StatefulWidget {
  const HeadlineScreen({super.key});

  @override
  State<HeadlineScreen> createState() => _HeadlineScreenState();
}

class _HeadlineScreenState extends State<HeadlineScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late NewsService newsService;
  late String today;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    today = DateFormat('dd MMM, yyyy').format(DateTime.now());
    newsService = NewsService();
  }

  Future<List<Article>> fetchTopHeadlines() async {
    try {
      return await newsService.getTopHeadlines();
    } catch (e) {
      debugPrint('Error fetching headlines: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    MyText.bodyMedium(today,
                        color: theme.colorScheme.onBackground, fontWeight: 400)
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: MyText.headlineMedium("Breaking News",
                      color: theme.colorScheme.onBackground, fontWeight: 800),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                        color: customTheme.card,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                              color: customTheme.shadowColor.withAlpha(120),
                              blurRadius: 24,
                              spreadRadius: 4)
                        ]),
                    child: Column(
                      children: [
                        const ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          child: Image(
                            image: AssetImage('./assets/images/all-1.jpg'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              MyText.titleLarge(
                                  "14 Passengers Banned By Nona Airlines After bad Behaviour",
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 600),
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: Row(
                                  children: [
                                    const ClipRRect(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(14)),
                                      child: Image(
                                        image: AssetImage(
                                            './assets/images/all-2.jpg'),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    MyText.bodySmall(
                                      "John smith",
                                      color: theme.colorScheme.onBackground,
                                      fontWeight: 600,
                                      xMuted: true,
                                    ),
                                    Expanded(child: Container()),
                                    MyText.bodySmall("10 Jan, 2020",
                                        color: theme.colorScheme.onBackground,
                                        fontWeight: 500,
                                        xMuted: true),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder<List<Article>>(
                  future: fetchTopHeadlines(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingEffect.getFavouriteLoadingScreen(context);
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No headlines available.');
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, index) {
                            Article article = snapshot.data![index];
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(top: 24),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      child: Image(
                                        image: NetworkImage(article.imageUrl),
                                        width: 90,
                                        height: 72,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          MyText.bodyMedium(
                                            article.title,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  LucideIcons.calendar,
                                                  color: theme
                                                      .colorScheme.onBackground
                                                      .withAlpha(160),
                                                  size: 16,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                MyText.labelSmall(
                                                  DateFormat('dd MMM, yyyy')
                                                      .format(DateTime.parse(
                                                          article.publishedAt)),
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  letterSpacing: 0,
                                                  muted: true,
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Icon(
                                                  LucideIcons.newspaper,
                                                  color: theme
                                                      .colorScheme.onBackground
                                                      .withAlpha(160),
                                                  size: 16,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                MyText.labelSmall(
                                                  article.author.length > 15
                                                      ? '${article.author.substring(0, 15)}...'
                                                      : article.author,
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  letterSpacing: 0,
                                                  muted: true,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
