import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../helpers/app_theme.dart';
import '../helpers/loading_effect.dart';
import '../helpers/my_text.dart';
import '../helpers/my_text_style.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import '../widgets/my_container.dart';
import './single_news_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late CustomTheme customTheme;
  late ThemeData theme;
  late NewsService newsService;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    newsService = NewsService();
    searchController = TextEditingController(text: '');
  }

  Future<List<Article>> fetchSearchResult() async {
    if (searchController.text != '') {
      try {
        return await newsService.getEverything(query: searchController.text);
      } catch (e) {
        debugPrint('Error fetching headlines: $e');
        return [];
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).padding.top + 20, 20, 0),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchController.text = value.toString();
                    });
                  },
                  style:
                      MyTextStyle.titleSmall(letterSpacing: 0, fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: MyTextStyle.titleSmall(
                        letterSpacing: 0, fontWeight: 500),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: theme.colorScheme.background,
                    prefixIcon: Icon(
                      LucideIcons.search,
                      size: 22,
                      color: theme.colorScheme.onBackground.withAlpha(150),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(right: 16),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              const SizedBox(width: 20),
              MyContainer.bordered(
                onTap: fetchSearchResult,
                padding: const EdgeInsets.all(12),
                child: Icon(
                  LucideIcons.search,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ),
            ],
          ),
          searchController.text != ''
              ? Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: MyText.bodyMedium(
                    "Result for \"${searchController.text}\"",
                    fontWeight: 600,
                  ),
                )
              : const SizedBox(),
          searchController.text != ''
              ? FutureBuilder<List<Article>>(
                  future: fetchSearchResult(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingEffect.getSearchLoadingScreen(context);
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No headlines available.'));
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: ListView.builder(
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
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
