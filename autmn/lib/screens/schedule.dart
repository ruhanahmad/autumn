import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ScheduledScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchScheduledShifts() async {
    final apiUrl =
        'https://sandbox1.autumntrack.com/api/v2/schedule/?apikey=MYhsie8n4&email=demo@autumnhc.net';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse['data']);
    } else {
      throw Exception('Failed to fetch scheduled shifts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Shifts'),
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
                future: fetchScheduledShifts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Text('No shifts available');
                  } else {
                    return SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var shift = snapshot.data![index];
                            return Container(
                            
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
                                          Text(
                                            '${shift['shift_start']} - ${shift['shift_end']}',
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
                                            shift['dateOfSched'] == "" ? "No": shift['dateOfSched'] ,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
