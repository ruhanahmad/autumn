import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/news/?apikey=MYhsie8n4&fac=Autumn%20Demo&position=RN';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse['data']);
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autumn Lake News'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var news = snapshot.data![index];
                return Container(
              
                  margin: EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news['subject'],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(news['message']),
                        SizedBox(height: 10),
                        Text(
                          news['date'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        news['ImageData'].isEmpty
                            ? Container()
                            : Image.network(
                                news['ImageData'],
                                width: 100,
                                height: 50,
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
    );
  }
}
