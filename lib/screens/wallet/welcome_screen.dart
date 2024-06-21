import 'package:flutter/material.dart';
import 'package:solana_wallet/widgets/custom_button.dart';
import 'create_wallet_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundWallet.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Welcome to your vible wallet. Your wallet is a gateway to the decentralized web. you can use it to store, send, and receive cryptocurrencies.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Custom button
                    CustomButton(
                      text: 'Create Wallet',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreateWallet()),
                        );
                      },
                      backgroundImage: 'assets/images/send.jpg', 
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
