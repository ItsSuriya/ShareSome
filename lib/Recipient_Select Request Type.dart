// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sharesome/Home_Recipient.dart';
import 'package:sharesome/Recipient_Request%20Food.dart';

class RequestTypeSelection extends StatefulWidget {
  const RequestTypeSelection({super.key});

  @override
  State<RequestTypeSelection> createState() => _RequestTypeSelectionState();
}

class _RequestTypeSelectionState extends State<RequestTypeSelection> {
  String _selectedDonationType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeRecipient(),
              ),
            );
          },
        ),
        title: Text(
          'Request Donation',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              'Choose your request type',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDonationType = 'food';
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.5, // Increased width
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 5.66,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                        border: Border.all(
                          color: _selectedDonationType == 'food'
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.orange, width: 2),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/Request_food_hand.png',
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Request Food',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDonationType = 'money';
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.5, // Increased width
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 5.66,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                        border: Border.all(
                          color: _selectedDonationType == 'money'
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.orange, width: 2),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/Request_money_hand.png',
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Request Money',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDonationType == 'food') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Requestfood(),
                      ),
                    );
                  } else if (_selectedDonationType == 'money') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Requestfood(),
                      ),
                    );
                  } else {
                    // Show a message or alert if no option is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a request type'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFC8019),
                  minimumSize: Size(double.infinity, 60),
                  padding: EdgeInsets.symmetric(horizontal: 69, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}