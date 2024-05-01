import 'package:flutter/material.dart';
import 'package:hotel_repository/src/entities/entities.dart';

class Location {
  double dist;
  String address;
  Location({
    required this.dist,
    required this.address,
  });
  LocationEntity toEntity() {
    return LocationEntity(
      dist: dist,
      address: address,
    );
  }

	static Location fromEntity(LocationEntity entity) {
    return Location(
      dist: entity.dist,
      address: entity.address,
    );
  }
}
