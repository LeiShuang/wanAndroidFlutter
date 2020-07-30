import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/data/entitys/project_top_title_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/pages/home/project_list_page.dart';
import 'package:wanandroid/utils/theme_utils.dart';
import 'package:wanandroid/widgets/common_loading.dart';
import 'package:wanandroid/widgets/loading_state.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<ProjectTopTitleData> _tabItems = [];
  TabController _tabController;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    //获取页面数据
    _getProjectData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '项目',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _getTab(),
      /* _tabItems.length > 0
          ? Column(
              children: <Widget>[
                Container(
                  child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      labelPadding: EdgeInsets.all(5),
                      labelColor: ThemeUtils.defaultColor,
                      indicatorColor: ThemeUtils.defaultColor,
                      indicatorPadding: EdgeInsets.all(5),
                      tabs: _tabItems.map((titleData) {
                        return Text(
                          titleData.name,
                          style: TextStyle(
                              color: ThemeUtils.defaultColor, fontSize: 16.0),
                        );
                      }).toList()),
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: _tabItems.map((items) {
                    return ProjectListPage(
                      id: items.id,
                    );
                  }).toList(),
                ))
              ],
            )
          : _showLoadingView(),*/
    );
  }
  Widget _getTab(){
    return LoadStateLayout(loadState: _loadState, errRetry: (){
      setState(() {
        _loadState = LoadState.State_Error;
      });
    }, emptyRetry: (){
      setState(() {
        _loadState = LoadState.State_Empty;
      });
    }, successWidget: Column(
      children: [
        Container(
          child: TabBar(
              isScrollable: true,
              controller: _tabController,
              labelPadding: EdgeInsets.all(5),
              labelColor: ThemeUtils.defaultColor,
              indicatorColor: ThemeUtils.defaultColor,
              indicatorPadding: EdgeInsets.all(5),
              tabs: _tabItems.map((titleData) {
                return Text(
                  titleData.name,
                  style: TextStyle(
                      color: ThemeUtils.defaultColor, fontSize: 16.0),
                );
              }).toList()),
        ),
        Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabItems.map((items) {
                return ProjectListPage(
                  id: items.id,
                );
              }).toList(),
            ))
      ],
    ));
  }
  @override
  bool get wantKeepAlive => true;

  void _getProjectData() async {
    DioHelper().get(RequestUrl.getProjectTopTitle, null, (projectTopTitle) {
      setState(() {
        _tabItems = ProjectTopTitleEntity().fromJson(projectTopTitle).data;
        _tabController =
        new TabController(length: _tabItems.length, vsync: this);
        if(_tabItems.length == 0){
         _loadState =  LoadState.State_Empty;
        }else{
          _loadState =  LoadState.State_Success;
        }

      });
    }, (errMsg) {
      setState(() {
        _loadState =  LoadState.State_Error;
        ToastHelper.showToast(errMsg.toString());
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

