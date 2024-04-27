class LocationEntity {
  String locationID;
  int dist;
  String address;
  LocationEntity({
    required this.locationID,
    required this.dist,
    required this.address,
  });
  Map<String, Object?> toDocument() {
    return {
      'locationID': locationID,
      'dist': dist,
      'address': address,

};}

  static LocationEntity fromDocument(Map<String, dynamic> doc) {
    return LocationEntity(
      locationID: doc['location'],
      dist: doc['dist'],
      address: doc['address'],
    );
  }
}
