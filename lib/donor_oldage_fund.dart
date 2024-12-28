import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorOldAgeFund extends StatelessWidget {
  final List<String> photos = [
    'assets/dview1.png',
    'assets/dview2.png',
    'assets/dview3.png',
    'assets/dview4.png',
    'assets/dview5.png',
    'assets/dview6.png',
    'assets/dview2.png',
    'assets/dview3.png',
    'assets/dview4.png',
    'assets/dview5.png',
    'assets/dview6.png',
    'assets/dview2.png',
  ];

  final List<Map<String, dynamic>> dummyFoodItems = [
    {'name': 'Idli', 'quantity': 10, 'isVeg': true},
    {'name': 'Dosa', 'quantity': 5, 'isVeg': true},
    {'name': 'Vada', 'quantity': 15, 'isVeg': true},
    {'name': 'Chicken Curry', 'quantity': 3, 'isVeg': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(32.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section
                  AspectRatio(
                    aspectRatio:
                        orientation == Orientation.portrait ? 16 / 9 : 3 / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullScreenPhotoGallery(photos: photos, initialIndex: 0),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/saravana.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Hotel Name
                  const Text(
                    'Hotel Saravana Bhavan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Address
                  const Text(
                    '115, Anna Salai, Heritage Town, Puducherry',
                    style: TextStyle(
                      color: Color(0xFF9AA2AB),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Action Buttons
                  buildActionRow(context),
                  const SizedBox(height: 16),
                  // Photos & Videos
                  const Text(
                    'Photos & Videos',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  buildPhotosAndVideosRow(photos),
                  const SizedBox(height: 16),
                  const Divider(),
                  // Preferred Time
                  Row(
                    children: [
                      SvgPicture.asset('assets/time.svg'),
                      const SizedBox(width: 8),
                      const Text(
                        'Preferred time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Today, Sept 12, 2:30PM',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFFC8019),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Labels for food items and quantity
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Food Items',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Dummy Food List
                  Column(
                    children: dummyFoodItems.map((item) {
                      return _buildFoodItem(
                        item['name'],
                        item['quantity'],
                        item['isVeg'] ? 'assets/veg.png' : 'assets/nveg.png',
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  // Dynamic Claim Text
                  Column(
                    children: dummyFoodItems.map((item) {
                      return _buildFoodItem(
                        item['name'],
                        item['quantity'],
                        item['isVeg'] ? 'assets/veg.png' : 'assets/nveg.png',
                      );
                    }).toList(),
                  ),
                  Column(
                    children: [
                      // Other widgets in the Column

                      // Dummy Food List
                      Column(
                        children: dummyFoodItems.map((item) {
                          return _buildFoodItem(
                            item['name'],
                            item['quantity'],
                            item['isVeg']
                                ? 'assets/veg.png'
                                : 'assets/nveg.png',
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 15),
                      const Divider(),

                      // Claim Text Container
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Claim before Sept 12, 4.30PM',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(14.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFC8019),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
              'Claim Donation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Action Buttons Row
  Widget buildActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _makeCall(),
          child: buildActionButton('assets/call.png', 'Call'),
        ),
        const SizedBox(width: 13),
        buildActionButton('assets/viewmsg.png', 'Message'),
        const SizedBox(width: 13),
        GestureDetector(
          onTap: () => _shareDetails(),
          child: buildActionButton('assets/share.png', 'Share'),
        ),
      ],
    );
  }

  // Single Action Button
  Widget buildActionButton(String iconPath, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFFC8019)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFC8019),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Photos & Videos Row
  Widget buildPhotosAndVideosRow(List<String> imagePaths) {
    return SizedBox(
      height: 57,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          final path = imagePaths[index];
          return AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenPhotoGallery(
                            photos: imagePaths, initialIndex: index),
                      ),
                    );
                  },
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Food Item List
  Widget _buildFoodItem(String name, int qty, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        children: [
          Image.asset(imagePath, width: 16, height: 16),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            qty.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Share Details
  void _shareDetails() {
    String hotelName = "Hotel Saravana Bhavan";
    String foodItems = "Idli - 10\nDosa - 5\nVada - 15";
    String link = "https://example.com/page";
    Share.share("$hotelName\n\nFood Items:\n$foodItems\n\nLink: $link");
  }

  // Make a Call
  void _makeCall() async {
    String dummyNumber = "tel:9360893385";
    if (await canLaunch(dummyNumber)) {
      await launch(dummyNumber);
    } else {
      throw 'Could not launch $dummyNumber';
    }
  }
}

// Full-Screen Photo Gallery
class FullScreenPhotoGallery extends StatelessWidget {
  final List<String> photos;
  final int initialIndex;

  FullScreenPhotoGallery({required this.photos, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: PhotoViewGallery.builder(
          itemCount: photos.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(photos[index]),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          pageController: PageController(initialPage: initialIndex),
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
