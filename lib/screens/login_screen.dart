import 'package:flutter/material.dart';
import 'package:hoblist_movies/screens/home_screen.dart';
import 'package:hoblist_movies/screens/register_screen.dart';
import 'package:hoblist_movies/extensions/validate.dart';
import 'package:hoblist_movies/utilities/customWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  SharedPreferences? registerdata;

  bool _isLoading = false;

  bool? newuser;
  final snackBar = SnackBar(
    content: Text('Invalid Credentials'),
  );

  @override
  void initState() {
    super.initState();
    initiateSharedPreferences();
    print(registerdata?.getString('name'));
  }

  // void check_if_already_login() async {
  //   logindata = await SharedPreferences.getInstance();
  //   newuser = (logindata!.getBool('login') ?? true);
  //   print(newuser);
  //   if (newuser == false) {
  //     Navigator.pushReplacement(
  //       context,
  //       new MaterialPageRoute(
  //         builder: (context) => Homescreen(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoblist Movies"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextfield(
                  controller: username_controller,
                  obsecureText: false,
                  labelText: 'Name'),
              CustomTextfield(
                  controller: password_controller,
                  validator: (password) {
                    return password?.isPasswordValid();
                  },
                  obsecureText: true,
                  labelText: 'Password'),
              (!_isLoading)
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          checkData();
                        }
                      },
                      child: Text("Log-In"),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Text('New User?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: Text('Register'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initiateSharedPreferences() async {
    registerdata = await SharedPreferences.getInstance();
  }

  void checkData() {
    String username = username_controller.text;
    String password = stringToBase64.encode(password_controller.text);
    var name = registerdata?.getString('name');
    var pass = registerdata?.getString('password');
    if (username == name && password == pass) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
