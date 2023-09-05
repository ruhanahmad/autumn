// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';



// // class NextScreens extends StatefulWidget {
// //   @override
// //   _NextScreensState createState() => _NextScreensState();
// // }

// // class _NextScreensState extends State<NextScreens> {
// //   DateTime _selectedDate = DateTime.now();

// //   void _onDateSelected(DateTime date) {
// //     setState(() {
// //       _selectedDate = date;
// //     });
// //   }

// //   void _moveWeek(int offset) {
// //     setState(() {
// //       _selectedDate = _selectedDate.add(Duration(days: offset * 7));
// //     });
// //   }

// //   List<DateTime> _calculateWeekDates(DateTime selectedDate) {
// //     final List<DateTime> weekDates = [];
// //     DateTime currentDate = selectedDate.subtract(Duration(days: selectedDate.weekday - DateTime.saturday));
// //     for (int i = 0; i < 7; i++) {
// //       weekDates.add(currentDate);
// //       currentDate = currentDate.add(Duration(days: 1));
// //     }
// //     return weekDates;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final intl = DateFormat('E', Localizations.localeOf(context).toString());
// //     final weekDates = _calculateWeekDates(_selectedDate);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Open Shifts'),
// //         centerTitle: true,
// //       ),
// //       body: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               IconButton(
// //                 onPressed: () {
// //                   _moveWeek(-1);
// //                 },
// //                 icon: Icon(Icons.arrow_back),
// //               ),
// //               IconButton(
// //                 onPressed: () {
// //                   _moveWeek(1);
// //                 },
// //                 icon: Icon(Icons.arrow_forward),
// //               ),
// //             ],
// //           ),
// //           Container(
// //             height: 200,
// //             width: MediaQuery.of(context).size.width,
// //             child: ListView(
// //               shrinkWrap: true,
// //               scrollDirection: Axis.horizontal,
// //               children: [
// //                 for (int i = 0; i < 7; i++)
// //                   Container(
// //                     padding: EdgeInsets.all(8.0),
// //                     margin: EdgeInsets.all(4.0),
// //                     child: Column(
// //                       children: [
// //                         Text(
// //                           intl.format(weekDates[i]),
// //                           style: TextStyle(
// //                             fontSize: 16.0,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         GestureDetector(
// //                           onTap: () {
// //                             final date = weekDates[i];
// //                             _onDateSelected(date);
// //                           },
// //                           child: Container(
// //                             padding: EdgeInsets.all(8.0),
// //                             margin: EdgeInsets.all(4.0),
// //                             decoration: BoxDecoration(
// //                               color: _selectedDate.day == weekDates[i].day ? Colors.orange : null,
// //                               borderRadius: BorderRadius.circular(8.0),
// //                             ),
// //                             child: Text(
// //                               DateFormat('dd').format(weekDates[i]),
// //                               style: TextStyle(
// //                                 fontSize: 16.0,
// //                                 color: _selectedDate.day == weekDates[i].day ? Colors.white : null,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //           Text('Selected Date: ${DateFormat('MMMM dd, y').format(_selectedDate)}'),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:app_settings/app_settings.dart';


// class MyHomePages extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Open Phone Settings'),
//       ),
//       body: Center(
//         child: 
//        ElevatedButton(
//     onPressed: () => AppSettings.openLocationSettings(),
//     child: const Text('Open Location Settings'),
//   )

//       ),
//     );
//   }
// }
