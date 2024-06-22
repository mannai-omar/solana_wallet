import 'package:flutter/material.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:solana_wallet/services/wallet_provider.dart';
import 'package:solana_wallet/widgets/custom_button.dart';
import 'package:solana_wallet/widgets/custom_text_field.dart';

import '../../models/User.dart';
import '../../services/auth_provider.dart';

class TransferBalance extends StatefulWidget {
  const TransferBalance({super.key});

  @override
  State<TransferBalance> createState() => _TransferBalanceState();
}

class _TransferBalanceState extends State<TransferBalance> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  void onKeyboardTap(String value) {
    setState(() {
      _amountController.text = _amountController.text + value;
    });
  }

  void _getBalanceAndInitiateTransfer(
      String recipientAddress, int amount) async {
    if (!_validateFields()) return;

    setState(() {
      _isLoading = true;
    });
    try {
      int balance = await Provider.of<WalletProvider>(context, listen: false)
          .getWalletBalance('QTA61YXry54KH5S2qJ6kPRtGt7HWtGag27MJq4nN52g');
      if (amount > balance) {
        // Handle insufficient balance case (e.g., show error message)
        print('Insufficient balance');
        return;
      }
      // Proceed with transfer logic
      await Provider.of<WalletProvider>(context, listen: false).transferBalance(
        senderAddress: 'QTA61YXry54KH5S2qJ6kPRtGt7HWtGag27MJq4nN52g',
        recipientAddress: recipientAddress,
        amount: amount,
        userPin: '123456',
      );
      // Show success Snackbar and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transfer successful')),
      );
      Navigator.pop(context); // Pop back to the previous screen
    } catch (error) {
      // Handle error
      print('Error in transfer: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context, listen: false).user;
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
          'Send',
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
                hintText: 'Recipient Address',
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
              keyboard(),
              const SizedBox(height: 30),
              Column(
                children: [
                  _isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Send',
                          onTap: () {
                            int amount =
                                int.tryParse(_amountController.text.trim()) ??
                                    0;
                            // Call method to fetch balance and initiate transfer
                            _getBalanceAndInitiateTransfer(
                              _recipientController.text.trim(),
                              amount,
                            );
                          },
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

  Container keyboard() {
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
            _amountController.text = _amountController.text
                .substring(0, _amountController.text.length - 1);
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

  bool _validateFields() {
    if (_recipientController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipient address cannot be empty!')),
      );
      return false;
    }

    if (_amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount cannot be empty!')),
      );
      return false;
    }

    int? amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount!')),
      );
      return false;
    }

    return true;
  }
}
