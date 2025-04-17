class CartModel {
  int? cartId;
  int? cartUserid;
  int? cartItemid;
  int? itemId;
  String? itemName;
  String? itemNameAr;
  String? itemNameEs;
  String? itemDesc;
  String? itemDescAr;
  String? itemDescEs;
  String? itemImg;
  int? itemCount;
  int? itemActive;
  double? itemPrice;
  int? itemDiscount;
  String? itemDate;
  int? itemCat;
  String? categoryName;
  String? categoryNameAr;
  String? categoryNameEs;
  double? totalprice;
  int? countitems;

  CartModel(
      {this.cartId,
      this.cartUserid,
      this.cartItemid,
      this.itemId,
      this.itemName,
      this.itemNameAr,
      this.itemNameEs,
      this.itemDesc,
      this.itemDescAr,
      this.itemDescEs,
      this.itemImg,
      this.itemCount,
      this.itemActive,
      this.itemPrice,
      this.itemDiscount,
      this.itemDate,
      this.itemCat,
      this.categoryName,
      this.categoryNameAr,
      this.categoryNameEs,
      this.totalprice,
      this.countitems});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    cartUserid = json['cart_userid'];
    cartItemid = json['cart_itemid'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemNameAr = json['item_name_ar'];
    itemNameEs = json['item_name_es'];
    itemDesc = json['item_desc'];
    itemDescAr = json['item_desc_ar'];
    itemDescEs = json['item_desc_es'];
    itemImg = json['item_img'];
    itemCount = json['item_count'];
    itemActive = json['item_active'];
    itemPrice = (json['item_price'] as num?)?.toDouble();
    itemDiscount = json['item_discount'];
    itemDate = json['item_date'];
    itemCat = json['item_cat'];
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEs = json['category_name_es'];
    totalprice = (json['totalprice'] as num?)?.toDouble();
    countitems = json['countitems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['cart_userid'] = this.cartUserid;
    data['cart_itemid'] = this.cartItemid;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_name_ar'] = this.itemNameAr;
    data['item_name_es'] = this.itemNameEs;
    data['item_desc'] = this.itemDesc;
    data['item_desc_ar'] = this.itemDescAr;
    data['item_desc_es'] = this.itemDescEs;
    data['item_img'] = this.itemImg;
    data['item_count'] = this.itemCount;
    data['item_active'] = this.itemActive;
    data['item_price'] = this.itemPrice;
    data['item_discount'] = this.itemDiscount;
    data['item_date'] = this.itemDate;
    data['item_cat'] = this.itemCat;
    data['category_name'] = this.categoryName;
    data['category_name_ar'] = this.categoryNameAr;
    data['category_name_es'] = this.categoryNameEs;
    data['totalprice'] = this.totalprice;
    data['countitems'] = this.countitems;
    return data;
  }
}