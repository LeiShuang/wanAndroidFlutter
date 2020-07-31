import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/data/entitys/banner_entity_entity.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/data/entitys/top_article_entity.dart';
import 'package:wanandroid/generated/json/base/json_convert_content.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/pages/home/home_article.dart';
import 'package:wanandroid/pages/home/home_banner.dart';
import 'package:wanandroid/pages/home/home_drawer_page.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/routers/routers.dart';
import 'package:wanandroid/utils/back_desktop.dart';
import 'package:wanandroid/utils/string_utils.dart';
import 'package:wanandroid/widgets/common_loading.dart';
import 'package:wanandroid/widgets/loading_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  List<BannerEntityData> bannerLists = List();
  List<HomeArticleEntityDataData> topArticleLists = List();
  List<HomeArticleEntityDataData> articleLists = List();
  List<HomeArticleEntityDataData> allLists = List();
  LoadState _loadState = LoadState.State_Loading;
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
                  NavigatorUtils.push(context, Routes.homeSearch);
                })
          ],
        ),
        body: _getContent());
  }

  //获取控件
  Widget _getContent() {
    /*  return
        //轮播图
        <Widget>[HomeTopBanner(data: bannerLists), _getArticleWidget()];*/
    return LoadStateLayout(
        loadState: _loadState,
        errRetry: () {
          setState(() {
            _getHomeData();
          });
        },
        emptyRetry: () {
          setState(() {
            _getHomeData();
          });
        },
        successWidget: Column(
          children: [HomeTopBanner(data: bannerLists), _getArticleWidget()],
        ));
  }

  //获取首页数据
  void _getHomeData() {
    _getBannerData();
    _getTopArticleData();
    _getArticleListData();
  }

  void _getTopArticleData() async {
    DioHelper().get(RequestUrl.getHomeTopArticle, null, (data) {
      List<HomeArticleEntityDataData> toparticles =
          TopArticleEntity().fromJson(data).data;
      setState(() {
        topArticleLists.clear();
        topArticleLists.addAll(toparticles);
        print("topArticleLists的长度是${topArticleLists.length},数据是" +topArticleLists.toString());
      });
    }, (err) {
      ToastHelper.showToast(err.toString());
    });
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

  void _getArticleListData() async {
    await DioHelper().get('article/list/$_index/json', null, (articleData) {
      List<HomeArticleEntityDataData> articles =HomeArticleEntityEntity().fromJson(articleData).data.datas;
      if (mounted) {
        setState(() {
          if(_index == 0){
            articleLists.clear();
            articleLists.addAll(topArticleLists);
            print("topArticleLists的长度是${topArticleLists.length}");
            articleLists.addAll(articles);
            if(articleLists.length == 0){
              _loadState = LoadState.State_Empty;
            }else{
              _loadState = LoadState.State_Success;
            }
          }else{
            articleLists.addAll(articles);
            _loadState = LoadState.State_Success;
          }
        });
        print("articleInfo:" + articles.toString());
      }
    }, (error) {
      setState(() {
        _loadState = LoadState.State_Error;
        ToastHelper.showToast(error.toString());
      });
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
