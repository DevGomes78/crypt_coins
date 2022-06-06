import 'package:crypt_coins/src/app/presenter/page/crypt_coin_page.dart';
import 'package:crypt_coins/src/app/presenter/page/cryto_coin_splash_screen.dart';
import 'package:crypt_coins/src/core/crypt_coin_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presenter/controller/crypt_coin_controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CryptCoinController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: const Color(0xFF01E59B),
        title: 'Coins Flutter Mobile Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        home: const CrytoCoinSplashScreen(),
        routes: {
          CryptCoinConstants.crytoCoinPage: (context) => const CryptCoinPage(),
        },
      ),
    );
  }
}
