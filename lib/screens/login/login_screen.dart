import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/network/services/auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _deviceData = '';

  @override
  void initState() {
    _emailController.text = 'robin@gmail.com';
    _passwordController.text = 'password';
    getDeviceName();
    super.initState();
  }

  Future<void> getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        _deviceData = androidDeviceInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        _deviceData = data.utsname.machine;
      }
    } catch (e) {
      _deviceData = 'UnknownDevice';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'LOGIN',
          style: TextStyle(fontSize: 16, color: Colors.green),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Image.asset('images/logo.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 0),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter valid email' : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Valid Email Address'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 0),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter password' : null,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password'),
                ),
              ),
              TextButton(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                onPressed: () {},
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    Map credentials = {
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'device_name': _deviceData,
                    };
                    if (_formKey.currentState!.validate()) {
                      Provider.of<Auth>(context, listen: false)
                          .login(credentials: credentials);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'New User? Create Account',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
