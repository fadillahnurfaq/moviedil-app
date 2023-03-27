import 'package:ditonton_yuk/presentation/cubit/navigationbar_cubit.dart';
import 'package:ditonton_yuk/presentation/pages/about_page.dart';
import 'package:ditonton_yuk/presentation/pages/movies/movie_list_page.dart';
import 'package:ditonton_yuk/presentation/pages/tv_series/tv_series_list_page.dart';
import 'package:ditonton_yuk/presentation/pages/watchlist_page.dart';
import 'package:ditonton_yuk/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<BottomNavigationBarItem> _bottomNavbarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.movie),
        label: 'Movies',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.live_tv_outlined),
        label: 'TV Series',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.remove_red_eye),
        label: 'Watchlist',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'About',
      ),
    ];

    final List<Widget> _listWidget = [
      const MovieListPage(),
      const TvSeriesListPage(),
      const WatchLisPage(),
      const AboutPage(),
    ];

    return BlocBuilder<NavigationBarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _listWidget[state],
          bottomNavigationBar: SizedBox(
            height: 80.0,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kMikadoYellow,
              items: _bottomNavbarItems,
              currentIndex: state,
              onTap: (value) {
                context.read<NavigationBarCubit>().onBottomNavTapped(value);
              },
            ),
          ),
        );
      },
    );
  }
}
