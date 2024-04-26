class HotelEntity {
  String hotelId;
  String picture;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  double perNight;
  double discount;
  HotelEntity(
    this.hotelId,
    this.picture,
    this.titleTxt,
    this.subTxt,
    this.dist,
    this.reviews,
    this.rating,
    this.perNight,
    this.discount,
  );
  Map<String, Object?> toDocument() {
    return {
      'hotelId': hotelId,
      'picture': picture,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'discount': discount,
    };
  }

  static HotelEntity fromDocument(Map<String, dynamic> doc) {
    return HotelEntity(
        id: doc['id'] as String,
        email: doc['email'] as String,
        name: doc['name'] as String,
        picture: doc['picture'] as String?);
  }
}
