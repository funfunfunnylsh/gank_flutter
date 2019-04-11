import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/common/config/gank_config.dart';
import 'package:gank_flutter/common/manager/cache_manager.dart';
import 'package:gank_flutter/common/model/http_response.dart';
import 'package:gank_flutter/common/net/http_code.dart';

///http请求
class HttpManager<T> {
  static Dio dio = Dio();

  static Future<HttpResponse> fetch(url,
      {noTip = false,
      dynamic params,
      Map<String, String> header,
      method = 'get'}) async {
    ///构造Headers
    Map<String, String> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    Options option = new Options(method: method);
    option.headers = headers;
    option.connectTimeout = 15000;
    Response response;

//    ///取缓存
//    var cacheData = await CacheManager.get(url);
//    var connectivityResult = await (Connectivity().checkConnectivity());
//
//    ///没有网络
//    if (connectivityResult == ConnectivityResult.none) {
//      ///如果缓存不为空且接口可以缓存，那么直接从缓存取即可.
//      if (cacheData != null && !CacheManager.ignoreUrl(url)) {
//        if (GankConfig.DEBUG) {
//          print('httpManager=====>【缓存】cache请求url: ' + url);
//          print('httpManager=====>【缓存】返回结果: ' + cacheData.toString());
//        }
//        return HttpResponse(cacheData, true, Code.SUCCESS, headers: null);
//      } else {
//        return HttpResponse(
//            Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
//            false,
//            Code.NETWORK_ERROR);
//      }
//    }

    ///否则网络获取接口数据.
//    try {
      response = await dio.request(url, data: params, options: option);
//      await CacheManager.set(CacheObject(url: url, value: response.data));
//    } on DioError catch (e) {
//      ///如果缓存不为空且接口可以缓存，那么直接从缓存取即可.
//      if (cacheData != null && !CacheManager.ignoreUrl(url)) {
//        if (GankConfig.DEBUG) {
//          print('httpManager=====>【缓存】cache请求url: ' + url);
//          print('httpManager=====>【缓存】请求头: ' + option.headers.toString());
//          if (params != null) {
//            print('httpManager=====>【缓存】请求参数: ' + params.toString());
//          }
//          if (response != null) {
//            print('httpManager=====>【缓存】返回结果: ' + cacheData.toString());
//          }
//        }
//        return HttpResponse(cacheData, true, Code.SUCCESS, headers: null);
//      }
//      Response errorResponse;
//      if (e.response != null) {
//        errorResponse = e.response;
//      } else {
//        errorResponse = Response(statusCode: 666);
//      }
//      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
//        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
//      }
//      if (GankConfig.DEBUG) {
//        print('httpManager=====>请求异常: ' + e.toString());
//        print('httpManager=====>请求异常url: ' + url);
//      }
//      return HttpResponse(
//          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
//          false,
//          errorResponse.statusCode);
//    }

    if (GankConfig.DEBUG) {
      print('httpManager=====>请求url: ' + url);
      print('httpManager=====>请求头: ' + option.headers.toString());
      if (params != null) {
        print('httpManager=====>请求参数: ' + params.toString());
      }
      if (response != null) {
        print('httpManager=====>返回参数: ' + response.toString());
      }
    }

    ///返回正确获取到的网络数据.
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpResponse(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      ///错误处理
      return HttpResponse(response.data, false, response.statusCode,
          headers: response.headers);
    }

    ///容错处理
    return HttpResponse(
        Code.errorHandleFunction(response.statusCode, "", noTip),
        false,
        response.statusCode);
  }
}
