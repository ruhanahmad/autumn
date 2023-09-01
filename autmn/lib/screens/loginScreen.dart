import 'dart:convert';
import 'dart:io';

import 'package:autmn/screens/bottomNavigation.dart';
import 'package:autmn/screens/homescreen.dart';
import 'package:autmn/screens/requestCredientials.dart';
import 'package:autmn/screens/resetScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String fname = '';
String lname = '';
String email = '';
String facility = '';
String role = '';
String position = '';
String employeeKey = '';
String playerID = '';

//  Future getPlayerId() async {
//     try {
//  var deviceState = await OneSignal.shared.getDeviceState();

//     if (deviceState == null || deviceState.userId == null)
//         return;

//     notificationController.playerId = deviceState.userId!;
//      print("playeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer" + notificationController.playerId);
//    await  updateToken();
//     }
//     catch(e){
//      Get.snackbar("title", "not getting PlayerID  ${e}");
//     }
    



//   }
   Future<void> _login() async {


     String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Please fill in both fields');
    }
    else {
    final String apiUrl = 'https://sandbox1.autumntrack.com/api/v2/login/?apikey=MYhsie8n4';

    final Map<String, String> body = {
      // 'user': _emailController.text,
      // 'pass': _passwordController.text,
      // 'player_id': 'sadas',
       'user': "demo@autumnhc.net",
      'pass': "Test1234",
      'player_id': 'sadas',
    };

    final response = await http.post(Uri.parse(apiUrl), body: body, );
    

    if (response.statusCode == 200) {
      // Successful login, handle the response
      print('Login successful: ${response.body}');

      final jsonResponse = json.decode(response.body);

  // Extract data from the JSON
  Map<String, dynamic> data = jsonResponse['data'];
  fname = data['fname'];
  lname = data['lname'];
  email = data['email'];
  facility = data['facility'];
  role = data['role'];
  position = data['position'];
  employeeKey = data['employeekey'];
  playerID = data['player_id'];

      Get.to(()=>NavigationBarScreen(
        // fname: fname,
        // lname: lname,
        // email: email,
        // facility: facility,
        // role: role,
        // position: position,
        // employeeKey: employeeKey,
        // playerID: playerID,
      ),);
    } else {
      // Error handling for unsuccessful login
      print('Login failed: ${response.statusCode}');
    }
    }
  }

   void _showSnackbar(String message) {
   Get.snackbar('Error', '$message');
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/atnav.png"),fit:BoxFit.cover )),
                  // Replace with your logo
                ),
                SizedBox(height: 20.0),
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Please Sign in to continue',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                   controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27.0),
                      borderSide: BorderSide(width: 10.0, color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: _passwordController,
                 obscureText: !_showPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27.0),
                      borderSide: BorderSide(width: 2.0, color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Checkbox(
                      value: _showPassword,
                      onChanged: (value) {
                        setState(() {
                          _showPassword = value!;
                        });
                      },
                    ),
                    Text('Show Password'),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 420.0,
                  height: 49.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(27.0),
                  ),
                  child: 
                 TextButton(
                    onPressed: _login,
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                 SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>RequestCredentialsScreen());
                  },
                  child: Container(
                    width: 420.0,
                    height: 49.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.black),
                      borderRadius: BorderRadius.circular(27.0),
                    ),
                    child: Center(
                      child: Text(
                        'Request Credentials',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>ResetScreen());
                  },
                  child: Container(
                    width: 180.0,
                    height: 35.0,
                    color: Color(0xFFD9D9D9),
                    child: Center(
                      child: Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Any questions and issues please email',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
                ),
                Text(
                  'support@autumntrack.com',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
