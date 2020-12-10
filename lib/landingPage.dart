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
import 'package:albanianews_flutter/title_card.dart';
import 'package:albanianews_flutter/PostCard.dart';
import 'package:albanianews_flutter/OpenPage.dart';
import 'package:animated_card/animated_card.dart';

class LandingPage extends StatefulWidget {
  int number;
  var my_color;
  int type;
  LandingPage(this.number, this.my_color, this.type);
  @override
  _LandingPageState createState() => _LandingPageState(number, my_color, type);
}

class _LandingPageState extends State<LandingPage> {
  String url = "https://h-earth.it/?rest_route=/wp/v2/posts&?_embed";
  String pages_url = "https://h-earth.it/?rest_route=/wp/v2/pages";
  bool isLoading = false;
  var selectedPage;
  List<Post> posts = List();
  List<WPPage> pages = List();
  int pageValues;
  var my_color;
  int type;

  _LandingPageState(this.pageValues, this.my_color, this.type);

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

    if (type == 0) {
      return Scaffold(
          body: this.isLoading
              ? Center(
            child: CircularProgressIndicator(),
          ):  Container(
              height: newheight,
              child: Stack(
                  children: <Widget>[
                    OpenPage(selectedPage, my_color),
                  ])
        )
      );
    } else if (type == 1) {
      return Scaffold(
          body: this.isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            itemCount: posts.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[PostCard(post: posts[index])],
              );
            },
          ));
    } else if (type == 2) {
      return Scaffold(
          body: this.isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder());
    }
  }
}