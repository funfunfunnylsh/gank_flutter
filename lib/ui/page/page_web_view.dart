import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gank_flutter/common/model/gank_item.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatefulWidget {
  final GankItem gankItem;

  WebViewPage(this.gankItem);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _favorite = false;

  @override
  void initState() {
    super.initState();
  }

  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.gankItem.desc),
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.favorite,
//                  color: _favorite ? Colors.red : Colors.white),
//              onPressed: () async {
//
//              }),
//          IconButton(
//              icon: Icon(Icons.language),
//              onPressed: () async {
//                if (await canLaunch(widget.gankItem.url)) {
//                  launch(widget.gankItem.url);
//                }
//              })
//        ],
      ),
      withLocalStorage: true,
      url: widget.gankItem.url,
      withJavascript: true,
    );
  }
}
