import 'models/model.dart';

abstract class HotelRepo {
  Future <List<Hotel>> getHotels();
}