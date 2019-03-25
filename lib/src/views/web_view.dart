import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String fullUrl;
  final int itemId;

  WebViewScreen({Key key, @required this.fullUrl, @required this.itemId})
      : super(key: key);

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
      body: _buildWebView(widget.fullUrl, _controller),
      floatingActionButton: _actionButton(context, widget.itemId),
    );
  }
}

WebView _buildWebView(
    String fullLink, Completer<WebViewController> controller) {
  return WebView(
    initialUrl: fullLink,
    javascriptMode: JavascriptMode.unrestricted,
    onWebViewCreated: (WebViewController webViewController) {
      controller.complete(webViewController);
    },
  );
}

FloatingActionButton _actionButton(BuildContext context, int itemId) {
  return FloatingActionButton(
    tooltip: "Article Comments",
    child: Icon(Icons.comment),
    onPressed: () {
      Navigator.pushNamed(context, "/comments/$itemId");
    },
  );
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
