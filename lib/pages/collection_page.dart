import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/config/dio_err_code.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/pages/home/home_article.dart';
import 'package:wanandroid/widgets/collection_item.dart';
import 'package:wanandroid/widgets/common_loading.dart';
import 'package:wanandroid/widgets/loading_state.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  LoadState _listLoadState = LoadState.State_Loading;
  int _page = 0;
  RefreshController _controller = RefreshController(initialRefresh: false);
  List<HomeArticleEntityDataData> lists = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '我的收藏',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: _getList(context)
    );
  }

  Widget _getList(BuildContext context) {
    return LoadStateLayout(loadState: _listLoadState, errRetry: () {
      setState(() {
        _listLoadState = LoadState.State_Error;
      });
      _getCollectionInfo();
    }, emptyRetry: () {
      setState(() {
        _listLoadState = LoadState.State_Empty;
      });
      _getCollectionInfo();
    }, successWidget: SmartRefresher(
      controller: _controller,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      enablePullUp: true,
      child: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (BuildContext context, int index) {
            return CollectionItem(info: lists[index]);
          }),
    ));
  }

  @override
  void initState() {
    super.initState();
    _getCollectionInfo();
  }

  void _onRefresh() async {
    _page = 0;
    _getCollectionInfo();
    _controller.refreshCompleted();
  }

  void _onLoadMore() async {
    _page++;
    _getCollectionInfo();
    _controller.loadComplete();
  }

  void _getCollectionInfo() async {
    await DioHelper().get("lg/collect/list/$_page/json", null,
            (successCallBack) {
          HomeArticleEntityEntity info =
          HomeArticleEntityEntity().fromJson(successCallBack);
          if (info.errorCode == ResultCode.SUCCESS) {
            if (mounted) {
              setState(() {
                _listLoadState = LoadState.State_Success;
                if (_page == 0) {
                  lists.clear();
                  lists.addAll(info.data.datas);
                } else {
                  lists.addAll(info.data.datas);
                }
              });
            }
          } else if (info.errorCode == 666) {
            if(_page == 0){
              setState(() {
                _listLoadState = LoadState.State_Empty;
              });
            }
          } else {
            ToastHelper.showWarning(info.errorMsg);
            setState(() {
              _listLoadState = LoadState.State_Error;
            });
          }
        }, (errorCallBack) {
          setState(() {
            _listLoadState = LoadState.State_Error;
          });
          ToastHelper.showWarning(errorCallBack.toString());
        });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
