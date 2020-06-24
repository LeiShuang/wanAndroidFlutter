import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/data/api/RequestString.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/pages/home/project_list_item.dart';
import 'package:wanandroid/widgets/common_loading.dart';

class ProjectListPage extends StatefulWidget {
  final int id;

  ProjectListPage({
    Key key,
    @required int id,
  })  : this.id = id,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProjectListPage();
  }
}

class _ProjectListPage extends State<ProjectListPage>
    with AutomaticKeepAliveClientMixin {
  var _currentPage = 1;
  List<HomeArticleEntityDataData> articlesList = [];
  RefreshController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController =  RefreshController();
    _loadListData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
      articlesList.length > 0
        ? SmartRefresher(
            controller:
            _scrollController,
            enablePullUp: true,
            onRefresh: _onRresh,
            onLoading: _onLoadingMore,
            child: new StaggeredGridView.countBuilder(
              itemCount: articlesList.length,
              crossAxisCount: 4,
              itemBuilder: (BuildContext context, int index) => new Container(
                child: ProjectListItem(
                  index: index,
                  data: articlesList[index],
                ),
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            ))
        : CommonLoading();
  }

  void _loadListData() async {
    await DioHelper().get(
        "project/list/$_currentPage/json?cid=${widget.id.toString()}", null,
        (listData) {
      setState(() {
        if (_currentPage == 1) {
          articlesList.clear();
          articlesList.addAll(HomeArticleEntityEntity().fromJson(listData).data.datas);
        } else {
          articlesList.addAll(HomeArticleEntityEntity().fromJson(listData).data.datas);
        }
      });
    }, (errMsg) {
      ToastHelper.showToast(errMsg.toString());
    });
  }

  @override
  bool get wantKeepAlive => true;

  void _onRresh() async {
    _currentPage = 1;
    _loadListData();
    _scrollController.refreshCompleted();
  }

  void _onLoadingMore() async{
    _currentPage++;
    _loadListData();
    _scrollController.loadComplete();
  }
}
