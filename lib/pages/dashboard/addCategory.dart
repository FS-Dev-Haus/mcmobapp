import 'package:flutter/material.dart';

class addCategoryPage extends StatefulWidget {
  const addCategoryPage({Key? key}) : super(key: key);

  @override
  _addCategoryPageState createState() => _addCategoryPageState();
}

class _addCategoryPageState extends State<addCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: 'Name',
              contentPadding: EdgeInsets.all(20.0),
            ),
          ),
          //TextField(
          //contentPadding: EdgeInsets.all(20),
          //decoration: InputDecoration(
          // border: UnderlineInputBorder(), labelText: 'Name'),
          // ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Add Category"),
          )
        ],
      ),
    );
  }
}
