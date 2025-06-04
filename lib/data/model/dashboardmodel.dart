class DashboardModel {
  String? status;
  String? sales;
  int? order;
  int? items;
  int? customer;
  List<Orders>? orders;
  List<TopProducts>? topProducts;

  DashboardModel(
      {this.status,
      this.sales,
      this.order,
      this.items,
      this.customer,
      this.orders,
      this.topProducts});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sales = json['sales'];
    order = json['order'];
    items = json['items'];
    customer = json['customer'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    if (json['topProducts'] != null) {
      topProducts = <TopProducts>[];
      json['topProducts'].forEach((v) {
        topProducts!.add(TopProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['sales'] = sales;
    data['order'] = order;
    data['items'] = items;
    data['customer'] = customer;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (topProducts != null) {
      data['topProducts'] = topProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? orderId;
  int? orderTotalprice;
  double? orderStatus;
  String? userName;

  Orders({this.orderId, this.orderTotalprice, this.orderStatus, this.userName});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderTotalprice = json['order_totalprice'];
    orderStatus = (json['order_status'] as num?)?.toDouble();
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_totalprice'] = orderTotalprice;
    data['order_status'] = orderStatus;
    data['user_name'] = userName;
    return data;
  }
}

class TopProducts {
  String? itemName;
  double? itemPrice;
  int? itemDiscount;
  String? itemImg;
  int? totalSold;

  TopProducts(
      {this.itemName,
      this.itemPrice,
      this.itemDiscount,
      this.itemImg,
      this.totalSold});

  TopProducts.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = (json['item_price'] as num?)?.toDouble();
    itemDiscount = json['item_discount'];
    itemImg = json['item_img'];
    totalSold = json['total_sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    data['item_discount'] = itemDiscount;
    data['item_img'] = itemImg;
    data['total_sold'] = totalSold;
    return data;
  }
}
