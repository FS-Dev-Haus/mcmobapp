//import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(addItemPage());

class addItemPage extends StatefulWidget {
  const addItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add Item Form';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: addItemForm(),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class addItemForm extends StatefulWidget {
  @override
  addItemFormState createState() {
    return addItemFormState();
  }
}

class addItemFormState extends State<addItemForm> {
  final _formKey = GlobalKey<FormState>();
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter Item Name',
              labelText: 'Product Name',
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Price per Item',
              labelText: 'Product Price',
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter Quantity',
              labelText: 'Quantity',
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(20),
            child: DropdownButton(
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text("Category 1"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Category 2"),
                  value: 2,
                )
              ],
            )
          ),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new ElevatedButton(
                child: const Text('Submit'),
                onPressed: null,
              )),
        ],
      ),
    );
  }
}
