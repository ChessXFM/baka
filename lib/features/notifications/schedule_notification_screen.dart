//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class ScheduleNotificationScreen extends StatefulWidget {
//   static const String routeName = '/notifications';
//   @override
//   _ScheduleNotificationScreenState createState() =>
//       _ScheduleNotificationScreenState();
// }

// class _ScheduleNotificationScreenState
//     extends State<ScheduleNotificationScreen> {
//   TimeOfDay? _selectedTime;
//   DateTime? _selectedDate;

//   final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> _scheduleNotification() async {
//     if (_selectedTime != null && _selectedDate != null) {
//       tz.initializeTimeZones(); // Initialize timezones

//       // Combine selected date and time
//       final selectedDateTime = DateTime(
//         _selectedDate!.year,
//         _selectedDate!.month,
//         _selectedDate!.day,
//         _selectedTime!.hour,
//         _selectedTime!.minute,
//       );

//       tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(
//         selectedDateTime,
//         tz.local,
//       );

//       const AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         'your_channel_id', // Channel ID
//         'your_channel_name', // Channel name
//         importance: Importance.max,
//         priority: Priority.high,
//       );

//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//       );

//       final now = tz.TZDateTime.now(tz.local);
//       if (scheduledDateTime.isBefore(now)) {
//         scheduledDateTime = now.add(
//             const Duration(seconds: 5)); // Ensures the time is in the future
//       }

//       await _notificationsPlugin.zonedSchedule(
//         0,
//         'Scheduled Notification',
//         'woooooo',
//         scheduledDateTime,
//         notificationDetails,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//       );

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//             'Notification scheduled for ${DateFormat('yyyy-MM-dd HH:mm').format(scheduledDateTime)}'),
//       ));
//     }
//   }

//   _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//     }
//   }

//   _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule Notification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: Text('Select Date'),
//             ),
//             ElevatedButton(
//               onPressed: () => _selectTime(context),
//               child: Text('Select Time'),
//             ),
//             if (_selectedDate != null)
//               Text(
//                   'Selected date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
//             if (_selectedTime != null)
//               Text('Selected time: ${_selectedTime!.format(context)}'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _scheduleNotification,
//               child: Text('Schedule Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
