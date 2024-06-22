import 'package:flutter/material.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:solana_wallet/services/wallet_provider.dart';
import 'package:solana_wallet/widgets/custom_button.dart';
import 'package:solana_wallet/widgets/custom_text_field.dart';

class Airdrop extends StatefulWidget {
  const Airdrop({super.key});

  @override
  State<Airdrop> createState() => _AirdropState();
}

class _AirdropState extends State<Airdrop> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  void onKeyboardTap(String value) {
    setState(() {
      _amountController.text = _amountController.text + value;
    });
  }

  Future<void> _requestAirdrop() async {
    setState(() {
      _isLoading=true;
    });
    try {
      final String walletAddress = _recipientController.text.trim();
      int amount = int.tryParse(_amountController.text.trim()) ?? 0;
      
      // Call the requestAirdrop method from WalletProvider
      await Provider.of<WalletProvider>(context, listen: false).requestAirdrop(
        walletAddress: walletAddress,
        amount: amount,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Airdrop request successful'),
        ),
      );

      // Pop the screen to go back to the previous screen
      Navigator.pop(context);
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to request airdrop: $error'),
        ),
      );
    }finally{
      setState(() {
      _isLoading=false;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Request Airdrop',
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
              CustomTextField(
                hintText: 'Wallet Address',
                obscureText: false,
                controller: _recipientController,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                hintText: 'Amount',
                obscureText: false,
                controller: _amountController,
              ),
              const SizedBox(height: 20),
              Keyboard(),
              const SizedBox(height: 30),
              Column(
                children: [
                  _isLoading ? const CircularProgressIndicator()
                  :CustomButton(
                    text: 'Send',
                    onTap: _requestAirdrop,
                    backgroundImage: 'assets/images/send.jpg',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container Keyboard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: NumericKeyboard(
        onKeyboardTap: onKeyboardTap,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 28,
        ),
        rightButtonFn: () {
          if (_amountController.text.isEmpty) return;
          setState(() {
            _amountController.text =
                _amountController.text.substring(0, _amountController.text.length - 1);
          });
        },
        rightButtonLongPressFn: () {
          if (_amountController.text.isEmpty) return;
          setState(() {
            _amountController.clear();
          });
        },
        rightIcon: const Icon(
          Icons.backspace_outlined,
          color: Colors.blueGrey,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
