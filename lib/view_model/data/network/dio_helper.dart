


import 'package:dio/dio.dart';

import '../../utilities/sensitive_data.dart';
import 'end_points.dart';

class DioHelper{
  static Dio? dio;

  static void init() {
    dio=  Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          "apikey": anonKey,
          "Authorization": "Bearer $anonKey",
          "Content-Type":"application/json",
        },
      ),
    );

  }

  static Future<Response> get(
      {required String endPoint,
        Map<String,dynamic>? queryParameters,
        Map<String,dynamic>? headers,
        Map<String,dynamic>? body,
        bool? withToken=false,
      })async{
    try{
      // Merge additional headers with default headers
      Map<String, dynamic> requestHeaders = {
        "apikey": anonKey,
        "Authorization": "Bearer $anonKey",
        "Content-Type": "application/json",
      };

      if (headers != null) {
        requestHeaders.addAll(headers);
      }
      // Set headers for this specific request
      dio!.options.headers = requestHeaders;
      // if(withToken!)
      // {
      //   dio?.options.headers={
      //     "Authorization": "Bearer $anonKey",
      //   };
      // }

      return dio!.get(endPoint,
        queryParameters: queryParameters,
        data: body,
      );

    }catch(e){
      rethrow;
    }

  }

  static Future<Response> post ({required String endPoint,Map<String,
      dynamic>? queryParameters,Map<String,
      dynamic>? body,Map<String,dynamic>? headers,
    FormData? formData,
    bool? withToken=false,
  })async{

    try{
      // Merge additional headers with default headers
      Map<String, dynamic> requestHeaders = {
        "apikey": anonKey,
        "Authorization": "Bearer $anonKey",
        "Content-Type": "application/json",
      };

      if (headers != null) {
        requestHeaders.addAll(headers);
      }
      // Set headers for this specific request
      dio!.options.headers = requestHeaders;
      // if(withToken!)
      // {
      //   dio?.options.headers={
      //     "Authorization": "Bearer ${ await SharedHelper.get(key: SharedKeys.token)}",
      //   };
      // }
      return dio!.post(endPoint,
        queryParameters: queryParameters,
        data: formData?? body,
      );
    }catch(e){
      rethrow;
    }

  }

  static Future<Response> put ({required String endPoint,Map<String,dynamic>? queryParameters,Map<String,dynamic>? body,Map<String,dynamic>? headers}){

    try{
      // Merge additional headers with default headers
      Map<String, dynamic> requestHeaders = {
        "apikey": anonKey,
        "Authorization": "Bearer $anonKey",
        "Content-Type": "application/json",
      };

      if (headers != null) {
        requestHeaders.addAll(headers);
      }
      // Set headers for this specific request
      dio!.options.headers = requestHeaders;
      return dio!.put(endPoint,
        queryParameters: queryParameters,
        data: body,
      );
    }catch(e){
      rethrow;
    }

  }

  //Patch is used with supabase while put not used
  static Future<Response> patch ({required String endPoint,Map<String,dynamic>? queryParameters,Map<String,dynamic>? body,Map<String,dynamic>? headers}){

    try{
      // Merge additional headers with default headers
      Map<String, dynamic> requestHeaders = {
        "apikey": anonKey,
        "Authorization": "Bearer $anonKey",
        "Content-Type": "application/json",
      };

      if (headers != null) {
        requestHeaders.addAll(headers);
      }
      // Set headers for this specific request
      dio!.options.headers = requestHeaders;
      return dio!.patch(endPoint,
        queryParameters: queryParameters,
        data: body,
      );
    }catch(e){
      rethrow;
    }

  }

  static Future<Response> delete ({required String endPoint,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? body,
    Map<String,dynamic>? headers,
    bool? withToken=false,

  })async{

    try{
      // Merge additional headers with default headers
      Map<String, dynamic> requestHeaders = {
        "apikey": anonKey,
        "Authorization": "Bearer $anonKey",
        "Content-Type": "application/json",
      };

      if (headers != null) {
        requestHeaders.addAll(headers);
      }
      // Set headers for this specific request
      dio!.options.headers = requestHeaders;
      // if(withToken!)
      // {
      //   dio?.options.headers={
      //     "Authorization": "Bearer ${ await SharedHelper.get(key: SharedKeys.token)}",
      //   };
      // }
      return dio!.delete(endPoint,
        queryParameters: queryParameters,
        data: body,
      );
    }catch(e){
      rethrow;
    }

  }

}