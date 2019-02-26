import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatefulWidget {
  final String fullUrl;

  WebViewScreen({Key key, @required this.fullUrl}) : super(key: key);

  @override
  WebViewScreenState createState() {
    return new WebViewScreenState();
  }
}

class WebViewScreenState extends State<WebViewScreen> {
  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.fullUrl,
      withLocalStorage: true,
      withJavascript: true,
      appBar: AppBar(
        title: Text(_webLinkHelper(widget.fullUrl)),
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
