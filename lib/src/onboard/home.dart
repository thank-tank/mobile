import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:swim/src/widgets/chatFeed.dart';
import 'package:swim/src/widgets/dropGratitude.dart';
import 'package:swim/src/widgets/homeFeed.dart';
import 'package:swim/src/widgets/menuOverlay.dart';
import 'package:swim/src/widgets/titleBar.dart';
import 'package:swim/src/widgets/userProfile.dart';

class Home extends StatefulWidget {
  final String jwt;
  final String username;
  final String password;

  Home(this.jwt, this.username, this.password);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tabIndex = 0;
  List<Widget> tabs;
  List<String> tabLabels = ["Home", "Drop Gratitude", "Chat", "Profile"];

  @override
  void initState() {
    super.initState();
    tabs = [
      HomeFeed(widget.jwt),
      DropGratitude(widget.jwt, widget.username, widget.password),
      ChatFeed(widget.jwt),
      UserProfile(widget.jwt),
    ];
  }

  void onTabSwitch(int index) {
    setState(() {
      this.tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Center(
          child: tabs.elementAt(this.tabIndex),
        ),
        appBar: TitleBar(tabLabels.elementAt(this.tabIndex)),
        drawer: MenuOverlay(widget.jwt),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.all(0),
          child: CupertinoTabBar(
            border: Border(top: BorderSide.none),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context).disabledColor,
                  size: 35,
                  semanticLabel: "Home",
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Theme.of(context).buttonColor,
                  size: 35,
                  semanticLabel: "Home",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Theme.of(context).disabledColor,
                  size: 35,
                  semanticLabel: "Home",
                ),
                activeIcon: Icon(
                  Icons.add_circle_outline,
                  color: Theme.of(context).buttonColor,
                  size: 35,
                  semanticLabel: "Home",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: Theme.of(context).disabledColor,
                  size: 35,
                  semanticLabel: "Chat",
                ),
                activeIcon: Icon(
                  Icons.chat,
                  color: Theme.of(context).buttonColor,
                  size: 35,
                  semanticLabel: "Chat",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).disabledColor,
                  size: 35,
                  semanticLabel: "Profile",
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).buttonColor,
                  size: 35,
                  semanticLabel: "Profile",
                ),
              ),
            ],
            currentIndex: this.tabIndex,
            onTap: this.onTabSwitch,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ),
      ),
    );
  }
}
