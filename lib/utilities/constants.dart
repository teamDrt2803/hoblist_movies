import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

List professions = ['Accountant', 'Doctor', 'Professor', 'Chef', 'Farmer'];

class initiateSharedPreferences {
  Future<SharedPreferences> registerUser = SharedPreferences.getInstance();
}

const TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
