class Hotel {
  String hotelId;
  String picture;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  double perNight;
  double discount;
  Hotel(
    this.hotelId,
    this.picture ,
    this.titleTxt,
    this.subTxt,
    this.dist,
    this.reviews,
    this.rating,
    this.perNight,
    this.discount,
  );
  HotelEntity toEntity() {
    return HotelEntity(
      hotelId: hotelId,
      picture: picture,
      titleTxt: titleTxt,
      subTxt: subTxt,
      dist: dist,
      reviews: reviews,
      rating: rating,
      perNight: perNight,
      discount: discount,
    );
  }

	static Hotel fromEntity(HotelEntity entity) {
    return Hotel(
      hotelId: entity.hotelId,
      picture: entity.picture,
      titleTxt: entity.titleTxt,
      subTxt: entity.subTxt,
      dist: entity.dist,
      reviews: entity.reviews,
      rating: entity.rating,
      perNight: entity.perNight,
      discount: entity.discount,
    );
  }
}
