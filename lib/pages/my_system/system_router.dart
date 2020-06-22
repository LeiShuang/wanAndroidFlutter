
import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:wanandroid/routers/router_init.dart';

import 'knowledge_list.dart';

class SystemRouter implements IRouterProvider{

  static String systemList = "/system";
  @override
  void initRouter(Router router) {
    router.define(systemList, handler: Handler(handlerFunc: (_, params){
      String title = params['title']?.first;
      int knowledgeId = int.parse(params['knowledgeId']?.first);
      return KnowledgeDetailList(knowledgeId,title);
    }));
  }

}