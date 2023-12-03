import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../helpers/app_theme.dart';
import '../helpers/my_text.dart';
import '../models/article.dart';

class SingleNewsScreen extends StatefulWidget {
  final Article article;
  const SingleNewsScreen({super.key, required this.article});

  @override
  State<SingleNewsScreen> createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
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
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: customTheme.card,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: customTheme.shadowColor,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      LucideIcons.chevronLeft,
                      color: theme.colorScheme.onBackground,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: customTheme.card,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: customTheme.shadowColor,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    LucideIcons.bookmark,
                    color: theme.colorScheme.onBackground,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: customTheme.card,
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                            color: customTheme.shadowColor.withAlpha(120),
                            blurRadius: 24,
                            spreadRadius: 4)
                      ]),
                  child: Column(
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        child: Image(
                          image: NetworkImage(widget.article.imageUrl),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            MyText.titleLarge(
                              widget.article.title,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 600,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.newspaper,
                                          color: theme.colorScheme.onBackground
                                              .withAlpha(160),
                                          size: 28,
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        MyText.bodySmall(widget.article.author,
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                            xMuted: true),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.calendar,
                                          color: theme.colorScheme.onBackground
                                              .withAlpha(160),
                                          size: 28,
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        MyText.bodySmall(
                                            DateFormat('dd MMM, yyyy HH:mm a')
                                                .format(
                                              DateTime.parse(
                                                widget.article.publishedAt,
                                              ),
                                            ),
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 500,
                                            xMuted: true),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: MyText(widget.article.description),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
