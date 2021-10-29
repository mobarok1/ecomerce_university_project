class ResponseModel{
  int statusCode;
  String message;
  dynamic data;
  ResponseModel({required this.statusCode,required this.message,this.data});
}