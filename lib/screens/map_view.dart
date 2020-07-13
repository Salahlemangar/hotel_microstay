import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_macrostay/model/hotel.dart';
import 'package:hotel_macrostay/services/hotelServices.dart';
import 'package:hotel_macrostay/styles/theme.dart'as style;
import 'package:hotel_macrostay/widgets/BottomBar.dart';

const kGoogleApiKey = "AIzaSyDG4ZoPbqmHYH0_NNYgabosmDLIyfnBO04";

GoogleMapController mapController ;

class MapView extends StatefulWidget {
  static const String id = 'map_view';
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(33.784785,-7.1683133),zoom: 11);
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;
  Set<Marker> markers = {};
  List<Hotel> hotels;
  bool isLoaded = false;

   Future<List<Hotel>> getData() async {
     hotels= await HotelService().getHotels();
     setState(() {
       isLoaded=true;
     });
     return hotels; 
   }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
       
     //   mapController.animateCamera(
       //   CameraUpdate.newCameraPosition(
         //   CameraPosition(
           //   target: LatLng(position.latitude, position.longitude),
            //  zoom: 18.0,
            //),
         // ),
        //);
      });
    }).catchError((e) {
      print(e);
    });
  }

    Set<Marker> getMarkers(){
      for (var h in hotels) {
       setState(() {
        markers.add(Marker(markerId: MarkerId('${h.id}'),
        position: LatLng(h.latitude, h.longitude),
        infoWindow: InfoWindow(title: '${h.name}'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),);});
      }
      return markers;
     
    }

  /*//nearby hotels
  @override
  void didChangeDependencies() async{

    super.didChangeDependencies();
    print(await searchNearBy('hotel'));

  }
    Future<List<String>> searchNearBy(String keyword) async{
      var dio=Dio();
      var url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
      var parameters={
        'key': kGoogleApiKey,
        'location': '$_currentPosition',
        'radius':'800',
        'keyword':keyword
      };
      var response = await dio.get(url,queryParameters:parameters);
      print(response.data);
      return response.data['results'].map<String>((result)=>result['name'].toString()).toList();
  }

*/
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getData();
    
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
     return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: isLoaded ? Stack(
          children: <Widget>[
            // Map View
            GoogleMap(
              markers:
                  markers = getMarkers(),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController=controller;
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.grey, // button color
                        child: InkWell(
                          splashColor: Colors.white, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                         
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.grey, // button color
                        child: InkWell(
                          splashColor: Colors.white, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                           
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: style.Colors.secondColor, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(
                            Icons.my_location,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                       
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            buildContainer(hotels),
           
            Container(
              margin: EdgeInsets.only(top: 18),
                          child: BottomBar(alignment: Alignment.topRight,)
            ),
          ],
        ):Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget cardHotel(String image, Hotel hotel ) {

  return GestureDetector(
    onTap: () {
      gotoLocation(hotel.latitude,hotel.longitude);
    },
    child: Container(
      child: new FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 180,
                width: 200,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(24.0),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(image),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: myDetailContainer(hotel),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}


Widget buildContainer(List<Hotel> hotels) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        itemBuilder: (_,index){
           return 
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: cardHotel(
                'http://10.0.2.2:8080/imageHotel/${hotels[index].id}',hotels[index]),
           );
        },
      
      ),
    ),
  );
}



void gotoLocation(double lat, double long)  {
 
  mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, long), zoom: 14)));
}

Widget myDetailContainer(Hotel hotel) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Container(
          child: Text(
            hotel.name,
            style: TextStyle(
                color: Color(0xFF6200EE),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Text(
                "${hotel.rating}",
                style: TextStyle(color: Colors.black54, fontSize: 18.0),
              ),
            ),
            Container(
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                Icons.star_border,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            
          ],
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Container(
        child: Text(
          "\$${hotel.price}",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Container(
        child: Text(
          "Open",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
