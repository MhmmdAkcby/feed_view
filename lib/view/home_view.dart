import 'package:feed_view/product/widget/tabbar_view.dart/tabbar_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String appBarName = 'Feed View';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName),
      ),
      body: const Column(
        children: [
          Expanded(child: TabbarView()),
        ],
      ),
    );
  }
}
