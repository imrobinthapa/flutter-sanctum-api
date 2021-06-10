import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:station_grocery/screens/home/home_screen.dart';
import 'network/services/auth.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => Auth())],
    child: StationGrocery(),
  ));
}

class StationGrocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
