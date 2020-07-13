import 'package:flutter/material.dart';
import 'package:hotel_macrostay/model/hotel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget cardHotels(Size size, Hotel item) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25)),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [new BoxShadow(color: Colors.grey[300], blurRadius: 25.0)]),
        height: 280,
        width: size.width,
        child: GestureDetector(
                  child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0)
            ),
            elevation: 8,
            shadowColor: Colors.grey[100],
            margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Hero(
                      tag:item ,
                                          child: Container(
                        height: 180,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          image: DecorationImage(
                              image:  NetworkImage('http://10.0.2.2:8080/imageHotel/${item.id}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${item.name}",
                                  style: TextStyle(
                                  //  fontWeight: FontWeight.bold,
                                    fontFamily: 'Pacifico'
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "${item.location}",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey,fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    RatingBarIndicator(
                                      rating: item.rating,
                                      itemCount: 5,
                                      itemSize: 18.0,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    Text(
                                      "4/5 Reviews",
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.grey,fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "\$ ${item.price}",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Pacifico'),
                                ),
                                Text(
                                  "Per Night",
                                  style:
                                      TextStyle(fontSize: 13, color: Colors.grey,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //Positioned(child: )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
