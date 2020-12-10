import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vec;

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
  bool selector =  false;

  Future<void> _startAnimation() async {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        selector = true;
      });
    });
  }

  @override
  void initState() {
    _startAnimation();
    _controller = AnimationController(vsync: this);
    selector = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Card(
      borderOnForeground: false,
      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: AnimatedContainer(
        width: selector ? 50.0 : 50.0,
        height: selector ? 100.0 : 50.0,
        //transform: selector ? Matrix4.rotationZ(math.pi*2) : Matrix4.rotationZ(math.pi*1/2),
        transform: selector ? Matrix4.translation(vec.Vector3(0.0, 0.0, 0.0)) : Matrix4.translation(vec.Vector3(-width+70.0,0.0, 0.0)),
        color: selector ? Colors.white : Colors.green,
        alignment:
        selector ? Alignment.center : AlignmentDirectional.topCenter,
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
        child: AnimatedContainer(
            width: selector ? width : 50.0,
            height: selector ? 150.0 : 10.0,
            curve: Curves.easeInOutQuad,
            duration: Duration(milliseconds: 2000),
            child: AnimatedOpacity(
              opacity: selector ? 1.0 : 1.0,
              curve: Curves.easeInOutQuad,
              duration: Duration(milliseconds: 2000),
              child: Image.asset("assets/h-eart_logo.png", scale: 4.5,),
          )
        )
      ),
    );
  }
}
