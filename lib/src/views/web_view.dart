import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String fullUrl;

  WebViewScreen({Key key, @required this.fullUrl}) : super(key: key);

  @override
  WebViewScreenState createState() {
    return new WebViewScreenState();
  }
}

class WebViewScreenState extends State<WebViewScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _webViewAppBar(widget.fullUrl),
    );
  }
}

AppBar _webViewAppBar(String fullLink) {
  return AppBar(
    title: Text(_webLinkHelper(fullLink)),
  );
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
