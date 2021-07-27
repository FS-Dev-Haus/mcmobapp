import 'package:flutter/material.dart';
import 'package:mcmobapp/api/auth.dart';
import 'package:mcmobapp/api/itemsApi.dart';
import 'package:provider/provider.dart';
import 'package:mcmobapp/pages/dashboard/dashboard.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Welcome!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo[600]
            ),
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Item Inventory'),
            onTap: (){
              Navigator.pushNamed(context, '/items');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.account_tree_outlined),
          //   title: Text('Category'),
          //   onTap: (){
          //     Navigator.pushNamed(context, '/categories');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: (){
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}