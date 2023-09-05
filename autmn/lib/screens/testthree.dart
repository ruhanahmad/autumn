// class WeeklyCalendar extends StatefulWidget {
//   final DateTime selectedDate;
//   final Function(DateTime) onSelectDate;
//   final List<String> openShiftDates; // List of dates with open shifts

//   WeeklyCalendar({
//     required this.selectedDate,
//     required this.onSelectDate,
//     required this.openShiftDates,
//   });

//   @override
//   _WeeklyCalendarState createState() => _WeeklyCalendarState();
// }

// class _WeeklyCalendarState extends State<WeeklyCalendar> {
//   @override
//   Widget build(BuildContext context) {
//     DateTime startOfWeek = widget.selectedDate.subtract(Duration(days: widget.selectedDate.weekday));
//     List<DateTime> days = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: () {
//                 DateTime prevWeek = widget.selectedDate.subtract(Duration(days: 7));
//                 widget.onSelectDate(prevWeek);
//               },
//             ),
//             Row(
//               children: [
//                 for (int i = 0; i < 7; i++)
//                   GestureDetector(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Text(
//                         DateFormat('E').format(days[i]),
//                         style: TextStyle(
//                           fontWeight: days[i].day == widget.selectedDate.day ? FontWeight.bold : FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             IconButton(
//               icon: Icon(Icons.arrow_forward_ios),
//               onPressed: () {
//                 DateTime nextWeek = widget.selectedDate.add(Duration(days: 7));
//                 widget.onSelectDate(nextWeek);
//               },
//             ),
//           ],
//         ),
//         SizedBox(height: 10.0),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               for (int i = 0; i < 7; i++)
//                 GestureDetector(
//                   onTap: () => widget.onSelectDate(days[i]),
//                   child: Stack(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 10.0),
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: days[i].day == widget.selectedDate.day ? Colors.orange : null,
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Text(
//                           DateFormat('d').format(days[i]),
//                           style: TextStyle(
//                             fontWeight: days[i].day == widget.selectedDate.day ? FontWeight.bold : FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                       if (widget.openShiftDates.contains(DateFormat('yyyy-MM-dd').format(days[i])))
//                         Positioned(
//                           top: 0,
//                           right: 0,
//                           child: Container(
//                             width: 8.0,
//                             height: 8.0,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
