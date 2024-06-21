import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
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
        title: const Text('Create your username',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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
      text: 'Continue',
      onTap: () {
        // Handle login action
      },
      backgroundImage: 'assets/images/send.jpg',
    );
  }

  CustomTextField textFields(context) {
    return CustomTextField(
      controller: _usernameController,
      hintText: 'Username',
      obscureText: false,
    );
  }
}
