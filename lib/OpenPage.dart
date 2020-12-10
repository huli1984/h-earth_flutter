import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:albanianews_flutter/pages.dart';
import 'package:albanianews_flutter/title_card.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_html/html_parser.dart';

class OpenPage extends StatelessWidget {

  WPPage page;
  var my_color;

  OpenPage(this.page, this.my_color);

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
                TitleCard(page.title.toString(), my_color),
                SizedBox(height: 12,),
                _getPostImage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Text(page.date.replaceAll('T', ' ')),
                    //Text(page.author.toString())
                  ],
                ),
                SizedBox(height: 20,),
                Html(
                  data: page.content,
                  style: {
                    "div": Style(
                        margin: EdgeInsets.all(16),
                        border: Border.all(width: 6),
                        backgroundColor: Colors.grey,
                    ),
                    "p": Style(
                      fontSize: FontSize(18),
                      alignment: Alignment(1.0, 1.0)
                    ),
                  },
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