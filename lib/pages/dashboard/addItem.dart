//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// void main() => runApp(addItemPage());

// class addItemForm extends StatefulWidget {
//   const addItemForm({Key? key}) : super(key: key);

//   // @override
//   // Widget build(BuildContext context) {
//   //   final appTitle = 'Add Item Form';
//   //   return MaterialApp(
//   //     title: appTitle,
//   //     home: Scaffold(
        // appBar: AppBar(
        //   title: Text(appTitle),
        // ),
//   //       body: addItemForm(),
//   //     ),
//   //   );
//   // }

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     // throw UnimplementedError();
//   }
// }

class addItemForm extends StatefulWidget {
  @override
  addItemFormState createState() {
    return addItemFormState();
  }
}

class addItemFormState extends State<addItemForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _value = 1;

  Future<bool> addItem(String name, String price, String quantity) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final response = await http.post(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/items'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: {
        'name': name,
        'price': price,
        'quantity': quantity,
        'category_id': '11'
      }
    );

    if (response.statusCode == 201) {
      print(201);
      return true;
    }

    if (response.statusCode == 422) {
      print('sini 422');
      return false;
    }
    print(response.body);
    print('last');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Item Name',
                labelText: 'Product Name',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                hintText: 'Price per Item',
                labelText: 'Product Price',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                hintText: 'Enter Quantity',
                labelText: 'Quantity',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            // new Container(
            //   padding: EdgeInsets.all(20),
            //   child: DropdownButton<int>(
            //     value: _value,
            //     onChanged: (int? newValue) {
            //       setState(() {
            //         _value = newValue!;
            //       });
            //     },
            //     items: <int>[1,2,3]
            //       .map<DropdownMenuItem<int>>((int value) {
            //         return DropdownMenuItem<int>(
            //           value: value,
            //           child: Text(value.toString()),
            //         );
            //       }).toList(),
            //     // items: [
            //     //   DropdownMenuItem<int>(
            //     //     child: Text("Category 1"),
            //     //     value: 1,
            //     //   ),
            //     // ],
            //   )
            // ),
            new Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: new ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    bool settle = await addItem(nameController.text, priceController.text, quantityController.text);

                    if (settle) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Add Status"),
                          content: Text("You have created an item"),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                
                              ),
                              child: Text(
                                "Okay",
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Add Status"),
                          content: Text("Failed to create item"),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                
                              ),
                              child: Text(
                                "Okay",
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/items');
                  },
                )),
          ],
        ),
      ),
    );
  }
}
