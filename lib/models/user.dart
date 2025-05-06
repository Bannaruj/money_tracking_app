// ignore_for_file: prefer_collection_literals, unnecessary_new

class User {
  int? userId;
  String? userFullname;
  String? userBirthDate;
  String? userName;
  String? userPassword;
  String? userImage;

  User({
    this.userFullname,
    this.userBirthDate,
    this.userName,
    this.userPassword,
    this.userImage,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userFullname = json['userFullname'];
    userBirthDate = json['userBirthDate'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['userFullname'] = userFullname;
    data['userBirthDate'] = userBirthDate;
    data['userName'] = userName;
    data['userPassword'] = userPassword;
    data['userImage'] = userImage;
    return data;
  }
}
