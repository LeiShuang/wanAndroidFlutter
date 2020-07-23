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
              width: 150,
              height: 150,
              child: Image.asset(
                "images/icon_loading.gif",
                fit: BoxFit.cover,
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
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: InkWell(
        onTap: widget._errRetry,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().setWidth(400),
              height: ScreenUtil().setHeight(300),
              child: Image.asset("images/icon_err.png"),
            ),
            Text(
              '加载失败,请轻触重试!',
              style: TextStyle(
                  color: Colors.green, fontSize: ScreenUtil().setSp(22)),
            )
          ],
        ),
      ),
    );
  }
}
