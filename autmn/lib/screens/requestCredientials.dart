import 'dart:convert';

import 'package:autmn/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class RequestCredentialsScreen extends StatefulWidget {
  @override
  _RequestCredentialsScreenState createState() => _RequestCredentialsScreenState();
}

class _RequestCredentialsScreenState extends State<RequestCredentialsScreen> {
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String selectedFacility = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 List<dynamic> facilities = [];

  Future<void> _fetchFacilities() async {
    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/facilities/?apikey=MYhsie8n4';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> facilityData = jsonResponse['data'];

      setState(() {
        facilities = facilityData.map((facility) => facility['fac']).toList();
      });

      _showFacilitiesBottomSheet();
    } else {
      // Handle error if API request fails
      _showErrorSnackbar();
    }
  }

  void _showFacilitiesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: facilities.map((fac) {
            return ListTile(
              title: Text(fac),
              onTap: () {
                 setState(() {
                  selectedFacility = fac;
                });
                print( selectedFacility);
                // Handle selection if needed
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error fetching facilities. Please try again later.'),
      ),
    );
  }






   Future<void> _requestCredentials() async {
    String email = _emailController.text.trim();
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    if (email.isEmpty || firstName.isEmpty || lastName.isEmpty ||  selectedFacility == "") {
      _showSnackbar('Please fill in all fields');
      return;
    }

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/request/?apikey=MYhsie8n4';
    final Map<String, dynamic> requestData = {
      "fac": selectedFacility,
      "email": email,
      "fname": firstName,
      "lname": lastName,
      
    };

    final response = await http.post(Uri.parse(apiUrl), body: requestData);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      String message = jsonResponse['message'];

      if (message == 'Success') {
         _showSnackbars('Sent Successful ');
      Get.to(()=>LoginScreen());
        // Redirect to login screen or navigate back to previous screen
      } else {
        _showSnackbar('Request failed. Please try again.');
      }
    } else {
      _showSnackbar('Error occurred. Please try again later.');
    }
  }

  void _showSnackbar(String message) {
  Get.snackbar("Error", message);
  }
 void _showSnackbars(String message) {
  Get.snackbar("Success", message);
  }


  void _openFacilityList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              title: Text('Facility 1'),
              onTap: () {
                setState(() {
                  selectedFacility = 'Facility 1';
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Facility 2'),
              onTap: () {
                setState(() {
                  selectedFacility = 'Facility 2';
                  Navigator.pop(context);
                });
              },
            ),
            // Add more facilities as needed
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Credentials'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Request Credentials',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Please enter your information, and you will receive'),
                      Text('your credentials within 24 hours.'),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(labelText: 'First Name'),
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(labelText: 'Last Name'),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed:_fetchFacilities,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Select your facility',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: _fetchFacilities,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                       selectedFacility == "" ? Text('No Facility Selected'):Text("Selected Facility:${selectedFacility} "),
                         SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: ()async{
                  await  
                  
          
                  _requestCredentials();
                },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: Size(50, 50),
                        ),
                        child: Text(
                          'Request',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                         SizedBox(height: 20),
                       ElevatedButton(
                onPressed: ()async{
                  Get.to(()=>LoginScreen());
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    minimumSize: Size(50, 50),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                    ],
                  ),
                ),
             
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
