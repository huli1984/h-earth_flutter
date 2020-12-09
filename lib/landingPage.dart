import 'dart:convert';

import 'package:albanianews_flutter/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordpress_api/wordpress_api.dart';
import 'package:albanianews_flutter/routing.dart';
import 'package:http/http.dart' as http;
import 'package:albanianews_flutter/post.dart';
import 'package:albanianews_flutter/PostCard.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String url = "https://h-earth.it/?rest_route=/wp/v2/posts&?_embed";
  bool isLoading = false;
  List<Post> posts = List();

  @override
  void initState() {
    _fetchPosts();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
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
  }
}