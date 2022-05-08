import 'package:flutter/material.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/feed/feed.dart';
import 'package:infostitch/screen/profile/profile.dart';
import 'package:infostitch/screen/search/search.dart';
import 'package:infostitch/screen/townhall/townhall.dart';

class Home extends StatefulWidget {
  String value1;
  String value2;
  int indexForCheck;
  int districtId;
  Home(this.value1,this.value2,this.indexForCheck,this.districtId);
  @override
  _HomeState createState() => _HomeState(value1,value2,indexForCheck,districtId);
}

class _HomeState extends State<Home> {
  String value1;
  String value2;
  int indexForCheck;
  int districtId;
  _HomeState(this.value1,this.value2,this.indexForCheck,this.districtId);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
      Feed(value1,value2,indexForCheck,districtId),
      Search(),
      TownHall(),
      Profile(),
    ];
    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        height: 82,
        child: ClipRRect(
           borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _selectedIndex==0?
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImageIcon(AssetImage('images/feed_hover.png'),),
                  ):
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImageIcon(AssetImage('images/feed.png'),),
                  ),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex==1?
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImageIcon(AssetImage('images/searchNew.png'),),
                  ):
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                     child: ImageIcon(AssetImage('images/searchNew.png'),),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex==2?
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImageIcon(AssetImage('images/townhall_hover.png'),),
                  ):
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImageIcon(AssetImage('images/townhall.png'),),
                  ),
                  label: 'Townhall',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex==3?
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImageIcon(AssetImage('images/profile_hover.png'),),
                  ):
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImageIcon(AssetImage('images/profile.png'),),
                  ),
                  label: 'Profile',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              backgroundColor: secondColor,
              selectedItemColor: purpleColor,
              unselectedItemColor: grey2,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
