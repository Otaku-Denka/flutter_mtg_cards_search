import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  String url;
  final String title;

  WebView({Key key, this.title, this.url}) : super(key: key);
  @override
  _WebViewState createState() => new _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  String name = '';
  bool exiting = false;
  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          break;
        default:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          _appBar(),
          Expanded(
              flex: 1,
              child: WebviewScaffold(
                userAgent: 'null',
                url: widget.url,
                withZoom: true,
                withLocalStorage: true,
                hidden: true,
                initialChild: Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    )),
              ))
        ],
      ),
    ));
  }

  _appBar() {
    if (widget.title.length > 25) {
      name = widget.title.substring(0, 25) + "...";
    } else {
      name = widget.title;
    }
    return Container(
      color: Colors.brown,
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
