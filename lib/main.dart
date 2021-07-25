import 'package:flutter/material.dart';
import 'package:mcmobapp/pages/auth/login.dart';
import 'package:mcmobapp/api/auth.dart';
import 'package:mcmobapp/pages/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Auth(),
      child: MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MC Inventory Manager',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Consumer<Auth>(
            builder: (context, auth, child) {
              Provider.of<Auth>(context, listen: false).checkToken();
              switch (auth.isAuthenticated) {
                case true:
                  return DashboardApp();
                default:
                  return LoginForm();
              }
            },
          ),
        ),
      ),
    );
  }
}
