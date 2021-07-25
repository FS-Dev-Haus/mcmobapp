import 'package:flutter/material.dart';
import 'package:mcmobapp/api/auth.dart';
import 'package:mcmobapp/pages/auth/register.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> submitLogin() async {
    String _email = emailController.text;
    String _password = passwordController.text;
    bool result = await Provider.of<Auth>(context, listen: false).login(_email, _password);

    print(result);
  }

  toRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RegisterForm();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                child: Image.asset('assets/img/MClogo.png'),
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
                margin: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 500),
                  child: ElevatedButton.icon(
                    onPressed: submitLogin, 
                    label: Text('Login'),
                    icon: Icon(Icons.login), 
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
                    onPressed: toRegister, 
                    label: Text('Not Registered Yet?'),
                    icon: Icon(Icons.app_registration), 
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