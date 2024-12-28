import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipientAvailableFoodDonor extends StatefulWidget {
  const RecipientAvailableFoodDonor({super.key});

  @override
  State<RecipientAvailableFoodDonor> createState() =>
      _RecipientAvailableFoodDonorState();
}

class _RecipientAvailableFoodDonorState
    extends State<RecipientAvailableFoodDonor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Function to fetch food posts along with the corresponding donor business names
  Stream<List<Map<String, dynamic>>> _fetchFoodPosts() {
    return FirebaseFirestore.instance
        .collection('Donation')
        .snapshots()
        .asyncMap((snapshot) async {
      List<Map<String, dynamic>> foodData = [];
      for (var doc in snapshot.docs) {
        var foodPost = doc.data();
        var donorId = foodPost['donorId'];

        // Fetch donor details from "donors" collection
        // var donorSnapshot = await FirebaseFirestore.instance.collection('donors').doc(donorId).get();
        // var businessName = donorSnapshot.data()?['businessName'] ?? 'Unknown';

        // Add donor's business name to food post data
        foodData.add({
          'businessName': foodPost['Business Name'],
          'distance': foodPost['Location'],
          'title': foodPost['foodType'],
          // 'description': foodPost['description'] ?? '',  // Add description if needed
        });
      }
      return foodData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Available food donors',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _fetchFoodPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No food posts available'));
          }

          var foodPosts = snapshot.data!;

          return ListView.builder(
            itemCount: foodPosts.length,
            itemBuilder: (context, index) {
              var post = foodPosts[index];
              String businessName = post['businessName'] ?? '';
              String distance = post['distance'] ?? '';
              String title = post['title'] ?? '';
              String description = post['description'] ?? '';

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
                    // Top Row with Donor's Business Name and Distance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          businessName,
                          style: const TextStyle(
                            color: Color(0xFFFC8019),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/delivery.svg'),
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
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFFFC8019),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      "$businessName is offering food for you",
                      style: const TextStyle(
                        color: Color(0xFF9AA2AB),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Action Buttons
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle call action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFC8019),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFFC8019)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(122, 28),
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(Icons.call,
                              size: 16, color: Colors.white),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Call Recipient',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
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
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFFC8019)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(128, 28),
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(Icons.location_on_sharp,
                              size: 16, color: Colors.white),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Show on maps',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Push the arrow button to the end of the row
                        IconButton(
                          onPressed: () {
                            // Handle arrow button action (if any)
                          },
                          icon: const Icon(Icons.arrow_forward,
                              color: Color(0xFFFC8019)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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
                  Navigator.pushNamed(
                      context, '/home'); // Navigate to the Home screen
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
                        'assets/home.svg',
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
                  Navigator.pushNamed(
                      context, '/history'); // Navigate to the History screen
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
                  Navigator.pushNamed(
                      context, '/donate'); // Navigate to the Donate Now screen
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
                  Navigator.pushNamed(
                      context, '/maps'); // Navigate to the Maps screen
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
                  Navigator.pushNamed(
                      context, '/message'); // Navigate to the Message screen
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
        ),
      ),
    );
  }
}
