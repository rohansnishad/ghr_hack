// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// class HelmetMonitor extends StatefulWidget {
//   const HelmetMonitor({super.key});
//
//   @override
//   State<HelmetMonitor> createState() => _HelmetMonitorState();
// }
//
// class _HelmetMonitorState extends State<HelmetMonitor> {
//   final databaseReference = FirebaseDatabase.instance.ref();
//   int irSensorValue = -1; // Initialize with an invalid value
//
//   @override
//   void initState() {
//     super.initState();
//     _initNotifications();
//     _listenToSensor();
//   }
//
//   Future<void> _initNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher'); // Replace with your app icon
//     final DarwinInitializationSettings initializationSettingsIOS =
//     DarwinInitializationSettings();
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   void _listenToSensor() {
//     databaseReference.onValue.listen((event) {
//       final data = event.snapshot.value as Map?;
//       setState(() {
//         irSensorValue = data?['IR_Sensor'] as int? ?? -1;
//       });
//       _showNotificationIfNecessary();
//     });
//   }
//
//   void _showNotificationIfNecessary() async {
//     if (irSensorValue != -1) {
//       String message;
//       if (irSensorValue == 0) {
//         message = 'Helmet applied.';
//       } else {
//         message = 'Helmet removed!';
//       }
//
//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//           'your_channel_id', 'Your Channel Name',
//           channelDescription: 'Your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker');
//       const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin.show(
//           DateTime.now().millisecondsSinceEpoch, 'Helmet Status', message, platformChannelSpecifics);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Helmet Monitor')),
//       body: Center(
//         child: irSensorValue == -1
//             ? const CircularProgressIndicator()
//             : Text('IR Sensor Value: $irSensorValue, Helmet Status: ${irSensorValue == 0 ? 'Applied' : 'Removed'}'),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     databaseReference.off();
//     super.dispose();
//   }
// }
//
// extension on DatabaseReference {
//   void off() {}
// }
