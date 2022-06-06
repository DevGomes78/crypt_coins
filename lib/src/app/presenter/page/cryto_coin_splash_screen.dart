import 'package:crypt_coins/src/core/crypt_coin_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CrytoCoinSplashScreen extends StatefulWidget {
  const CrytoCoinSplashScreen({Key? key}) : super(key: key);

  @override
  State<CrytoCoinSplashScreen> createState() => _CrytoCoinSplashScreenState();
}

class _CrytoCoinSplashScreenState extends State<CrytoCoinSplashScreen> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context)
          .pushReplacementNamed(CryptCoinConstants.crytoCoinPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13141B),
      body: Center(
        child: Lottie.asset('assets/lottiefiles/crypto-coins.json'),
      ),
    );
  }
}
