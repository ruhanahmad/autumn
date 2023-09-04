import 'package:flutter/material.dart';


class SuccessScreen extends StatelessWidget {
  final String shiftDate;
  final String shiftTime;
  final String shiftTimeEnd;
  final String approved;
  final String userInstant;
  

  SuccessScreen({required this.shiftDate, required this.shiftTime,required this.shiftTimeEnd,required this.approved,required this.userInstant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
      approved == "1" || userInstant == "1" ?
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width/2-150),
             Column(
               children: [
                 Text('Shift will be added to your schedule once it is '),
                  Text('approved by the facility'),
               ],
             ),
                
              ],
            ):
             Text('Shift has been added to your schedule  '),
            
            
            
            
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
