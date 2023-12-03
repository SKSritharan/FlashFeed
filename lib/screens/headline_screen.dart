import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../helpers/app_theme.dart';
import '../helpers/loading_effect.dart';
import '../helpers/my_text.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import './single_news_screen.dart';

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
  late Future<List<Article>> topHeadlinesFuture;
  int pageSize = 15;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    today = DateFormat('dd MMM, yyyy').format(DateTime.now());
    newsService = NewsService();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      pageSize = pageSize + 10;

      _fetchMoreArticles();
    }
  }

  Future<List<Article>> _fetchMoreArticles() async {
    try {
      return await newsService.getTopHeadlines(pageSize: pageSize);
    } catch (e) {
      debugPrint('Error fetching headlines: $e');
      return [];
    }
  }

  Future<List<Article>> fetchTopHeadlines() async {
    try {
      return await newsService.getTopHeadlines(pageSize: 10);
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
                FutureBuilder<List<Article>>(
                  future: fetchTopHeadlines(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingEffect.getHeadlinesLoadingScreen(
                                context);
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No headlines available.'),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, index) {
                            Article article = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleNewsScreen(
                                      article: article,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 24, right: 16),
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: customTheme.card,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: customTheme.shadowColor
                                          .withAlpha(120),
                                      blurRadius: 24,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(24)),
                                      child: Image.network(
                                        article.imageUrl,
                                        fit: BoxFit.cover,
                                        height: 150,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText.titleLarge(
                                            article.title.length > 80
                                                ? '${article.title.substring(0, 80)}...'
                                                : article.title,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  LucideIcons.newspaper,
                                                  color: theme
                                                      .colorScheme.onBackground
                                                      .withAlpha(160),
                                                  size: 28,
                                                ),
                                                const SizedBox(width: 16),
                                                MyText.bodySmall(
                                                  article.author.length > 15
                                                      ? '${article.author.substring(0, 15)}...'
                                                      : article.author,
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  fontWeight: 600,
                                                  xMuted: true,
                                                ),
                                                Expanded(child: Container()),
                                                MyText.bodySmall(
                                                  DateFormat('dd MMM, yyyy')
                                                      .format(
                                                    DateTime.parse(
                                                        article.publishedAt),
                                                  ),
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  fontWeight: 500,
                                                  xMuted: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: MyText.headlineSmall("All the articles",
                      color: theme.colorScheme.onBackground, fontWeight: 800),
                ),
                NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      _fetchMoreArticles();
                    }
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _fetchMoreArticles();
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder<List<Article>>(
                        future: _fetchMoreArticles(),
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingEffect.getFavouriteLoadingScreen(
                                context);
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No headlines available.'),
                            );
                          } else {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (ctx, index) {
                                  Article article = snapshot.data![index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SingleNewsScreen(
                                            article: article,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 24),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16),
                                            ),
                                            child: Image(
                                              image: NetworkImage(
                                                  article.imageUrl),
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
                                                  article.title.length > 80
                                                ? '${article.title.substring(0, 80)}...'
                                                : article.title,
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  fontWeight: 600,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        LucideIcons.calendar,
                                                        color: theme.colorScheme
                                                            .onBackground
                                                            .withAlpha(160),
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      MyText.labelSmall(
                                                        DateFormat(
                                                                'dd MMM, yyyy')
                                                            .format(DateTime
                                                                .parse(article
                                                                    .publishedAt)),
                                                        color: theme.colorScheme
                                                            .onBackground,
                                                        letterSpacing: 0,
                                                        muted: true,
                                                      ),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      Icon(
                                                        LucideIcons.newspaper,
                                                        color: theme.colorScheme
                                                            .onBackground
                                                            .withAlpha(160),
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      MyText.labelSmall(
                                                        article.author.length >
                                                                15
                                                            ? '${article.author.substring(0, 15)}...'
                                                            : article.author,
                                                        color: theme.colorScheme
                                                            .onBackground,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
