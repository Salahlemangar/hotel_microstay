import 'package:flutter/material.dart';
import 'package:hotel_macrostay/screens/Hotel_details.dart';
import 'package:hotel_macrostay/services/hotelServices.dart';
import 'package:hotel_macrostay/widgets/BottomBar.dart';
import 'package:hotel_macrostay/widgets/card_hotels.dart';
import 'package:hotel_macrostay/styles/theme.dart' as style;
import 'package:hotel_macrostay/model/hotel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  TextEditingController controller = new TextEditingController();
  String keyword;
  bool searchActive= false;

  Future<List<Hotel>> getData() async {
    return await HotelService().getHotels();
  }
  Future<List<Hotel>> searchData() async{
    return await HotelService().getHotelByName(keyword);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData();
    controller.addListener(() {
      setState(() {
       keyword = controller.text; 
       searchActive = true;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: style.Colors.mainColor,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                iconTheme:
                    IconThemeData(color: style.Colors.mainColor, size: 28),
              ),
              child: Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white70,
                      Colors.white60,
                      Colors.white54,
                      Colors.white38,
                      Colors.white30,
                      Colors.white24,
                      Colors.white12,
                      Colors.white10
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Find your Hotel",
                              style: TextStyle(
                                color: style.Colors.secondColor,
                                letterSpacing: 1.0,
                                fontFamily: 'Pacifico',
                                fontSize: 30.0,
                                //fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: TextField(
                textDirection: TextDirection.ltr,
                cursorColor: Colors.grey,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                  hintText: 'Search for hotel',
                  hintStyle: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                controller: controller,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: FutureBuilder<List<Hotel>>(
                future: searchActive?searchData(): getData(),
                builder: (context, AsyncSnapshot<List<Hotel>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting &&
                      snapshot.hasData) {
                    var hotelList = snapshot.data;
                    print(hotelList);

                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        itemCount: hotelList.length,
                        itemBuilder: (context, index) {
                          print(hotelList[index]);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HotelDetail(hotelList[index]),
                                ),
                              );
                            },
                            child: cardHotels(size, hotelList[index]),
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            BottomBar(
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }
}
