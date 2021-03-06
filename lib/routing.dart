import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:albanianews_flutter/landingPage.dart';

class Destination {
  const Destination(this.title, this.icon, this.image_icon, this.color, this.rgbColor, this.page_id_value, this.kind);
  final String title;
  final IconData icon;
  final ImageIcon image_icon;
  final MaterialColor color;
  final Color rgbColor;
  final int page_id_value;
  final int kind;

}

const cart_icon = ImageIcon(
    AssetImage("assets/logoGarbiniCart.png")
);

const home_icon = ImageIcon(
    AssetImage("assets/cuore.png")
);

const servizi_icon = ImageIcon(
    AssetImage("assets/mani.png")
);

const List<Destination> allDestinations = <Destination>[

  Destination('home', null, home_icon, null, Color.fromARGB(200, 35, 160, 50), 3569, 0),
  Destination('servizi', null, servizi_icon, null, Color.fromARGB(200, 240, 47, 28), 3569, 0),
  Destination('AR', Icons.camera, null, Colors.lightGreen, null, 4539, 0),
  Destination('shop', null, cart_icon , Colors.blue, null, 3614, 0)
];

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}): super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
    );
  }

  @override
  Widget build(BuildContext context) {
    var mColor;
    var mColorBack;
    if (widget.destination.color != null){
      mColor = widget.destination.color;
      mColorBack = mColor[100];
    } else {
      mColor = widget.destination.rgbColor;
      mColorBack = mColor.withAlpha(0);
    }

    return Scaffold(
      /*appBar: AppBar(
        title: Text('H-earth ${widget.destination.title}'.toUpperCase(), style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
        backgroundColor: mColor,
        toolbarHeight: 32.0,
        centerTitle: false,
      ),*/
      backgroundColor: mColorBack,
      body: Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.center,
        child: LandingPage(widget.destination.page_id_value, mColor, widget.destination.kind),//TextField(controller: _textController),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: allDestinations.map<Widget>((Destination destination) {
            return DestinationView(destination: destination);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allDestinations.map((Destination destination) {
          var myIcon;
          if (destination.icon != null) {
            myIcon = Icon(destination.icon);
          } else {
            myIcon = destination.image_icon;
          }

          var mColor;
          if (destination.color != null){
            mColor = destination.color;
          } else {
            mColor = destination.rgbColor;
          }

          return BottomNavigationBarItem(
              icon: myIcon,
              backgroundColor: mColor,
              title: Text(destination.title)
          );
        }).toList(),
      ),
    );
  }
}

//void main() {
//  runApp(MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false));
//}

