import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:hoblist_movies/screens/home_screen.dart';
import 'package:hoblist_movies/screens/login_screen.dart';
import 'package:hoblist_movies/utilities/constants.dart';
import 'package:hoblist_movies/utilities/customWidgets.dart';

import 'package:hoblist_movies/extensions/validate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final name_controller = TextEditingController();
  final password_controller = TextEditingController();
  final email_controller = TextEditingController();
  final phone_controller = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool _isloading = false;

  String? selectedProffession = null;

  SharedPreferences? registerdata;

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    initiateSharedPreferences();
  }

  void setData() {
    String name = name_controller.text;
    String password = Crypt.sha256(password_controller.text).toString();
    String email = email_controller.text;
    String phone = phone_controller.text;
    if (name != '' &&
        password != '' &&
        email != '' &&
        phone != '' &&
        selectedProffession != null) {
      print('Successfull');

      registerdata?.setString('name', name);
      registerdata?.setString('password', password);
      registerdata?.setString('email', email);
      registerdata?.setString('phone', phone);
      registerdata?.setString('profession', selectedProffession!);
    }
  }

  DropdownButtonFormField<String> professionDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String profession in professions) {
      var newItem = DropdownMenuItem(
        child: Text(profession),
        value: profession,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField<String>(
      hint: Text('Choose Your Proffession'),
      value: selectedProffession,
      items: dropdownItems,
      onChanged: (value) {
        selectedProffession = value;
        setState(() {});
      },
      validator: (value) =>
          value == null ? 'Please select you Profession' : null,
    );
  }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Register",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextfield(
                  controller: name_controller,
                  obsecureText: false,
                  labelText: 'Name'),
              CustomTextfield(
                  controller: password_controller,
                  validator: (password) {
                    return password?.isPasswordValid();
                  },
                  obsecureText: true,
                  labelText: 'Password'),
              CustomTextfield(
                  controller: email_controller,
                  validator: (email) {
                    if (email!.isEmail()) {
                      return null;
                    } else {
                      return 'Enter a valid email address';
                    }
                  },
                  obsecureText: false,
                  labelText: 'Email'),
              CustomTextfield(
                  controller: phone_controller,
                  validator: (phone) {
                    return phone?.validateMobile(phone);
                  },
                  obsecureText: false,
                  labelText: 'Phone'),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: professionDropdown(),
              ),
              SizedBox(
                height: 40,
              ),
              (!_isloading)
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setData();

                          clearTextFormFields();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homescreen(),
                            ),
                          );
                          setState(() {
                            _isloading = true;
                          });
                        }
                      },
                      child: Text("Register"),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Text('Already Registered?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text('Log In'),
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

  void clearTextFormFields() {
    name_controller.clear();
    password_controller.clear();
    email_controller.clear();
    phone_controller.clear();
  }
}
