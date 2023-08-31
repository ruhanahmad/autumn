import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MyShiftsScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchPendingShifts() async {
    final apiUrl =
        'https://sandbox1.autumntrack.com/api/v2/pending/?apikey=MYhsie8n4&email=demo@autumnhc.net';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse['data']);
    } else {
      throw Exception('Failed to fetch pending shifts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shifts'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'All Your Shifts Pickup',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchPendingShifts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Text('No shifts available');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var shift = snapshot.data![index];
                        return Container(
                          color: Colors.white,
                         
                          
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
                                        shift['approved'] == '1' ? 'Approved' : 'Pending',
                                        style: TextStyle(
                                          color: shift['approved'] == '1' ? Colors.green : Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        shift['pos'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${shift['time_start']} - ${shift['time_end']}',
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        shift['bonus'] == "0" ? 'No Bonus' : 'Bonus: ${shift['bonus']}',
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Date of Shift',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        shift['date'],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
    );
  }
}
