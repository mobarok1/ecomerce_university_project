import 'dart:convert';

import 'package:ecomerce/models/client/api_client.dart';
import 'package:ecomerce/models/dataClass/reponse_model.dart';
import 'package:http/http.dart' as http;
class LoginRegisterService{
  static Future<ResponseModel> loginNow(Map<String,dynamic> formBody) async{
    ResponseModel responseModel;
    http.Response response =  await http.post(Uri.parse(baseUrl+"loginuser"),headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',} , body: jsonEncode(formBody));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data["statusCode"]=="200"){
        responseModel = ResponseModel(statusCode: 200, message: "Login Success");
      }else{
        responseModel = ResponseModel(statusCode: 400, message: "failed to login");
      }
    }else{
      responseModel = ResponseModel(statusCode: 500, message: "failed to connect");
    }

    return responseModel;
  }

  static Future<ResponseModel> registerNow(formBody) async{
    ResponseModel responseModel;
    http.Response response =  await http.post(Uri.parse(baseUrl+"register"),headers:<String,String>{'Content-Type': 'application/json; charset=UTF-8',} , body: jsonEncode(formBody));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data["statusCode"]=="200"){

        responseModel = ResponseModel(statusCode: 200, message: "Success");

      }else{
        responseModel = ResponseModel(statusCode: 400, message: "Failed");

      }
    }else{
      responseModel = ResponseModel(statusCode: 500, message: "Failed to connect");
    }
    return responseModel;
  }
}
