import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:mcmobapp/api/auth.dart';

class Category {
  final int? id;
  final String? name;
  final int? itemsCount;
  final int? orgId;

  Category({this.id, this.name, this.itemsCount, this.orgId});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      itemsCount: json['items_count'],
      orgId: json['org_id'],
    );
  }
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  Future<List<Category>> fetchCategories() async {
    List<Category> categories = [];
    String token = await Provider.of<Auth>(context, listen: false).getToken();
    final response = await http.get(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/categories'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        categories.add(Category.fromJson(data[i]));
      }
      return categories;
    } else {
      throw Exception('Problem loading categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(futureCategories.toString());
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
                      'Category List',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: ElevatedButton.icon(
                      onPressed: () {}, 
                      label: Text('Add Category'),
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
              CategoryListBuilder(futureCategories: futureCategories)
            ],
          ),
        ),
      ]
    );
  }
}

class CategoryListBuilder extends StatelessWidget {
  const CategoryListBuilder({ 
    Key? key,
    required this.futureCategories 
  }) : super(key: key);

  final Future<List<Category>> futureCategories;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Category category = snapshot.data![index];
                return ListTile(
                  title: Text('${category.name}'),
                  subtitle: Text('${category.itemsCount}'),
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
      }
    );
  }
}

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({ Key? key }) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}