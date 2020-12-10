import 'dart:convert';

import 'package:albanianews_flutter/OpenPage.dart';
import 'package:albanianews_flutter/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordpress_api/wordpress_api.dart';
import 'package:albanianews_flutter/routing.dart';
import 'package:http/http.dart' as http;
import 'package:albanianews_flutter/post.dart';
import 'package:albanianews_flutter/pages.dart';
import 'package:albanianews_flutter/PostCard.dart';
import 'package:albanianews_flutter/OpenPage.dart';

class LandingPage extends StatefulWidget {
  int number;
  LandingPage(this.number);
  @override
  _LandingPageState createState() => _LandingPageState(number);
}

class _LandingPageState extends State<LandingPage> {
  String url = "https://h-earth.it/?rest_route=/wp/v2/posts&?_embed";
  String pages_url = "https://h-earth.it/?rest_route=/wp/v2/pages";
  bool isLoading = false;
  var selectedPage;
  List<Post> posts = List();
  List<WPPage> pages = List();
  int pageValues;

  _LandingPageState(this.pageValues);

  @override
  void initState() {
    _fetchPosts();
    _fetchPages();
    super.initState();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(this.url);
    if (response.statusCode == 200) {
      posts = (json.decode(response.body) as List).map((data) {
        return Post.fromJSON(data);
      }).toList();
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchPages() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(this.pages_url);
    if (response.statusCode == 200) {
      pages = (json.decode(response.body) as List).map((data) {
        return WPPage.fromJSON(data);
      }).toList();
      setState(() {
          for( var i = 0; i < pages.length; i++ ) {
            if (pages[i].id == pageValues){
              selectedPage =  pages[i];
              isLoading = false;
            }
          }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
        /*appBar: AppBar(
          title: Text(selectedPage.title),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),*/
        body: this.isLoading
            ? Center(
          child: CircularProgressIndicator(),
        ):  Container(
            height: newheight,
            child: Stack(
                children: <Widget>[OpenPage(selectedPage)])

    )
    );
  }
}