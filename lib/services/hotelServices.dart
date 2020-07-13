import 'dart:convert';
import 'package:hotel_macrostay/model/hotel.dart';
import 'package:http/http.dart' as http;

const url = 'http://10.0.2.2:8080/getHotels';
const searchurl = 'http://10.0.2.2:8080/findHotel?keyword=';

class HotelService {
  Future<List<Hotel>> getHotels() async {
    try {
      http.Response response = await http.get(url);
      List<dynamic> decodedJson = jsonDecode(response.body);
      List<Hotel> hotels = decodedJson
          .map((decodedJson) => Hotel.fromJson(decodedJson))
          .toList();

      return hotels;
    } catch (error) {
      print("Exception ocured : $error ");
      return null;
    }
  }

  Future<List<Hotel>> getHotelByName(String keyword) async {
    try {
      http.Response response = await http.get(searchurl + keyword);
      List<dynamic> decodedJson = jsonDecode(response.body);
      List<Hotel> hotels = decodedJson
          .map((decodedJson) => Hotel.fromJson(decodedJson))
          .toList();
      return hotels;
    } catch (error) {
      print("Exception occured : $error");
      return null;
    }
  }
}
