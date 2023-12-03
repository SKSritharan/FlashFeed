import 'package:flutter/material.dart';

import '../helpers/app_theme.dart';
import '../helpers/my_text.dart';
import '../models/source.dart';
import '../services/news_service.dart';

class NewsSourceScreen extends StatefulWidget {
  const NewsSourceScreen({super.key});

  @override
  State<NewsSourceScreen> createState() => _NewsSourceScreenState();
}

class _NewsSourceScreenState extends State<NewsSourceScreen> {
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

  Future<List<Source>> _fetchMoreSources() async {
    try {
      return await newsService.getNewsSources(pageSize: pageSize);
    } catch (e) {
      debugPrint('Error fetching headlines: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          MyText.titleSmall("Good morning",
              color: theme.colorScheme.onBackground,
              fontWeight: 600,
              xMuted: true),
          MyText.headlineMedium("Denish",
              color: theme.colorScheme.onBackground, fontWeight: 600),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: MyText.bodyMedium("Your daily read ",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
                muted: true),
          ),
          FutureBuilder<List<Source>>(
            future: _fetchMoreSources(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
                      Source source = snapshot.data![index];
                      return _singleNewsSource(
                        name: source.name,
                        description: source.description,
                        url: source.url,
                        category: source.category,
                        language: source.language,
                        country: source.country,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      )),
    );
  }

  _singleNewsSource({
    required String name,
    required String description,
    required String url,
    required String category,
    required String language,
    required String country,
  }) {
    return InkWell(
      onTap: () {
        // Handle source selection
      },
      child: Container(
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.headlineMedium(
              name,
              color: theme.colorScheme.onBackground,
              fontWeight: 600,
            ),
            const SizedBox(height: 8),
            MyText.bodyMedium(
              description,
              color: theme.colorScheme.onBackground,
              xMuted: true,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                MyText.bodyMedium(
                  'Category: $category',
                  color: theme.colorScheme.onBackground,
                  xMuted: true,
                ),
                const SizedBox(width: 16),
                MyText.bodyMedium(
                  'Language: $language',
                  color: theme.colorScheme.onBackground,
                  xMuted: true,
                ),
                const SizedBox(width: 16),
                MyText.bodyMedium(
                  'Country: $country',
                  color: theme.colorScheme.onBackground,
                  xMuted: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle button press (e.g., navigate to the source's website)
              },
              style: ElevatedButton.styleFrom(
                primary: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: MyText('Visit Website', color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
