import 'package:flutter/material.dart';
import 'package:hotel_macrostay/screens/home_screen.dart';
import 'package:hotel_macrostay/screens/welcome_screen.dart';
import 'package:hotel_macrostay/screens/map_view.dart';
import 'package:hotel_macrostay/styles/theme.dart' as style;

class BottomBar extends StatefulWidget {
  final AlignmentGeometry alignment;
  BottomBar({this.alignment});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentindex = 1;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _currentindex=index;
          });
        },
        currentIndex: _currentindex,
        elevation: 0,
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        backgroundColor: style.Colors.mainColor,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                  
                }),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapView()),
                  );
                 
                }),
            title: Text("Near"),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  // _auth.signOut();
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }),
            title: Text("Sign out"),
          ),
        ],
      ),
    );
  }
}
