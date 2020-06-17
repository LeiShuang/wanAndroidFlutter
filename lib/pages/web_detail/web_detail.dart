
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//void main() => runApp(WebDetailApp());

//class WebDetailApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: "详情",
//      theme: ThemeData(primarySwatch: Colors.blue),
//      home: WebDetailPage(),
//    );
//  }
//}

class WebDetailPage extends StatefulWidget {

  const WebDetailPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  _WebDetailPageState createState() => _WebDetailPageState();
}

class _WebDetailPageState extends State<WebDetailPage> {
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
//        automaticallyImplyLeading: false,
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          _controller = controller;
        },
        onPageFinished: (url) {
//          _controller.evaluateJavascript("document.title").then((result){
//            setState(() {
//              _title = result;
//            });
//          });
        },
      ),
    );
  }
}

