import 'package:wanandroid/data/entitys/base_model_entity.dart';

baseModelEntityFromJson(BaseModelEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = json['data'];
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> baseModelEntityToJson(BaseModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['data'] = entity.data;
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}