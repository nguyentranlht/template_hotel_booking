import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_repository/hotel_repository.dart';
import 'package:hotel_repository/src/models/hotel.dart';

class FirebaseHotelRepo implements HotelRepo {
  final hotelCollection = FirebaseFirestore.instance.collection('hotels');
  @override
  Future<List<Hotel>> getHotels() async {
    try {
      return hotelCollection.get().then((value) => value.docs
          .map((e) => Hotel.fromEntity(HotelEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
