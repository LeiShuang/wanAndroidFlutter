import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/pages/home/home_article.dart';
import 'package:wanandroid/widgets/common_loading.dart';

class SearchListPage extends StatefulWidget {
  const SearchListPage({Key key, @required String title})
      : _title = title,
        super(key: key);
  final String _title;

  @override
  _SearchListPageState createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  int _page = 0;
  List<HomeArticleEntityDataData> lists = List();
  RefreshController _controller = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _getSearchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget._title,
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          child: lists.length > 0
              ? SmartRefresher(
                  controller: _controller,
                  onRefresh: _onRefresh,
                  onLoading: _onLoadMore,
                  enablePullUp: true,
                  child: ListView.builder(
                    itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                    return HomeArticleWidget(
                      data: lists[index],
                    );
                  }),
                )
              : CommonLoading(),
        ));
  }

  void _getSearchData() async {
    await DioHelper().post("article/query/$_page/json", {'k': widget._title},
        (successCallBack) {
      HomeArticleEntityEntity info =
          HomeArticleEntityEntity().fromJson(successCallBack);
      if (info.errorCode == 0) {
        if (mounted) {
          setState(() {
            if (_page == 0) {
              lists.clear();
              lists.addAll(info.data.datas);
            } else {
              lists.addAll(info.data.datas);
            }
          });

        }
      } else {
        ToastHelper.showWarning(info.errorMsg.toString());
      }
    }, (errorCallBack) {
      ToastHelper.showWarning(errorCallBack.toString());
    });
  }

  void _onRefresh() async {
    _page = 0;
    _getSearchData();
    _controller.refreshCompleted();
  }

  void _onLoadMore() async {
    _page++;
    _getSearchData();
    _controller.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
