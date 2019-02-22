//todo: modify the app.dart file to use routes

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatelessWidget {
  final int itemId;
  final String itemUrl;

  WebView({this.itemId, this.itemUrl});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: itemUrl,
      withLocalStorage: true,
      withJavascript: true,
      appBar: AppBar(
        title: Text(_webLinkHelper(itemUrl)),
        actions: <Widget>[
          _actionButtonBuilder(Icons.comment, null),
          _actionButtonBuilder(Icons.star, null),
        ],
      ),
    );
  }
}

String _webLinkHelper(String fullLink) {
  var uri = Uri.parse(fullLink);
  String host = uri.host.replaceAll("w", "");
  if (host.indexOf(".") == 0) {
    return host.replaceFirst(".", "");
  }
  return host;
}

FlatButton _actionButtonBuilder(IconData icon, Function action) {
  return FlatButton(
    child: Icon(icon),
    onPressed: () {
      return action;
    },
  );
}

//todo: action to favorite an article
//todo: action to goto comments
