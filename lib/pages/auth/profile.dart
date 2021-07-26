import 'package:flutter/material.dart';
import 'package:mcmobapp/api/userApi.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 20, right: 20),
              //   child: TextFormField(
              //     initialValue: 'Try me',
              //   ),
              // ),
              UserProfile(),
              ChangePwForm(),
            ],
          ),
        ]
      ),
    );
  }
}