import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/pages/login/index_login.dart';
import 'package:wanandroid/pages/login/index_register.dart';
import 'package:wanandroid/pages/main.dart';
import 'package:wanandroid/pages/my_system/system_router.dart';
import 'package:wanandroid/pages/web_detail/web_detail.dart';
import 'package:wanandroid/routers/router_init.dart';

import '404.dart';

// ignore: avoid_classes_with_only_static_members
class Routes {
  static String home = '/home';
  static String webViewPage = '/webview';
  static String loginPage = '/login';
  static String registerPage = '/register';
  static final List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return WidgetNotFound();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    MyApp()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first;
      final String url = params['url']?.first;
      return WebDetailPage(title: title, url: url);
    }));

    router.define(loginPage,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    LoginPage()));

    router.define(registerPage, handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) =>RegisterPage()));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(SystemRouter());
//    _listRouter.add(LoginRouter());
//    _listRouter.add(GoodsRouter());
//    _listRouter.add(OrderRouter());
//    _listRouter.add(StoreRouter());
//    _listRouter.add(AccountRouter());
//    _listRouter.add(SettingRouter());
//    _listRouter.add(StatisticsRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
