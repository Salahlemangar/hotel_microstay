import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  int id;
  String name;
  String description;
  String location;
  String image;
  int phoneNumber;
  double latitude;
  double longitude;
  double price;
  double rating;

  Hotel(
      {this.id,
      this.name,
      this.description,
      this.location,
      this.image,
      this.phoneNumber,
      this.latitude,
      this.longitude,
      this.price,
      this.rating});
  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);
  Map<String,dynamic> toJson() => _$HotelToJson(this);
  
}
 