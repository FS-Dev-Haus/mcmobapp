import 'package:flutter/material.dart';

class addItemPage extends StatefulWidget {
  const addItemPage({ Key? key }) : super(key: key);

  @override
  _addItemPageState createState() => _addItemPageState();
}

class _addItemPageState extends State<addItemPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Add Item'),
      ),
    );
  }
}