import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
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
          ],
        ),
      )),
    );
  }

  CustomButton buttons() {
    return CustomButton(
      text: 'Send',
      onTap: () {
        // Handle login action
      },
      backgroundImage: 'assets/images/send.jpg',
    );
  }

  Column textFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          controller: _emailController,
          hintText: 'Email',
          obscureText: false,
        ),
      ],
    );
  }

  SizedBox logoImage(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Image.asset('assets/images/logo.png'));
  }
}
