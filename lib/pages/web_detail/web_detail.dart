import 'package:flutter/material.dart';
import 'package:wanandroid/widgets/common_loading.dart';
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
  bool isLoading = true;
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
//        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
      WebView(
      initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        navigationDelegate: (NavigationRequest request) {
          var url = request.url;
          print("visit$url");
          setState(() {
            isLoading = true;
          });
          return NavigationDecision.navigate;
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
//          _controller.evaluateJavascript("document.title").then((result){
//            setState(() {
//              _title = result;
//            });
//          });
        },
      ),
      isLoading ? CommonLoading() : Container(),
      ],
    ));
  }
}

