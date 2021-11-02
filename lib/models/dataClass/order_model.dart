class OrderModel{
  int orderId;
  DateTime orderDate;
  String orderStatus;
  var amount;
  OrderModel({required this.orderId, required this.orderDate, required this.orderStatus,required this.amount});

  factory OrderModel.fromJSON(data){
    String status = "Pending";
    if(data["is_completed"]!=0){
      status = "Completed";
    }

    return OrderModel(
        orderId: data["id"],
        orderDate: DateTime.parse(data["created_at"]),
        orderStatus: status,
        amount: data["amount"]??0
    );
  }

}