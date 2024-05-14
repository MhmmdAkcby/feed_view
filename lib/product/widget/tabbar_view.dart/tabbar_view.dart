import 'package:feed_view/product/widget/feed_view/feed_view.dart';
import 'package:flutter/material.dart';

class TabbarView extends StatefulWidget {
  const TabbarView({super.key});

  @override
  State<TabbarView> createState() => _TabbarViewState();
}

class _TabbarViewState extends TabbarManage<TabbarView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _MyTabbarItemValue.values.length,
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.refresh)),
        bottomNavigationBar: BottomAppBar(
          notchMargin: _notchedValue,
          child: _tabbar(),
        ),
        body: _tabbarView(),
      ),
    );
  }

  TabBar _tabbar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      padding: EdgeInsets.zero,
      onTap: (value) {},
      controller: _tabbarController,
      tabs: _MyTabbarItemValue.values.map((e) => Tab(text: e.name)).toList(),
    );
  }

  TabBarView _tabbarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabbarController,
      children: const [FeedView(), Placeholder()],
    );
  }
}

enum _MyTabbarItemValue { home, profile }

abstract class TabbarManage<T extends StatefulWidget> extends State<T> with TickerProviderStateMixin {
  late final TabController _tabbarController;
  final double _notchedValue = 5;

  @override
  void initState() {
    super.initState();
    _tabbarController = TabController(length: _MyTabbarItemValue.values.length, vsync: this);
  }
}
