import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_repository/hotel_repository.dart';

class FirebaseHotelRepo implements HotelRepo {
  final hotelCollection = FirebaseFirestore.instance.collection('hotel');
  Future <List<Hotel>> getHotels() async{
    try {
      return await hotelCollection
      .get()
      .then((value) => value.docs.map((e) => 
      Hotel.fromEntity(HotelEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }
}