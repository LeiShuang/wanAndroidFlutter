import 'package:wanandroid/generated/json/base/json_convert_content.dart';

import 'home_article_entity_entity.dart';

class TopArticleEntity with JsonConvert<TopArticleEntity> {
	List<HomeArticleEntityDataData> data;
	int errorCode;
	String errorMsg;
}
