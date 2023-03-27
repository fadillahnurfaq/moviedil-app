import 'package:flutter/material.dart';

import '../../state_util.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAll(page: const HomePage()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
