import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:albanianews_flutter/pages.dart';

class OpenPage extends StatelessWidget {

  WPPage page;

  OpenPage(this.page);

  _getPostImage() {
    if (page.image == null) {
      return SizedBox(height: 10,);
    } else {
      return Image.network(page.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Padding(
            padding: EdgeInsets.all(1.5),
            child: ListView(
              children: <Widget>[
                Text(
                  page.title.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                SizedBox(height: 10,),
                _getPostImage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(page.date.replaceAll('T', ' ')),
                    //Text(page.author.toString())
                  ],
                ),
                SizedBox(height: 20,),
                Html(
                  data: page.content,
                  onLinkTap: (String url) {
                    _launchUrl(url);
                  },
                )
              ],
            ),
          )
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