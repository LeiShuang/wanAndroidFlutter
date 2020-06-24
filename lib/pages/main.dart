import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/pages/home/home_view.dart';
import 'package:wanandroid/routers/application.dart';
import 'package:wanandroid/routers/routers.dart';
import 'package:wanandroid/utils/theme_utils.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp(){
    //初始化路由
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {
  Color themeColor = ThemeUtils.currentColorTheme;

  @override
  void initState() {
    super.initState();
    /*DataHelper.getColorThemeIndex().then((index) {
      print('当前主题色的index = $index');
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        //发送eventBus
        eventBus.fire(ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    //全局配置刷新控件
    return RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(),
      // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
      footerBuilder: () => CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Text("上拉加载");
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("加载失败！点击重试！");
          }
          else if(mode == LoadStatus.canLoading){
            body = Text("松手,加载更多!");
          }
          else{
            body = Text("没有更多数据了!");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      // 配置默认底部指示器
      headerTriggerDistance: 80.0,
      // 头部触发刷新的越界距离
      springDescription:
      SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      // 自定义回弹动画,三个属性值意义请查询flutter api
      maxOverScrollExtent: 100,
      //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxUnderScrollExtent: 0,
      // 底部最大可以拖动的范围
      enableScrollWhenRefreshCompleted: true,
      //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
      enableLoadingWhenFailed: true,
      //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      hideFooterWhenNotFull: false,
      // Viewport不满一屏时,禁用上拉加载更多功能
      enableBallisticLoad: true,
      // 可以通过惯性滑动触发加载更多
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //取消默认的debug显示
        theme:
        ThemeData(
          //默认的theme颜色
            primaryColor: themeColor,
            //右划返回
            platform: TargetPlatform.iOS
        ),
        title: '玩安卓',
//        routes: {
//          '/HomePage': (context) => HomePage(),
//          '/ProjectPage': (context) => ProfilePage(),
//          '/SortPage': (context) => SystemsPage(),
//          '/ProfilePage': (context) => WebGuidePage(),
//
//        },
        home: HomeView(),
      ),
    );
  }
}

