import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana_wallet/screens/login/login_screen.dart';
import 'package:solana_wallet/services/auth_provider.dart';
import 'package:solana_wallet/services/shared_preferences_helper.dart';
import 'package:solana_wallet/services/wallet_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Solana Wallet',
        home: Login(),
      ),
    );
  }
}
