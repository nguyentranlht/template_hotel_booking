class LocationEntity {
  double dist;
  String address;
  LocationEntity({
    required this.dist,
    required this.address,
  });
  Map<String, Object?> toDocument() {
    return {
      'dist': dist,
      'address': address,

};}

  static LocationEntity fromDocument(Map<String, dynamic> doc) {
    return LocationEntity(
      dist: doc['dist'] as double,
      address: doc['address'] as String,
    );
  }
}
