import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/data/entitys/project_top_title_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/pages/home/project_list_page.dart';
import 'package:wanandroid/utils/theme_utils.dart';
import 'package:wanandroid/widgets/common_loading.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<ProjectTopTitleData> _tabItems = [];
  TabController _tabController;

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
      body: _tabItems.length > 0
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
          : _showLoadingView(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _getProjectData() async {
    DioHelper().get(RequestUrl.getProjectTopTitle, null, (projectTopTitle) {
      setState(() {
        _tabItems = ProjectTopTitleEntity().fromJson(projectTopTitle).data;
        _tabController =
            new TabController(length: _tabItems.length, vsync: this);
      });
    }, (errMsg) {
      ToastHelper.showToast(errMsg.toString());
    });
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

Widget _showLoadingView() {
  return Container(
    height: ScreenUtil().setHeight(1400),
    child: CommonLoading(),
  );
}
