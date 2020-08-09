import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:swim/src/widgets/dropGratitude.dart';
import 'package:swim/src/widgets/homeFeed.dart';
import 'package:swim/src/widgets/menuOverlay.dart';
import 'package:swim/src/widgets/titleBar.dart';
import 'package:swim/src/widgets/userProfile.dart';

class Home extends StatefulWidget {
  final String jwt;
  final String username;
  final String password;
  final String userId;

  Home(this.jwt, this.username, this.password, this.userId);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tabIndex = 0;
  List<Widget> tabs;
  List<String> tabLabels = ["Gratitude Ocean", "ThankTank", "My Stream"];

  @override
  void initState() {
    super.initState();
    tabs = [
      HomeFeed(widget.jwt, widget.username, widget.password),
      DropGratitude(widget.jwt, widget.username, widget.password),
      UserProfile(widget.jwt, widget.username, widget.password),
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
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context).disabledColor,
                  size: 35,
                  semanticLabel: "Ocean",
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Theme.of(context).buttonColor,
                  size: 35,
                  semanticLabel: "Ocean",
                ),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/img/water.png"),
                  color: Theme.of(context).disabledColor,
                  size: 30,
                  semanticLabel: "ThankTank",
                ),
                activeIcon: ImageIcon(
                  AssetImage("assets/img/water.png"),
                  color: Theme.of(context).buttonColor,
                  size: 30,
                  semanticLabel: "ThankTank",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).disabledColor,
                  size: 35,
                  semanticLabel: "Your Stream",
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).buttonColor,
                  size: 35,
                  semanticLabel: "Your Stream",
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
