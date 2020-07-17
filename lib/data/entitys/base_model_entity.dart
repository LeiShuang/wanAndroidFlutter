import 'package:wanandroid/generated/json/base/json_convert_content.dart';

class BaseModelEntity with JsonConvert<BaseModelEntity> {
	dynamic data;
	int errorCode;
	String errorMsg;
}
