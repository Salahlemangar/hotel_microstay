import 'package:flutter/material.dart';
import 'package:hotel_macrostay/model/hotel.dart';
import 'package:hotel_macrostay/screens/map_view.dart';
import 'package:hotel_macrostay/widgets/BottomBar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HotelDetail extends StatefulWidget {
  static const String id='hotel_detail_screen';
  Hotel _hotel;
  
  HotelDetail(Hotel hotel) {
    _hotel = hotel;
  }
  @override
  _HotelDetailState createState() => _HotelDetailState(_hotel);
}

class _HotelDetailState extends State<HotelDetail> {
  
  Hotel _hotel;
  _HotelDetailState(Hotel hotel) {
    _hotel = hotel;
  }
  @override
  Widget build(BuildContext context) {
    final String image = 'http://10.0.2.2:8080/imageHotel/${_hotel.id}';
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black26),
            height: 350,
            child: Hero(
              tag: _hotel,
                          child: Image(image: NetworkImage(image),fit: BoxFit.cover,),
              ),
            ),
          
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${_hotel.name}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        "8.5/85 Reviews",
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: null)
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                  RatingBarIndicator(
                                      rating: _hotel.rating,
                                      itemCount: 5,
                                      itemSize: 18.0,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.location_on,
                                        size: 16.0,
                                      ),
                                    ),
                                    TextSpan(text: "8 km to Mohammedia")
                                  ]),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "\$ ${_hotel.price}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "/Per Night",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                        
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: (){
                            Navigator.pushNamed(context, MapView.id);
                          },
                          
                          color: Colors.blueAccent,
                          
                          textColor: Colors.white,
                          child: Text(
                            "See Location ",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      
                      Text(
                        "Description".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "this hotel has the most fantastic view you have ever seen , it's localized on north california",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${_hotel.description}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              
              ],
            ),
          ),
            Align(
                  alignment: Alignment.topLeft,
                 
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      "DETAIL",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
         BottomBar(alignment: Alignment.bottomCenter,),
        ],
      ),
    );
  }
}
