import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TitleCard extends StatefulWidget {

  String title;
  var my_color;
  TitleCard(this.title, this.my_color);

  @override
  _TitleCardState createState() => _TitleCardState(title, my_color);
}

class _TitleCardState extends State<TitleCard>
    with SingleTickerProviderStateMixin {
  String text;
  var my_color;
  _TitleCardState(this.text, this.my_color);
  
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      margin: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
      child:
          Column(
            children: <Widget>[
              Image.asset("assets/h-eart_logo.png", scale: 4.5,),
              Text(
                  '${text}'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..shader = ui.Gradient.linear(
                          const Offset(0, 150),
                          const Offset(20, 0),
                          <Color>[
                            my_color,
                            Colors.white,
                        ],
                      )
                ),
              ),
            ]
          ),
    );
  }
}
