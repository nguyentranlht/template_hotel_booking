import 'package:hotel_repository/src/entities/entities.dart';
import '../models/model.dart';

class HotelEntity {
  String hotelId;
  String picture;
  String titleTxt;
  double rating;
  int reviews;
  double perNight;
  double discount;
  List <Location> location;
  HotelEntity({
    required this.hotelId,
    required this.picture,
    required this.titleTxt,
    required this.reviews,
    required this.rating,
    required this.perNight,
    required this.discount,
    required this.location,
  });
  Map<String, Object?> toDocument() {
    return {
      'hotelId': hotelId,
      'picture': picture,
      'titleTxt': titleTxt,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'discount': discount,
      'location': location.map((location) => location.toEntity().toDocument()),
    };
  }

  static HotelEntity fromDocument(Map<String, dynamic> doc) {
    return HotelEntity(
      hotelId: doc['hotelId'],
      picture: doc['picture'],
      titleTxt: doc['titleTxt'],
      reviews: doc['reviews'],
      rating: doc['rating'],
      perNight: doc['perNight'],
      discount: doc['discount'],
      location: doc['location'].map((e) => Location.fromEntity(LocationEntity.fromDocument(e))),
    );
  }
}
