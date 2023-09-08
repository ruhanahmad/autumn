import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import 'userController.dart';


class ScheduledScreen extends StatefulWidget {
  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {
   UserContoller userContoller = Get.put(UserContoller()); 

  Future<List<Map<String, dynamic>>> fetchScheduledShifts() async {
    final apiUrl =
        'https://sandbox1.autumntrack.com/api/v2/schedule/?apikey=MYhsie8n4&email=${userContoller.email}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return List<Map<String, dynamic>>.from(jsonResponse['data']);
    } else {
      throw Exception('Failed to fetch scheduled shifts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
   
         return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Scheduled Shifts",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          centerTitle: true,
          automaticallyImplyLeading: false,
                  actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Call fetchData() and trigger a refresh
              setState(() {});
            },
          ),
        ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   'All Your Shifts Pickup',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchScheduledShifts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Text('No shifts available');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var shift = snapshot.data![index];
    
                          final inputFormat = DateFormat('HH:mm'); // 'HH:mm' represents 24-hour format
      final outputFormat = DateFormat('h:mm a'); // 'h:mm a' represents 12-hour format with AM/PM
     String? strt ;
      String? ebd ;
      try {
      final DateTime dateTime = inputFormat.parse(shift['shift_start']);
      final DateTime dateTimeebd = inputFormat.parse(shift['shift_end']);
      
     strt  =  outputFormat.format(dateTime);
      ebd =  outputFormat.format(dateTimeebd);
      }
       catch (e) {
      // Handle parsing errors here
       'Invalid Time';
      }
       String? formattedDate ;
    try {
    DateTime inputDate = DateTime.parse(shift['dateOfSched']);
    formattedDate = DateFormat('EEEE, MM /dd').format(inputDate);
    formattedDate = DateFormat(' MM /dd').format(inputDate);
    
    print(formattedDate);
    }
    
    catch (e) {
      // Handle parsing errors here
       'Invalid Time';
      }
    
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                
                                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                 
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                shift['dayOfsched'] == null ? "No Day" : shift['dayOfsched'] ,
                                                style: TextStyle(
                                                  color:  Colors.green ,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                                SizedBox(height: 8),
                                                 shift['appfill'] == true?
                                             Text(
                                               "Shift Pickup" ,
                                                style: TextStyle(
                                                  color:  Colors.red ,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ):Container(),
                                              SizedBox(height: 8),
                                              Text(
                                                '$strt - $ebd',
                                              ),
                                             
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Date of Shift',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  
    
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                shift['dateOfSched'] == "" ? "No": formattedDate! ,
                                              ),
                                          SizedBox(height:MediaQuery.of(context).size.height/2 -410),
    
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
