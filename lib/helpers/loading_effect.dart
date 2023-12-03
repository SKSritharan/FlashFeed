import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

import './app_theme.dart';

class LoadingThemeData {
  late Color shimmerBaseColor, shimmerHighlightColor;
  LoadingThemeData(
      {this.shimmerBaseColor = const Color(0xFFF5F5F5),
      this.shimmerHighlightColor = const Color(0xFFE0E0E0)});

  static get theme => AppTheme.themeType == ThemeType.light
      ? LoadingThemeData.light
      : LoadingThemeData.dark;

  static get light => LoadingThemeData(
      shimmerBaseColor: const Color(0xFFF5F5F5),
      shimmerHighlightColor: const Color(0xFFE0E0E0));
  static get dark => LoadingThemeData(
      shimmerBaseColor: const Color(0xFF1a1a1a),
      shimmerHighlightColor: const Color(0xFF454545));
}

class LoadingEffect {
  static Widget getSearchLoadingScreen(BuildContext context,
      {int itemCount = 4}) {
    LoadingThemeData theme = LoadingThemeData.theme;
    Widget singleLoading = Shimmer.fromColors(
        baseColor: theme.shimmerBaseColor,
        highlightColor: theme.shimmerHighlightColor,
        child: Container(
          height: 96,
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 56,
                width: 56,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 8,
                              color: Colors.grey,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                LucideIcons.heart,
                                color: theme.shimmerBaseColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 8,
                              color: Colors.grey,
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 8,
                              color: Colors.grey,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  height: 8, width: 36, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));

    List<Widget> list = [];
    for (int i = 0; i < itemCount; i++) {
      list.add(Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: singleLoading));
    }
    return Column(
      children: list,
    );
  }

  static Widget getHeadlinesLoadingScreen(BuildContext context,
      {int itemCount = 4}) {
    LoadingThemeData theme = LoadingThemeData.theme;

    Widget singleLoading = Shimmer.fromColors(
      baseColor: theme.shimmerBaseColor,
      highlightColor: theme.shimmerHighlightColor,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: theme.shimmerBaseColor,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: theme.shimmerBaseColor.withAlpha(120),
              blurRadius: 24,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              color: theme.shimmerBaseColor,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 24,
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: theme.shimmerBaseColor,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        color: theme.shimmerBaseColor,
                      ),
                      const SizedBox(width: 16),
                      Container(
                        height: 16,
                        width: MediaQuery.of(context).size.width * 0.4,
                        color: theme.shimmerBaseColor,
                      ),
                      Expanded(child: Container()),
                      Container(
                        height: 16,
                        width: 48,
                        color: theme.shimmerBaseColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    List<Widget> list = [];
    for (int i = 0; i < itemCount; i++) {
      list.add(singleLoading);
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }

  static Widget getFavouriteLoadingScreen(BuildContext context,
      {int itemCount = 4}) {
    LoadingThemeData theme = LoadingThemeData.theme;

    Widget singleLoading = Shimmer.fromColors(
        baseColor: theme.shimmerBaseColor,
        highlightColor: theme.shimmerHighlightColor,
        child: Container(
          height: 96,
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 56,
                width: 56,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 8,
                              color: Colors.grey,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                LucideIcons.heart,
                                color: theme.shimmerBaseColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 8,
                              color: Colors.grey,
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 8,
                              color: Colors.grey,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  height: 8, width: 36, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));

    List<Widget> list = [];
    for (int i = 0; i < itemCount; i++) {
      list.add(Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: singleLoading));
    }
    return Column(
      children: list,
    );
  }
}
