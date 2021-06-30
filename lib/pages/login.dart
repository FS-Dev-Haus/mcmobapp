import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  submitLogin() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                onPressed: (){}, 
                label: Text('Login'),
                icon: Icon(Icons.login), 
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  shadowColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
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
                onPressed: (){}, 
                label: Text('Not Registered Yet?'),
                icon: Icon(Icons.app_registration), 
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shadowColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
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
    );
  }
}