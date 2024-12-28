// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharesome/Splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //  initialRoute: '/', // Set the initial route to 'DonorPersonal'
        // routes: {
        //   '/': (context) => DonorPersonal(), // Set initial route to DonorPersonal
        //   '/donorPersonalInfo'+826+: (context) {
        //     final String? documentId = ModalRoute.of(context)?.settings.arguments as String?;
        //     return DonorPersonalInfo(documentId: documentId ?? ''); // Provide a default empty string if documentId is null},
        //     },}
        home: Page1(),
        // ...
        routes: {
          // '/home': (context) => HomeDonar(),
          //'/history': (context) =>
          // '/donate': (context) => DonationTypeScreen(),
          // '/maps': (context) => Maps(),
          //'/message': (context) => MessageScreen(),

          // '/home1': (context) => HomeRecipient(),
          //'/history1': (context) =>),
          // '/donate1': (context) => RequestTypeSelection(),
          // '/maps1': (context) => Maps(),
          //'/message1': (context) => MessageScreen(
          // ...
        });
  }
}
