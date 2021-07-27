import 'package:flutter/material.dart';
import 'package:mcmobapp/api/auth.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({ Key? key }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();

  void submitRegister() async {
    String _name = emailController.text;
    String _email = emailController.text;
    String _password = passwordController.text;
    String _cPassword = cPasswordController.text;
    bool result = await Provider.of<Auth>(context, listen: false).register(_name, _email, _password, _cPassword);

    if (!result) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Register Status"),
          content: Text("Failed to register"),
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
      Navigator.pop(context);
    }
  }

  void toLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                child: Image.asset('assets/img/MClogo.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  cursorHeight: 25,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      color: Colors.grey 
                    ),
                    labelText: "Organization/Your Name",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                  controller: emailController,
                  textAlign: TextAlign.center,
                  cursorHeight: 25,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      color: Colors.grey 
                    ),
                    labelText: "Your Email",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  cursorHeight: 25,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelText: "Password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                  controller: cPasswordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  cursorHeight: 25,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelText: "Confirm Password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 500),
                  child: ElevatedButton.icon(
                    onPressed: submitRegister, 
                    label: Text('Register'),
                    icon: Icon(Icons.app_registration), 
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
              Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 500),
                  child: ElevatedButton.icon(
                    onPressed: toLogin, 
                    label: Text('Already Register?'),
                    icon: Icon(Icons.login), 
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
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
      ),
    );
  }
}