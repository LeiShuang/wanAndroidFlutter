import 'package:wanandroid/data/entitys/project_top_title_entity.dart';

projectTopTitleEntityFromJson(ProjectTopTitleEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<ProjectTopTitleData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new ProjectTopTitleData().fromJson(v));
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

Map<String, dynamic> projectTopTitleEntityToJson(ProjectTopTitleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

projectTopTitleDataFromJson(ProjectTopTitleData data, Map<String, dynamic> json) {
	if (json['children'] != null) {
		data.children = new List<dynamic>();
		data.children.addAll(json['children']);
	}
	if (json['courseId'] != null) {
		data.courseId = json['courseId']?.toInt();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['order'] != null) {
		data.order = json['order']?.toInt();
	}
	if (json['parentChapterId'] != null) {
		data.parentChapterId = json['parentChapterId']?.toInt();
	}
	if (json['userControlSetTop'] != null) {
		data.userControlSetTop = json['userControlSetTop'];
	}
	if (json['visible'] != null) {
		data.visible = json['visible']?.toInt();
	}
	return data;
}

Map<String, dynamic> projectTopTitleDataToJson(ProjectTopTitleData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.children != null) {
		data['children'] =  [];
	}
	data['courseId'] = entity.courseId;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['parentChapterId'] = entity.parentChapterId;
	data['userControlSetTop'] = entity.userControlSetTop;
	data['visible'] = entity.visible;
	return data;
}