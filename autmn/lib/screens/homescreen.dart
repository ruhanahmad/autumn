// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   final String fname;
//   final String lname;
//   final String email;
//   final String facility;
//   final String role;
//   final String position;
//   final String employeeKey;
//   final String playerID;

//   HomeScreen({
//     required this.fname,
//     required this.lname,
//     required this.email,
//     required this.facility,
//     required this.role,
//     required this.position,
//     required this.employeeKey,
//     required this.playerID,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Next Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text('First Name: $fname'),
//             Text('Last Name: $lname'),
//             Text('Email: $email'),
//             // ... Other data fields
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  DateTime selectedDate = DateTime.now();
   String formatDateVar = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Default value


  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
      formatDateVar = DateFormat('yyyy-MM-dd').format(selectedDate);
    });
  }


 Future<List<Map<String, dynamic>>> fetchShifts() async {
    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/user-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$formatDateVar';

    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
     
      return List<Map<String, dynamic>>.from(jsonResponse);
    
    } else {
      throw Exception('Failed to fetch shifts');
    }
  }

Future<Map<String, dynamic>> acceptInvitation(String id, String userInstantAccept) async {

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/accept/?apikey=MYhsie8n4&id=$id&user_instant_accept=$userInstantAccept&empkey=13110';

    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final  Map<String,dynamic>jsonResponse = json.decode(response.body);
    
      return jsonResponse;
    } else {
      throw Exception('Failed to accept invitation');
    }
  }

  acceptInvitations() async {

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/accept/?apikey=MYhsie8n4&id=1734&user_instant_accept=0&empkey=13110';
    

    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = json.decode(response.body);
      print( jsonResponse);
    
    } else {
      throw Exception('Failed to accept invitation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
            acceptInvitations();
          },
          child: Text('Open Shifts')),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Week of ${DateFormat('MMMM d, y').format(selectedDate)}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          WeeklyCalendar(selectedDate: selectedDate, onSelectDate: _selectDate),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                                      Text(
                      ' ${DateFormat('EEEE, MMMM d, y').format(selectedDate)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  // Container(
                  //   padding: EdgeInsets.all(10.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.orange,
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  //   child:
                  //    Text(
                  //     ' ${DateFormat('EEEE, MMMM d, y').format(selectedDate)}',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

               Expanded(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchShifts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No shifts available'));
            } else {
              return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                var shift = snapshot.data![index];
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ListTile(
                 title: Text('Position: ${shift['position']}'),
                      subtitle: Text('Shift Start: ${shift['shift_start']}, Shift End: ${shift['shift_end']}, Shift End: ${shift['id']}'),
                       trailing: ElevatedButton(
                            onPressed: () async {
                              try {
                                Map<String, dynamic> acceptResponse = await acceptInvitation(shift['id'], shift['user_instant_accept']);
                                // You can store the accept response data in variables here if needed
                                print('Accept Response: $acceptResponse');
                              } catch (error) {
                                print('Error accepting invitation: $error');
                              }
                            },
                            child: Text('Accept Invitation'),
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
    );
  }
}

class WeeklyCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onSelectDate;

  WeeklyCalendar({required this.selectedDate, required this.onSelectDate});

  @override
  Widget build(BuildContext context) {
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    List<DateTime> days = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                DateTime prevWeek = selectedDate.subtract(Duration(days: 7));
                onSelectDate(prevWeek);
              },
            ),
            Row(
              children: [
                for (int i = 0; i < 7; i++)
                  GestureDetector(
                    // onTap: () => onSelectDate(days[i]),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        // color: days[i].day == selectedDate.day ? Colors.orange : null,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        DateFormat('E').format(days[i]),
                        style: TextStyle(
                          fontWeight: days[i].day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                DateTime nextWeek = selectedDate.add(Duration(days: 7));
                onSelectDate(nextWeek);
              },
            ),
          ],
        ),
        SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 7; i++)
                GestureDetector(
                  onTap: () => onSelectDate(days[i]),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: days[i].day == selectedDate.day ? Colors.orange : null,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      DateFormat('d').format(days[i]),
                      style: TextStyle(
                        fontWeight: days[i].day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

