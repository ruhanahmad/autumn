import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProfileScreen extends StatelessWidget {


  Future<void> _requestCredentials() async {
   

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/close_account/?apikey=MYhsie8n4&email=ranaruhan123@gmail.com';
    

    final response = await http.post(Uri.parse(apiUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      String message = jsonResponse['message'];

      if (message == 'Success') {
         _showSnackbars('Sent Successful ');
 
        // Redirect to login screen or navigate back to previous screen
      } else {
        _showSnackbar('Request failed. Please try again.');
      }
    } else {
      _showSnackbar('Error occurred. Please try again later.');
    }
  }
  void _showSnackbars(String message) {
  Get.snackbar("Success", message);
  }
   void _showSnackbar(String message) {
  Get.snackbar("Error", message);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Screen'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('path_to_your_image.png'),
                      radius: 30.0,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Demo Account', style: TextStyle(fontSize: 18.0)),
                        Text('demo@autumnhc.net'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        // Handle settings button press
                      },
                    ),
                    SizedBox(width: 8.0),
                    Text('View Settings'),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: 
                       _requestCredentials
                      //  print("object");
                      ,
                    ),
                    SizedBox(width: 8.0),
                    Text('Close Account>>'),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Handle remove Face ID button press
                      },
                    ),
                    SizedBox(width: 8.0),
                    Text('Remove Face ID>>'),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(width: 8.0),
                    Text('Support>>'),
                  ],
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle logout button press
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Text('LOGout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
