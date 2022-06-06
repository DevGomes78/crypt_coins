import 'package:crypt_coins/src/app/presenter/controller/crypt_coin_controller.dart';
import 'package:crypt_coins/src/core/crypt_coin_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptCoinPage extends StatefulWidget {
  const CryptCoinPage({Key? key}) : super(key: key);

  @override
  State<CryptCoinPage> createState() => _CryptCoinPageState();
}

class _CryptCoinPageState extends State<CryptCoinPage> {
  late final CryptCoinController controller;
  @override
  void initState() {
    controller = context.read<CryptCoinController>();
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CryptCoinController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: CryptCoinConstants.neutralStrongest,
          appBar: _mountAppBar(),
          body: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: CryptCoinConstants.neutralStrong,
                height: 130,
                child: Column(
                  children: [
                    _mountWalletId(controller),
                    const Spacer(),
                    Row(
                      children: [
                        _mountTitleBalanceTotal(),
                        _mountIconVisibility(controller)
                      ],
                    ),
                    _mountTotalBalance(controller),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        _mountListTitleCoins(controller),
                        _mountListCoins(controller)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container _mountListTitleCoins(CryptCoinController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Text(
        controller.cryptCoinModel.message ?? CryptCoinConstants.hyphen,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: CryptCoinConstants.greenDefault,
        ),
      ),
    );
  }

  Widget _mountListCoins(CryptCoinController controller) {
    return Column(
      children: List.generate(
        controller.cryptCoinModel.data?.length ?? 0,
        (index) {
          final coin = controller.cryptCoinModel;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: const Color(0xFF353546),
            child: ListTile(
              leading: Image.network(
                coin.data![index].imageUrl!,
                width: 40,
              ),
              title: Row(
                children: [
                  Text(
                    coin.data![index].currencyName ?? CryptCoinConstants.hyphen,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    controller.formatValue(
                      value: coin.data![index].cotation,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    coin.data![index].symbol ?? CryptCoinConstants.hyphen,
                    style: const TextStyle(
                      color: CryptCoinConstants.neutralMedium,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _mountShowCoinDetails(
                      controller: controller,
                      index: index,
                    ),
                    child: const Text(
                      CryptCoinConstants.seeMore,
                      style: TextStyle(
                        color: CryptCoinConstants.greenDefault,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _mountAppBar() {
    return AppBar(
      leading: const Icon(Icons.menu),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          child: const Icon(Icons.settings),
        ),
      ],
      elevation: 0,
      backgroundColor: const Color(0xFF353546),
    );
  }

  Widget _mountWalletId(CryptCoinController controller) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          const Text(
            CryptCoinConstants.walletId,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(
            controller.cryptCoinModel.walletId ?? CryptCoinConstants.hyphen,
            style: const TextStyle(fontSize: 13, color: Color(0xFF8F8F9A)),
          ),
        ],
      ),
    );
  }

  Widget _mountTitleBalanceTotal() {
    return const Text(
      CryptCoinConstants.totalBalance,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
    );
  }

  Widget _mountIconVisibility(CryptCoinController controller) {
    return IconButton(
      onPressed: controller.visibleBalance,
      icon: controller.isVisibleBalance
          ? const Icon(Icons.visibility_off, size: 22, color: Colors.white)
          : const Icon(Icons.visibility, size: 22, color: Colors.white),
    );
  }

  Container _mountTotalBalance(CryptCoinController controller) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        controller.isVisibleBalance
            ? controller.formatValue(
                value: controller.cryptCoinModel.userBalance,
              )
            : CryptCoinConstants.obscureValue,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _mountShowCoinDetails({
    required CryptCoinController controller,
    required int index,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: const Color(0xFF353546),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    child: Text(
                      controller.cryptCoinModel.data?[index].currencyName ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color(0xFF01E59B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Text(
                  controller.cryptCoinModel.data?[index].details?.about ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
