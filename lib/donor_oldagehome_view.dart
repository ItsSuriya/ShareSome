import 'package:flutter/material.dart';

class DonorOldagehomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
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
              padding: const EdgeInsets.only(top: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: orientation == Orientation.portrait ? 16 / 9 : 3 / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          'assets/image 4(v).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Anugraham Home',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '324/7, New No 3, 3 Cross, Opp Madhu Sweets, Chickpet, Bangalore, Karnataka, 560053.',
                      style: TextStyle(
                        color: Color(0xFF9AA2AB),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildActionRow(),
                    SizedBox(height: 16),
                    Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus.',
                      style: TextStyle(
                        color: Color(0xFF9AA2AB),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Government Identity Licence',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildLicenceRow(),
                    SizedBox(height: 33),
                    Text(
                      'Photos & Videos',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildPhotosAndVideosRow([
                      'assets/dview1.png',
                      'assets/dview2.png',
                      'assets/dview3.png',
                      'assets/dview4.png',
                      'assets/dview5.png',
                      'assets/dview6.png',

                    ]),
                    SizedBox(height: 80), // Leave space for the donate button
                  ],
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      bottomSheet: Container(
        color: Colors.white, // Set background to white
        padding: const EdgeInsets.all(14.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
              'Donate Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Change button color
            minimumSize: Size.fromHeight(48), // Ensure full-width on bottom
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Set border radius to 8
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildActionButton('assets/call.png', 'Call'),
        SizedBox(width: 13),
        buildActionButton('assets/viewmsg.png', 'Message'),
        SizedBox(width: 13),
        buildActionButton('assets/share.png', 'Share'),
      ],
    );
  }

  Widget buildActionButton(String iconPath, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFFC8019)),
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
            style: TextStyle(
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

  Widget buildLicenceRow() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFFC8019)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Image.asset('assets/certi.png'),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Lc4578ncue44522',
              style: TextStyle(
                color: Color(0xFFFC8019),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0.14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhotosAndVideosRow(List<String> imagePaths) {
    return SizedBox(
      height: 57,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: imagePaths.map((path) {
          return AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
