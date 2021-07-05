import 'package:flutter/material.dart';

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
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.account_tree_outlined),
            title: Text('Category'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}