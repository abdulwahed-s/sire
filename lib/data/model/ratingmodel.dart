class RatingModel {
  String? ratingStars;
  String? ratingComment;
  String? ratingDatetime;
  String? userName;
  String? userPfp;

  RatingModel(
      {this.ratingStars,
      this.ratingComment,
      this.ratingDatetime,
      this.userName,
      this.userPfp});

  RatingModel.fromJson(Map<String, dynamic> json) {
    ratingStars = json['rating_stars'];
    ratingComment = json['rating_comment'];
    ratingDatetime = json['rating_datetime'];
    userName = json['user_name'];
    userPfp = json['user_pfp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating_stars'] = ratingStars;
    data['rating_comment'] = ratingComment;
    data['rating_datetime'] = ratingDatetime;
    data['user_name'] = userName;
    data['user_pfp'] = userPfp;
    return data;
  }
}
