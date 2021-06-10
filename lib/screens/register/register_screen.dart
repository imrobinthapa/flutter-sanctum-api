import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Hero(
              tag: 'logo',
              child: Image.asset(
                'images/logo.jpg',
                height: 220,
                width: 220,
              )),
          TextField(),
          TextField(),
          TextField(),
          TextField()
        ],
      ),
    );
  }
}
