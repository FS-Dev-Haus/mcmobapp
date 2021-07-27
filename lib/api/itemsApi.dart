import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcmobapp/api/auth.dart';
import 'package:mcmobapp/pages/dashboard/addItem.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item {
  final int? id;
  final String? name;
  final String? price;
  final int? quantity;
  final int? orgId;
  final int? categoryId;

  Item({this.id, this.name, this.price, this.quantity, this.orgId, this.categoryId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      orgId: json['org_id'],
      categoryId: json['category_id'],
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Future<List<Item>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = fetchItems();
  }

  Future<List<Item>> fetchItems() async {
    // ignore: deprecated_member_use
    List<Item> items = [];
    String token = await Provider.of<Auth>(context, listen: false).getToken();
    final response = await http.get(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/items'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)["items"];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        items.add(Item.fromJson(data[i]));
      }
      return items;
    } else {
      throw Exception('Problem loading items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    Text(
                      'Item List',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 60),
                      child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return addItemForm();
                        }));
                      }, 
                      label: Text('Add Item'),
                      icon: Icon(Icons.add), 
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shadowColor: Colors.grey,
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w300
                        ),
                      ),
                  ),
                    ),
                  ]
                ),
              ),
              ItemListBuilder(futureItems: futureItems)
            ],
          ),
        ),
      ]
    );
  }
}

class ItemListBuilder extends StatelessWidget {
  const ItemListBuilder({ 
    Key? key,
    required this.futureItems
  }) : super(key: key);

  final Future<List<Item>> futureItems;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: futureItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Item item = snapshot.data![index];
                return ListTile(
                  title: Text('${item.name}'),
                  subtitle: Text('${double.parse(item.price!)}'),
                  trailing: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return EditItemForm(item: item);
                      }));
                    },
                    label: Text('Detail'),
                    icon: Icon(Icons.menu_open),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      elevation: 0,
                      // textStyle: TextStyle(
                      //   color: Colors.black
                      // )
                    ),
                  ),
                );
              }
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class EditItemForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  // late Item item;
  late int? id;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  
  EditItemForm({required Item item}) {
    id = item.id;
    nameController = TextEditingController(text: item.name);
    priceController = TextEditingController(text: item.price);
    quantityController = TextEditingController(text: item.quantity.toString());
  }
  
  // EditItemForm({ Key? key, required this.item }) : super(key: key);

  Future<bool> editItem(String name, String price, String quantity) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final response = await http.put(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/items/$id'),
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

  Future<bool> deleteItem() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final response = await http.delete(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/items/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
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
    print(id);
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
                  child: const Text('Update'),
                  onPressed: () async {
                    bool settle = await editItem(nameController.text, priceController.text, quantityController.text);

                    if (settle) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Edit Status"),
                          content: Text("You have edited an item"),
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
                          title: Text("Edit Status"),
                          content: Text("Failed to edit item"),
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
            new Container(
                padding: const EdgeInsets.only(left: 150.0, top: 10.0),
                child: new ElevatedButton(
                  child: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red
                  ),
                  onPressed: () async {
                    bool settle = await deleteItem();

                    if (settle) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Delete Status"),
                          content: Text("You have deleted an item"),
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
                          title: Text("Delete Status"),
                          content: Text("Failed to delete item"),
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