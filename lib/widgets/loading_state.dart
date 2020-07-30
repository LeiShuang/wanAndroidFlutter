import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/widgets/common_empty.dart';

enum LoadState { State_Success, State_Error, State_Empty, State_Loading }

//根据不同状态来展示不同的视图
class LoadStateLayout extends StatefulWidget {
  LoadStateLayout(
      {Key key,
      @required LoadState loadState,
      @required VoidCallback errRetry,
      @required VoidCallback emptyRetry,
        @required Widget successWidget,})
      : _state = loadState,
        _errRetry = errRetry,
        _emptyRetry = emptyRetry,
        _successWidget = successWidget,
        super(key: key);
  final LoadState _state; //页面加载状态
  final Widget _successWidget; //成功加载视图
  final VoidCallback _errRetry; //错误事件回调
  final VoidCallback _emptyRetry; //空数据事件回调
  @override
  _LoadStateLayoutState createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LoadStateLayout> {
  String _errorContentMesage = "网络请求失败，请检查您的网络";
  String _errImgPath = "images/ic_error.png";
  FontWeight _fontWidget = FontWeight.w600; //错误页面和空页面的字体粗度
  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    switch (widget._state) {
      case LoadState.State_Success:
        return widget._successWidget;
        break;
      case LoadState.State_Error:
        return _errView();
        break;
      case LoadState.State_Empty:
        return CommonEmptyPage(emptyCallBack:widget._emptyRetry);
        break;
      case LoadState.State_Loading:
        return _loadingView();
        break;
      default:
        break;
    }
  }

  Widget _loadingView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 180,
              child: Image.asset(
                "images/icon_loading.gif",
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              "拼命加载中...",
              style: TextStyle(
                  color: Colors.grey, fontSize: 22),
            )
          ],
        ),
      ),
    );
  }

  Widget _errView() {
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(_errImgPath),
              width: 120,
              height: 120,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(_errorContentMesage,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: _fontWidget,
                  )),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: OutlineButton(
                  child: Text("重新加载",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: _fontWidget,
                      )),
                  onPressed: () => {widget._errRetry},
                ))
          ],
        ),
      ),
    );
  }
}
