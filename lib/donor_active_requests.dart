import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonorActiveReq extends StatefulWidget {
  const DonorActiveReq({super.key});

  @override
  State<DonorActiveReq> createState() => _DonorActiveReqState();
}

class _DonorActiveReqState extends State<DonorActiveReq> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isNotificationEnabled = true;

  // Mock data simulating fetched Firebase data
  List<Map<String, String>> mockData = [
    {
      'homeName': 'Anugraham Home',
      'distance': '1.2 km',
      'title': 'Requesting Lunch for 69 senior persons',
      'description': 'Lorem ipsum dolor sit amet, consectetuer sociis natoque penatibus et magnis.',
    },
    {
      'homeName': 'Anugraham Home',
      'distance': '5.0 km',
      'title': 'Requesting Lunch for 69 senior persons',
      'description': 'Lorem ipsum dolor sit amet, consectetuer sociis natoque penatibus et magnis.',
    },
    {
      'homeName': 'Anugraham Home',
      'distance': '5.0 km',
      'title': 'Requesting Lunch for 69 senior persons',
      'description': 'Lorem ipsum dolor sit amet, consectetuer sociis natoque penatibus et magnis.',
    },
    {
      'homeName': 'Anugraham Home',
      'distance': '5.0 km',
      'title': 'Requesting Lunch for 69 senior persons',
      'description': 'Lorem ipsum dolor sit amet, consectetuer sociis natoque penatibus et magnis.',
    },
    {
      'homeName': 'Anugraham Home',
      'distance': '5.0 km',
      'title': 'Requesting Lunch for 69 senior persons',
      'description': 'Lorem ipsum dolor sit amet, consectetuer sociis natoque penatibus et magnis.',
    },
    {
      'homeName': 'Anugraham Home',
      'distance': '5.0 km',
      'title': 'Requesting Lunch for 69 senior persons',
      'description': 'Lorem ipsum dolor sit amet, consectetuer sociis natoque penatibus et magnis.',
    },


  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Active food requests',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: mockData.length,
          itemBuilder: (context, index) {
            var request = mockData[index];
            String homeName = request['homeName'] ?? '';
            String distance = request['distance'] ?? '';
            String title = request['title'] ?? '';
            String description = request['description'] ?? '';

            return Container(
              margin: const EdgeInsets.all(11),
              padding: const EdgeInsets.fromLTRB(16, 17, 16, 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row with Home Name and Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        homeName,
                        style: const TextStyle(
                          color: Color(0xFFFC8019),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                           // Add 5px space between the text and the picture
                          SvgPicture.asset(
                            'assets/delivery.svg',
                          ),
                          const SizedBox(width: 5),
                          Text(
                            distance,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13.33,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF9AA2AB),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Action Buttons
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle show on map action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFC8019),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFFC8019)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(122, 28), // Set only the height to 28, not the full width
                          padding: EdgeInsets.zero, // Remove default padding
                        ),
                        icon: const Icon(
                          Icons.call,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4), // Top and bottom padding of 4
                          child: Text(
                            'Call Recipient',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1, // Adjust line height to align with padding
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle show on map action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFC8019),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFFC8019)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(128, 28), // Set only the height to 28, not the full width
                          padding: EdgeInsets.zero, // Remove default padding
                        ),
                        icon: const Icon(
                          Icons.location_on_sharp,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4), // Top and bottom padding of 4
                          child: Text(
                            'Show on maps',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1, // Adjust line height to align with padding
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width,
            height: 74,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Home
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home'); // Navigate to the Home screen
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 37,
                          height: 37,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            'assets/homegrey.svg',
                            height: 10,
                            width: 20,
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // My Donation
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/history'); // Navigate to the History screen
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 39.55,
                          height: 39.55,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            'assets/history.svg',
                            height: 10,
                            width: 20,
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'History',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Donate Now
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/donate'); // Navigate to the Donate Now screen
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 39.55,
                          height: 39.55,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            'assets/donatenow.svg',
                            height: 10,
                            width: 20,
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Donate Now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorites
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/maps'); // Navigate to the Maps screen
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 39.55,
                          height: 39.55,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            'assets/maps.svg',
                            height: 10,
                            width: 20,
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Maps',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Account
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/message'); // Navigate to the Message screen
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 39.55,
                          height: 39.55,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            'assets/message.svg',
                            height: 10,
                            width: 20,
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'Message',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )

        ),
      ),
    );
  }

  Widget buildNavItem(String label, String asset, String route) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(asset, height: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
