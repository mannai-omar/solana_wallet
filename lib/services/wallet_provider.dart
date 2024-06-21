import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solana_wallet/constants.dart';
import 'package:solana_wallet/models/Wallet.dart';

import 'shared_preferences_helper.dart';

class WalletProvider with ChangeNotifier {
  String? _token;
  Wallet? _wallet;

  WalletProvider() {
    _token = SharedPreferencesHelper.getToken();
  }

  // Method to create a wallet
  Future<Wallet> createWallet(String walletName, String userPin) async {
    final url = Uri.parse('$baseUri/solana/wallet/create');

    try {
      final response = await http.post(
        url,
        headers: {
          'Flic-Token': _token!,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'wallet_name': walletName,
          'user_pin': userPin,
          'network': 'devnet',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _wallet = Wallet.fromJson(responseData);
        notifyListeners();
        print(_wallet!.publicKey);
        return _wallet!;
      } else {
        throw Exception('Failed to create wallet');
      }
    } catch (error) {
      throw Exception('Failed to create wallet: $error');
    }
  }

  Future<int> getWalletBalance(String walletAddress) async {
    final url = Uri.parse(
        '$baseUri/solana/wallet/balance?network=devnet&wallet_address=QTA61YXry54KH5S2qJ6kPRtGt7HWtGag27MJq4nN52g');

    try {
      final response = await http.get(
        url,
        headers: {
          'Flic-Token': _token!,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['balance'];
      } else {
        print(
            'Failed to fetch wallet balance. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch wallet balance');
      }
    } catch (error) {
      print('Failed to fetch wallet balance: $error');
      throw Exception('Failed to fetch wallet balance: $error');
    }
  }

  Future<void> transferBalance({
    required String senderAddress,
    required String recipientAddress,
    required int amount,
    required String userPin,
  }) async {
    final url = Uri.parse('$baseUri/solana/wallet/transfer');

    try {
      final response = await http.post(
        url,
        headers: {
          'Flic-Token':
              'flic_60347fa9051a7c5e96431d9edbf61a562a25a47da43689bdcb40170c89d9415c',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "recipient_address": recipientAddress,
          "network": "devnet",
          "sender_address": senderAddress,
          "amount": amount,
          "user_pin": userPin
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Transfer successful: $responseData');
      } else if (response.statusCode == 302) {
        // Handle redirection manually if needed
        String? redirectUrl = response.headers['location'];
        print('Redirecting to: $redirectUrl');
      } else {
        throw Exception(
            'Failed to transfer balance. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to transfer balance: $error');
    }
  }
}
