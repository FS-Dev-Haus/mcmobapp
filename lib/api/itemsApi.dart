import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcmobapp/api/auth.dart';
import 'package:provider/provider.dart';

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
                      onPressed: () {}, 
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
                    onPressed: () {},
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