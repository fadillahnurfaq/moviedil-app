import 'package:ditonton_yuk/presentation/blocs/movies/search/search_movies_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/search/search_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/cubit/navigationbar_cubit.dart';
import 'package:ditonton_yuk/presentation/pages/splash_page.dart';
import 'package:ditonton_yuk/state_util.dart';
import 'package:ditonton_yuk/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;
import 'utils/http_ssl_painning.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<NavigationBarCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchTvSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton Yuk',
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.navigatorKey,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
