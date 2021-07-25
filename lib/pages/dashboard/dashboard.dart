import 'package:flutter/material.dart';
import 'package:mcmobapp/api/categoriesApi.dart';
import 'package:mcmobapp/api/itemsApi.dart';
import 'package:mcmobapp/api/userApi.dart';
import 'package:mcmobapp/pages/dashboard/addCategory.dart';
import 'package:mcmobapp/pages/dashboard/addItem.dart';
import 'package:mcmobapp/pages/layouts/sidedrawer.dart';

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'MC Inventory Manager',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: UserProfile(),
      ),
    );
  }
}