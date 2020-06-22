import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/project_top_title_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/widgets/common_loading.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<ProjectTopTitleData> tabItems = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    //获取页面数据
    _getProjectData();
  }

  @override
  Widget build(BuildContext context) {
    return tabItems.length > 0  ? 
    Column(
      children: <Widget>[
        Container(
          child: TabBar(tabs: null),
        )
      ],
    ) : CommonLoading();
  }

  @override
  bool get wantKeepAlive => true;

  void _getProjectData() async {
    DioHelper().get(RequestUrl.getProjectTopTitle, null, (projectTopTitle) {
      setState(() {
        tabItems = ProjectTopTitleEntity().fromJson(projectTopTitle).data;
        _tabController =
            new TabController(length: tabItems.length, vsync: this);
      });
    }, (errMsg) {
      ToastHelper.showToast(errMsg.toString());
    });
  }
}
