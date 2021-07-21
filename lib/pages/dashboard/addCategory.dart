import 'package:flutter/material.dart';

class addCategoryPage extends StatefulWidget {
  const addCategoryPage({ Key? key }) : super(key: key);

  @override
  _addCategoryPageState createState() => _addCategoryPageState();
}

class _addCategoryPageState extends State<addCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Add Category'),
      ),
    );
  }
}