import 'package:dio/dio.dart';
import 'package:wanandroid/config/dio_err_code.dart';
import 'package:wanandroid/config/globalconfig.dart';
import 'dart:convert';

class DioHelper {
  // 单例公开访问点，工厂创建唯一(懒汉式)
  factory DioHelper() => _DioHelperInstance();

  static DioHelper _instance;
  Dio _dio;

  //私有构造方法
  DioHelper._({String baseUrl}) {
    if (null == _dio) {
      // 初始化
      _dio.options.baseUrl = baseUrl == null ? GlobalConfig.BASE_URL : baseUrl;
      _dio.options.connectTimeout = 3000;
      _dio.options.receiveTimeout = 3000;
      _dio.interceptors.add(LogInterceptor(requestBody: GlobalConfig.isDebug));
    }

//      dio.interceptors.add(CookieManager(CookieJar()));
  }

  static DioHelper _DioHelperInstance() {
    if (_instance == null) {
      _instance = DioHelper._();
    }
    return _instance;
  }

  //GET请求
  get(String url,  Map<String, dynamic> params, Function successCallBack,
      Function errorCallBack) async {
    _request(url, successCallBack, 'get', params, errorCallBack);
  }

  post(String url, Map<String, dynamic> params, Function successCallBack,
      Function errorCallBack) async {
    _request(url, successCallBack, 'post', params, errorCallBack);
  }

  _request(String url, Function successCallBack,
      [String method,  Map<String, dynamic> params, Function errorCallBack]) async {
    Response response;
    try {
      if (method == 'get') {
        response = (params != null && params.isNotEmpty)
            ? await _dio.get(url, queryParameters: params)
            : await _dio.get(url);
      } else if (method == 'post') {
        response = (params != null && params.isNotEmpty)
            ? await _dio.post(url, queryParameters: params)
            : await _dio.post(url);
      }
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      errorResponse = error.response != null
          ? error.response
          : new Response(statusCode: 666);

      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        //处理请求超时
        errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
      } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        // 一般服务器错误
        errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
      }

      //Debug模式打印日志
      if(GlobalConfig.isDebug){
          print('请求异常:' + error.toString());
          print('请求异常url: ' + url);
          print('请求头: ' + _dio.options.headers.toString());
          print('method: ' + _dio.options.method);
      }
      _error(errorCallBack, error.message);
      return '';
    }

    // debug模式打印相关数据
    if (GlobalConfig.isDebug) {
      print('请求url: ' + url);
      print('请求头: ' + _dio.options.headers.toString());

      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    String dataStr = await json.decode(response.data);
    Map<String,dynamic> dataMap = await json.decode(dataStr);
   if(dataMap == null ){
     _error(errorCallBack, '错误码：' + dataMap['errorCode'].toString() + ',' + dataMap['errorMsg'].toString());
   }else if (successCallBack != null){
     successCallBack(dataMap);
   }
  }


  }
  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
}
