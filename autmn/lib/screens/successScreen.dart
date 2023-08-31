import 'package:flutter/material.dart';


class SuccessScreen extends StatelessWidget {
  final String shiftDate;
  final String shiftTime;
  final String shiftTimeEnd;

  SuccessScreen({required this.shiftDate, required this.shiftTime,required this.shiftTimeEnd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.check_circle, size: 100, color: Colors.green),
              onPressed: () {},
            ),
            Text(
              'Shift Accepted',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Shift will be added to your schedule once it is approved by the facility'),
            SizedBox(height: 20),
            Text('Shift Date: $shiftDate'),
            Text('Shift Time: $shiftTime - $shiftTimeEnd'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Back to Shifts',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
