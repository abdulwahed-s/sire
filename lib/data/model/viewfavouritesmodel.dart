class ViewFavouritesModel {
  int? favouriteId;
  int? favouriteUserid;
  int? favouriteItemid;
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
  int? userId;
  String? userEmail;
  String? userName;
  String? userPassword;
  String? userPhone;
  int? userVerifycode;
  int? userApprove;
  String? userCreate;

  ViewFavouritesModel(
      {this.favouriteId,
      this.favouriteUserid,
      this.favouriteItemid,
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
      this.userId,
      this.userEmail,
      this.userName,
      this.userPassword,
      this.userPhone,
      this.userVerifycode,
      this.userApprove,
      this.userCreate});

  ViewFavouritesModel.fromJson(Map<String, dynamic> json) {
    favouriteId = json['favourite_id'];
    favouriteUserid = json['favourite_userid'];
    favouriteItemid = json['favourite_itemid'];
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
    itemPrice = json['item_price'].toDouble();
    itemDiscount = json['item_discount'];
    itemDate = json['item_date'];
    itemCat = json['item_cat'];
    userId = json['user_id'];
    userEmail = json['user_email'];
    userName = json['user_name'];
    userPassword = json['user_password'];
    userPhone = json['user_phone'];
    userVerifycode = json['user_verifycode'];
    userApprove = json['user_approve'];
    userCreate = json['user_create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favourite_id'] = this.favouriteId;
    data['favourite_userid'] = this.favouriteUserid;
    data['favourite_itemid'] = this.favouriteItemid;
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
    data['user_id'] = this.userId;
    data['user_email'] = this.userEmail;
    data['user_name'] = this.userName;
    data['user_password'] = this.userPassword;
    data['user_phone'] = this.userPhone;
    data['user_verifycode'] = this.userVerifycode;
    data['user_approve'] = this.userApprove;
    data['user_create'] = this.userCreate;
    return data;
  }
}
