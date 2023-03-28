import 'package:ditonton_yuk/presentation/pages/tv_series/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';

import 'movies/watchlist_movies_page.dart';

class WatchLisPage extends StatefulWidget {
  const WatchLisPage({super.key});

  @override
  State<WatchLisPage> createState() => _WatchLisPageState();
}

class _WatchLisPageState extends State<WatchLisPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _listTabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  final List<Widget> _listTabs = [
    const Text('Movies'),
    const Text(
      'TV Series',
    ),
  ];

  final List<Widget> _listWidget = [
    const WatchlistMoviesPage(),
    const WatchListTvSeriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watchlist"),
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(16.0),
          tabs: _listTabs,
          controller: _tabController,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _listWidget),
    );
  }
}
