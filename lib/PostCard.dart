import 'package:flutter/material.dart';
import 'package:albanianews_flutter/post.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:albanianews_flutter/DetailPost.dart';
import 'package:flutter_html/style.dart';

class PostCard extends StatelessWidget {

  final Post post;

  PostCard({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) {
                  return DetailPost(post);
                },
                fullscreenDialog: true
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            post.image != null
                ? Image.network(post.image)
                : SizedBox(),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Html(
                data: post.title,
                style: {
                  "div": Style(
                  margin: EdgeInsets.all(16),
                  border: Border.all(width: 6),
                  backgroundColor: Colors.grey,
                  ),
                  "title": Style(
                    margin: EdgeInsets.all(16),
                    border: Border.all(width: 6),
                    backgroundColor: Colors.grey,
                  ),
                }
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Html(
                data: post.excerpt,
                onLinkTap: (String link) {
                  _launchUrl(link);
                },
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    post.date.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue
                    ),
                  ),
                  Text(
                    post.author.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}


_launchUrl(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Cannot launch $link';
  }
}