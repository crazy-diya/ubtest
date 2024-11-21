import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranger extends StatefulWidget {
  @override
  _RangerState createState() => _RangerState();
}

class _RangerState extends State<Ranger> {
  double priceRange  = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(priceRange.toString()),
            Container(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0,top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Container(
                      width: (MediaQuery.of(context).size.width-20)/5,
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("0"),
                          Container(
                            height: 10.0,
                            color: Colors.grey,
                            width: 0.5,
                          )
                        ],
                      )
                  ),
                Container(
                      width: (MediaQuery.of(context).size.width-20)/5,
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          const Text("25"),
                          Container(
                            height: 10.0,
                            color: Colors.grey,
                            width: 0.5,
                          )
                        ],
                      )
                  ),
                  Container(
                      width: (MediaQuery.of(context).size.width-20)/5,
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          const Text("0"),
                          Container(
                            height: 10.0,
                            color: Colors.grey,
                            width: 0.5,
                          )
                        ],
                      )
                  ),
                  Container(
                      width: (MediaQuery.of(context).size.width-20)/5,
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          const Text("0"),
                          Container(
                            height: 10.0,
                            color: Colors.grey,
                            width: 0.5,
                          )
                        ],
                      )
                  ),
                 Container(
                      width: (MediaQuery.of(context).size.width-20)/5,
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("0"),
                          Container(
                            height: 10.0,
                            color: Colors.grey,
                            width: 0.5,
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
             Container(
              padding: EdgeInsets.only(left: ((MediaQuery.of(context).size.width-20)/5)/2,right: ((MediaQuery.of(context).size.width-20)/5)/2),
              width: MediaQuery.of(context).size.width,
              child:CupertinoSlider(
                value: priceRange,
                onChanged: (value) {
                  setState(() {
                    priceRange = value;
                  });
                },
                max: 100,
                min: 0,
                divisions: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}