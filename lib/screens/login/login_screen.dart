import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana_wallet/screens/wallet/home_wallet_screen.dart';
import 'package:solana_wallet/screens/wallet/welcome_screen.dart';
import '../../models/User.dart';
import '../../services/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'forgot_password.dart';
import 'signup_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Call the login method from AuthProvider
      await Provider.of<AuthProvider>(context, listen: false).login(
        _usernameController.text,
        _passwordController.text,
      );

      // Get the user object after successful login
      User? user = Provider.of<AuthProvider>(context, listen: false).user;
      user!.hasWallet=false;
      if (user != null) {
        if (user.hasWallet ?? false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeWalletScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        }
      } 
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$error'),
      ),
    );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        leading: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        backgroundColor: const Color(0xfff6f6f6),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            logoImage(context),
            textFields(),
            const SizedBox(
              height: 35,
            ),
            buttons(),
            Row(
              children: [
                const Text('Don\'t have an account?'),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.amber[700]),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }

  Column buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _isLoading
            ? CircularProgressIndicator()
            : CustomButton(
                text: 'Login',
                onTap: _login,
                backgroundImage: 'assets/images/login.jpg',
              ),
        const SizedBox(height: 20.0),
        const Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'OR',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        CustomButton(
          text: 'Sign in with Google',
          onTap: () {
            // Handle sign in with Google action
          },
          backgroundImage: 'assets/images/signin.jpg',
          icon: Icons.login,
        ),
      ],
    );
  }

  Column textFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          controller: _usernameController,
          hintText: 'Enter your username',
          obscureText: false,
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          controller: _passwordController,
          hintText: 'Enter your password',
          obscureText: true,
        ),
        const SizedBox(height: 16.0),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPassword()),
              );
            },
            child: const Text('Forgot Password?')),
      ],
    );
  }

  SizedBox logoImage(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Image.asset('assets/images/logo.png'));
  }
}
