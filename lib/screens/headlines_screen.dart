import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../helpers/app_theme.dart';
import '../helpers/my_text.dart';

class HeadlinesScreen extends StatefulWidget {
  const HeadlinesScreen({super.key});

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
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
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  MyText.bodyMedium("19 Jan, 2020",
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
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
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
                                  MyText.bodySmall("John smith",
                                      color: theme.colorScheme.onBackground,
                                      fontWeight: 600,
                                      xMuted: true),
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
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      const ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image(
                          image: AssetImage('./assets/images/all-1.jpg'),
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
                                "An illinois town fights to save its power plant",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 600),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.calendar,
                                    color: theme.colorScheme.onBackground
                                        .withAlpha(160),
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  MyText.labelSmall("Jan 10, 2021",
                                      color: theme.colorScheme.onBackground,
                                      letterSpacing: 0,
                                      muted: true),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Icon(
                                    LucideIcons.clock,
                                    color: theme.colorScheme.onBackground
                                        .withAlpha(160),
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  MyText.labelSmall("10 min read",
                                      color: theme.colorScheme.onBackground,
                                      letterSpacing: 0,
                                      muted: true),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      const ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image(
                          image: AssetImage('./assets/images/all-3.jpg'),
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
                                "An illinois town fights to save its power plant",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 600),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.calendar,
                                    color: theme.colorScheme.onBackground
                                        .withAlpha(160),
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  MyText.labelSmall("Jan 10, 2021",
                                      color: theme.colorScheme.onBackground,
                                      letterSpacing: 0,
                                      muted: true),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Icon(
                                    LucideIcons.clock,
                                    color: theme.colorScheme.onBackground
                                        .withAlpha(160),
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  MyText.labelSmall("10 min read",
                                      color: theme.colorScheme.onBackground,
                                      letterSpacing: 0,
                                      muted: true),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Row(
                  children: [
                    const ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Image(
                        image: AssetImage('./assets/images/all-4.jpg'),
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
                              "An illinois town fights to save its power plant",
                              color: theme.colorScheme.onBackground,
                              fontWeight: 600),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.calendar,
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(160),
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                MyText.labelSmall("Jan 10, 2021",
                                    color: theme.colorScheme.onBackground,
                                    letterSpacing: 0,
                                    muted: true),
                                const SizedBox(
                                  width: 16,
                                ),
                                Icon(
                                  LucideIcons.clock,
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(160),
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                MyText.labelSmall("10 min read",
                                    color: theme.colorScheme.onBackground,
                                    letterSpacing: 0,
                                    muted: true),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
