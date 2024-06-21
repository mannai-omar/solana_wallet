import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/User.dart';
import '../../services/auth_provider.dart';
import '../../services/shared_preferences_helper.dart';
import '../../widgets/custom_button.dart';
import 'transfer_balance_screen.dart';

class HomeWalletScreen extends StatelessWidget {
  const HomeWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context, listen: false).user;
    String token = SharedPreferencesHelper.getToken();

    print('Saved Token: $token');
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: ListView(
          children: [
            topBar(),
            const SizedBox(
              height: 20,
            ),
            totalBalanceContainer(context, user),
            const SizedBox(
              height: 10,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CustomButton(
                  text: 'Send',
                  backgroundImage: 'assets/images/blueButton.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TransferBalance()),
                    );
                  },
                )),
                const SizedBox(width: 10,),
                Expanded(
                  child: CustomButton(
                  text: 'Swap',
                  backgroundImage: 'assets/images/redButton.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TransferBalance()),
                    );
                  },
                )
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  Container totalBalanceContainer(BuildContext context, User? user) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          Text(
            '\$${user?.balance ?? 0.00}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            user?.walletAddress != null && user!.walletAddress.length > 10
                ? '${user.walletAddress.substring(0, 5)}...${user.walletAddress.substring(user.walletAddress.length - 5)}'
                : user?.walletAddress ?? 'No wallet address',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Row topBar() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Wallet',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Text('Polygon Mainnet',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.more_vert),
          ],
        )
      ],
    );
  }
}
