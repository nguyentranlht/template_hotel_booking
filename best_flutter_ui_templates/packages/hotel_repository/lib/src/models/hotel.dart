//import 'dart:html';
import '../entities/entities.dart';
import '../models/model.dart';

class Hotel {
  String hotelId;
  String picture;
  String titleTxt;
  double rating;
  int reviews;
  int perNight;
  int discount;
  Location location;
  Hotel({
    required this.hotelId,
    required this.picture,
    required this.titleTxt,
    required this.reviews,
    required this.rating,
    required this.perNight,
    required this.discount,
    required this.location,
  });
  HotelEntity toEntity() {
    return HotelEntity(
      hotelId: hotelId,
      picture: picture,
      titleTxt: titleTxt,
      reviews: reviews,
      rating: rating,
      perNight: perNight,
      discount: discount,
      location: location,
    );
  }

  static Hotel fromEntity(HotelEntity entity) {
    return Hotel(
      hotelId: entity.hotelId,
      picture: entity.picture,
      titleTxt: entity.titleTxt,
      reviews: entity.reviews,
      rating: entity.rating,
      perNight: entity.perNight,
      discount: entity.discount,
      location: entity.location,
    );
  }
}
