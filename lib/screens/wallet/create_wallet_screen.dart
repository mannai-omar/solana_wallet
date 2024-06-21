import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana_wallet/screens/wallet/home_wallet_screen.dart';
import 'package:solana_wallet/services/wallet_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  final TextEditingController _walletNameController = TextEditingController();
  final TextEditingController _walletPasswordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Create your wallet',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color(0xfff6f6f6),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            textFields(context),
            const SizedBox(
              height: 35,
            ),
            buttons(),
          ],
        ),
      )),
    );
  }

  CustomButton buttons() {
    return CustomButton(
      text: 'create wallet',
      onTap: () {
        _createWallet;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeWalletScreen()),
        );
      },
      backgroundImage: 'assets/images/send.jpg',
    );
  }

  Column textFields(context) {
    return Column(
      children: [
        CustomTextField(
          controller: _walletNameController,
          hintText: 'wallet\'s name',
          obscureText: false,
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          controller: _walletPasswordController,
          hintText: 'password',
          obscureText: true,
        ),
      ],
    );
  }
  void _createWallet() async {
    try {
      String walletName = _walletNameController.text.trim();
      String userPin = _walletPasswordController.text.trim();
      await createWallet(walletName, userPin);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeWalletScreen()),
      );
    } catch (error) {
      // Handle error
      print('Failed to create wallet: $error');
      // Show error message to the user if needed
      // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create wallet')));
    }
  }

  Future<void> createWallet(String walletName, String userPin) async {
    try {
      final walletProvider = Provider.of<WalletProvider>(context, listen: false);
      await walletProvider.createWallet(walletName, userPin);
    } catch (error) {
      throw Exception('Failed to create wallet: $error');
    }
  }
}
