import 'package:flutter/material.dart';

class LazyDashboardTabStack extends StatefulWidget {
  final int index;
  final List<WidgetBuilder> pageBuilders;
  final Object? cacheKey;

  const LazyDashboardTabStack({
    super.key,
    required this.index,
    required this.pageBuilders,
    this.cacheKey,
  }) : assert(pageBuilders.length > 0);

  @override
  State<LazyDashboardTabStack> createState() => _LazyDashboardTabStackState();
}

class _LazyDashboardTabStackState extends State<LazyDashboardTabStack> {
  late List<Widget?> _pages;

  @override
  void initState() {
    super.initState();
    _pages = List<Widget?>.filled(widget.pageBuilders.length, null);
  }

  @override
  void didUpdateWidget(covariant LazyDashboardTabStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cacheKey != widget.cacheKey) {
      _pages = List<Widget?>.filled(widget.pageBuilders.length, null);
    } else if (oldWidget.pageBuilders.length != widget.pageBuilders.length) {
      _pages = List<Widget?>.generate(
        widget.pageBuilders.length,
        (index) => index < _pages.length ? _pages[index] : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = widget.index.clamp(0, widget.pageBuilders.length - 1);
    _pages[selectedIndex] ??= widget.pageBuilders[selectedIndex](context);

    return IndexedStack(
      index: selectedIndex,
      children: List<Widget>.generate(
        _pages.length,
        (index) => _pages[index] ?? const SizedBox.shrink(),
      ),
    );
  }
}
