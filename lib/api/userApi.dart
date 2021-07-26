import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcmobapp/api/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int? id;
  final String? name;
  final String? email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  Future<User> fetchUser() async {
    String token = await Provider.of<Auth>(context, listen: false).getToken();
    final response = await http.get(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/profile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Problem loading user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProfileForm(user: snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      }
    );
  }
}

class ProfileForm extends StatelessWidget {
  ProfileForm({ 
    Key? key,
    required this.user 
  }) : super(key: key);

  final User? user;
  late TextEditingController nameController = TextEditingController(text: user!.name);
  late TextEditingController emailController = TextEditingController(text: user!.email);
  final _formKey = GlobalKey<FormState>();

  Future<bool> updateProfile(String name, String email) async {
    print('masuk');
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    print(token);
    final response = await http.put(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/profile/update/${user!.id}'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: {
        'name': name,
        'email': email,
      }
    );

    if (response.statusCode == 201) {
      print('sini 201');
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              // initialValue: '${user!.name}',
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name'
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be left empty';
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              // initialValue: '${user!.email}',
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email'
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be left empty';
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 500),
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print(nameController.text);
                    print(emailController.text);
                    bool settle = await updateProfile(nameController.text, emailController.text);
                    print(settle);
                    if (settle) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Update Status"),
                          content: Text("You have updated your profile"),
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
                          title: Text("Update Status"),
                          content: Text("Problem encountered, Try again."),
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
                  }
                }, 
                label: Text('Update Profile'),
                icon: Icon(Icons.update), 
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
            )
          ),
        ]
      ),
    );
  }
}

class ChangePwForm extends StatelessWidget {
  ChangePwForm({ Key? key }) : super(key: key);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<bool> changePw(String password, String currentPassword, String confirmPassword) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final profileRes = await http.get(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/profile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );
    print(json.decode(profileRes.body)['id']);

    final response = await http.put(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/profile/updatepw/${json.decode(profileRes.body)['id']}'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: {
        'currentpass': password,
        'password': currentPassword,
        'password_confirmation': confirmPassword,
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
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                // initialValue: '$user',
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be left empty';
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                // initialValue: '${user!.name}',
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be left empty';
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                // initialValue: '${user!.name}',
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be left empty';
                  }
                },
              ),
            ),
            Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 500),
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool settle = await changePw(passwordController.text, newPasswordController.text, confirmPasswordController.text);

                    if (settle) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Update Status"),
                          content: Text("You have updated your password"),
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
                          title: Text("Update Status"),
                          content: Text("Failed to update password"),
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
                  }
                }, 
                label: Text('Change Password'),
                icon: Icon(Icons.warning), 
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shadowColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
            )
          ),
          ],
        ),
      ),
    );
  }
}