import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroid/widgets/common_loading.dart';
import 'package:webview_flutter/webview_flutter.dart';
/*
* webview详情页面
* */
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
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (context,snapshot){
        return WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      _controller.complete(controller);
                    },
                    navigationDelegate: (NavigationRequest request) {

                      var url = request.url;
                      if (url.startsWith('bilibili') || url.startsWith('https://www.jianshu.com')
                      ||url.startsWith('https://www.csdn.net')) {
                        print('blocking navigation to $request}');
                        return NavigationDecision.prevent;
                      }
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

                    },
                  ),
                  isLoading ? CommonLoading() : Container(),
                ],
              )

            ),
            onWillPop: () async{
              if(snapshot.hasData){
                var canGoBack = await snapshot.data.canGoBack();
                if(canGoBack){
                  await snapshot.data.goBack();
                  return Future.value(false);//表示不退出
                }
              }

              return Future.value(true);//表示退出
            }
            );
      },
    );

  }
}

