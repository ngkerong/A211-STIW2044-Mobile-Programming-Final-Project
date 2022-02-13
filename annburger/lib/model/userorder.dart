class UserOrder {
  String? order_no;
  String? user_email;
  String? amount;
  String? date;

  
  
  UserOrder(
      {required this.order_no,
      required this.user_email,
      required this.amount,
      required this.date,
      
 });

  UserOrder.fromJson(Map<String, dynamic> json) {
    order_no= json['order_no'];
    user_email = json['user_email'];
    amount = json['amount'];
    date = json['date'];
    
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_no'] = order_no;
    data['user_email'] = user_email;
    data['amount'] = amount;
    data['date'] = date;

    return data;
  }
}