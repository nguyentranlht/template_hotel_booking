import 'package:flutter/material.dart';
import 'package:hotel_repository/src/entities/entities.dart';

class Location {
  String locationID;
  int dist;
  String address;
  Location({
    required this.locationID,
    required this.dist,
    required this.address,
  });
  LocationEntity toEntity() {
    return LocationEntity(
      locationID: locationID,
      dist: dist,
      address: address,
    );
  }

	static Location fromEntity(LocationEntity entity) {
    return Location(
      locationID: entity.locationID,
      dist: entity.dist,
      address: entity.address,
    );
  }
}
