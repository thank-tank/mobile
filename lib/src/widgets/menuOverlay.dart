import 'package:flutter/material.dart';

class MenuOverlay extends StatelessWidget {
  final String jwt;

  MenuOverlay(this.jwt);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(70), topRight: Radius.circular(70)),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(25, 25, 25, 100)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 130,
                  child: DrawerHeader(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image(
                          image: AssetImage('assets/img/water.png'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "ThankTank",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(
                    thickness: 0.7,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  child: Text(
                    "Share your gratitude with the world by dropping something of appreciation into the ThankTank.\n\n\n\nEvery drop will be matched with monetary donations to water relief funds to bring water to those without access to clean, sanitary water.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      height: 1.4,
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
