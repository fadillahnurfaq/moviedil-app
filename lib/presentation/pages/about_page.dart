import 'package:ditonton_yuk/utils/constants.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                width: 200.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            color: kMikadoYellow,
            child: const Text(
              'Moviedil App adalah aplikasi pencarian film baik itu Movies Ataupun Tv Series yang dapat simpan Watchlist dan Terintegrasi dengan Api Dari https://api.themoviedb.org',
              style: TextStyle(color: Colors.black87, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
