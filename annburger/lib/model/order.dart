class Order {
  String? orid;
  String? userid;
  String? username;
  String? useremail;
  String? prid;
  String? prname;
  String? prqty;
  String? totalprice;
  String? paymentfirm;
  String? orderfirm;
  String? orderdate;
  
  Order(
      {required this.orid,
      required this.userid,
      required this.username,
      required this.useremail,
      required this.prid,
      required this.prname,
      required this.prqty,
      required this.totalprice,
      required this.paymentfirm,
      required this.orderfirm,
      required this.orderdate
 });

  Order.fromJson(Map<String, dynamic> json) {
    orid = json['orid'];
    userid = json['userid'];
    username = json['username'];
    useremail = json['useremail'];
    prid = json['prid'];
    prname = json['prname'];
    prqty = json['prqty'];
    totalprice = json['totalprice'];
    paymentfirm = json['paymentfirm'];
    orderfirm = json['orderfirm'];
    orderdate = json['orderdate'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orid'] = orid;
    data['userid'] = userid;
    data['username'] = username;
    data['useremail'] = useremail;
    data['prid'] = prid;
    data['prname'] = prname;
    data['prqty'] = prqty;
    data['totalprice'] = totalprice;
    data['paymentfirm'] = paymentfirm;
    data['orderfirm'] = orderfirm;
    data['orderdate'] = orderdate;
    

    return data;
  }
}