import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/data/entitys/banner_entity_entity.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/generated/json/base/json_convert_content.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/pages/home/home_article.dart';
import 'package:wanandroid/pages/home/home_banner.dart';
import 'package:wanandroid/pages/home/home_drawer_page.dart';
import 'package:wanandroid/utils/string_utils.dart';
import 'package:wanandroid/widgets/common_loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{
  List<BannerEntityData> bannerLists = List();
  List<HomeArticleEntityDataData> articleLists = List();
  RefreshController _homeRefreshController =
      RefreshController(initialRefresh: false);
  int _index = 0; //当前页面索引
  @override
  void initState() {
    super.initState();
    _getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
     return Scaffold(
       drawer: HomeDrawerPage(),
        appBar: AppBar(
          title: Text(
            StringUtils.home,
            style: TextStyle(color: Colors.white),
          ),

          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  ToastHelper.showToast('点击了搜索');
                })
          ],
        ),
        body: Column(
            children: bannerLists.length > 0 && articleLists.length > 0
                ? _getContent()
                : _showLoadingView()));
    /*return Container(
        child: Column(
            children: bannerLists.length > 0 && articleLists.length > 0
                ? _getContent()
                : _showLoadingView()));*/
  }

  //获取控件
  List<Widget> _getContent() {
    return
        //轮播图
        <Widget>[HomeTopBanner(data: bannerLists), _getArticleWidget()];
  }

  List<Widget> _showLoadingView() {
    return <Widget>[
      Container(
        height: ScreenUtil().setHeight(1400),
        child: CommonLoading(),
      )
    ];
  }

  //获取首页数据
  void _getHomeData() {
    _getBannerData();
    _getArticleListData();
  }

  void _getBannerData() async {
    DioHelper().get(RequestUrl.getHomeBannerInfo, null, (data) {
      setState(() {
        bannerLists.clear();
        bannerLists.addAll(BannerEntityEntity().fromJson(data).data);
        print("bannerInfo:" + data.toString());
      });
    }, (error) {
      ToastHelper.showToast("获取数据失败");
    });
  }

  void _getArticleListData() {
    DioHelper().get('article/list/$_index/json', null, (articleData) {
      setState(() {
        List<HomeArticleEntityDataData> articles =
            HomeArticleEntityEntity().fromJson(articleData).data.datas;
        articleLists.clear();
        articleLists.addAll(articles);
        print("articleInfo:" + articles.toString());
      });
    }, (error) {
      ToastHelper.showToast("获取数据失败");
    });
  }

  //获取列表控件
  Widget _getArticleWidget() {
    return Expanded(
        child: SmartRefresher(
      controller: _homeRefreshController,
      child: ListView.builder(
          itemCount: articleLists.length,
          itemBuilder: (BuildContext context, int index) {
            return HomeArticleWidget(data: articleLists[index]);
          }),
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
    ));
  }

  void _onRefresh() async {
    _index = 0;
    _getArticleListData();
    _homeRefreshController.refreshCompleted();
  }

  void _onLoadMore() async {
    _index++;
    _getArticleListData();
    _homeRefreshController.loadComplete();
  }

  @override
  bool get wantKeepAlive => true;
}
