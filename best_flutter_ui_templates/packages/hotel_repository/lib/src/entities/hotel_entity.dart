import 'package:hotel_repository/src/entities/entities.dart';
import '../models/model.dart';

class HotelEntity {
  String hotelId;
  String picture;
  String titleTxt;
  double rating;
  int reviews;
  int perNight;
  int discount;
  Location location;
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
      'location': location.toEntity().toDocument(),
    };
  }

  static HotelEntity fromDocument(Map<String, dynamic> doc) {
    return HotelEntity(
      hotelId: doc['hotelId'] as String,
      picture: doc['picture'] as String,
      titleTxt: doc['titleTxt'] as String,
      reviews: doc['reviews'] as int,
      rating: doc['rating'] as double,
      perNight: doc['perNight'] as int,
      discount: doc['discount'] as int,
      location:
          Location.fromEntity(LocationEntity.fromDocument(doc['location'])),
    );
  }
}
