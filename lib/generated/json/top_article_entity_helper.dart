import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/data/entitys/top_article_entity.dart';

topArticleEntityFromJson(TopArticleEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<HomeArticleEntityDataData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new HomeArticleEntityDataData().fromJson(v));
		});
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> topArticleEntityToJson(TopArticleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}
