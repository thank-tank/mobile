import 'package:flutter/material.dart';
import 'package:swim/src/onboard/auth.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Auth()));
        },
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100,
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Image(
                  image: AssetImage('assets/img/water.png'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "ThankTank",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              Spacer(),
              Text(
                '"We ourselves feel that what we are doing is just a drop in the ocean. But the ocean would be less because of that missing drop."',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "- Mother Theresa",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
