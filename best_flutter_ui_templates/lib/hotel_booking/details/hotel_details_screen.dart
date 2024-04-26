import 'package:best_flutter_ui_templates/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:best_flutter_ui_templates/custom_drawer/home_drawer.dart';
import 'package:best_flutter_ui_templates/hotel_booking/calendar_popup_view.dart';
import 'package:best_flutter_ui_templates/hotel_booking/details/hotel_details_screen.dart';
import 'package:best_flutter_ui_templates/hotel_booking/hotel_list_view.dart';
import 'package:best_flutter_ui_templates/hotel_booking/model/hotel_list_data.dart';
import 'package:best_flutter_ui_templates/navigation_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHotelImage(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: buildHotelDetails(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildHotelImage() {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/hotel/hotel_1.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHotelDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grand Royal Hotel',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '123 Street, City, Country',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your booking logic here
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          '\$180/per night',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget tortor nulla. Quisque molestie enim at odio commodo, ut suscipit ipsum dapibus. Nullam ut felis vitae velit dictum hendrerit.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 20),
        buildAmenities("Amenities:", Icons.pool, "Swimming Pool", context),
        buildAmenities("", Icons.restaurant, "Restaurant", context),
        buildAmenities("", Icons.local_parking, "Parking", context),
        // Add more amenities here
      ],
    );
  }

  Widget buildAmenities(String title, IconData icon, String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 30),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}



