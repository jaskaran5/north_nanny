class NotificationEntity {
  String? type;
  String? title;
  String? body;
  String? notificationTypeId;
  String? message;
  //UserData? id;

  NotificationEntity({
    this.type,
    this.body,
    this.title,
    this.notificationTypeId,
    this.message,
    //this.id
  });

  NotificationEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    type = json['type'];
    message = json['message'];
    notificationTypeId = json['notificationTypeId'];
    //   id = json['id'] != null ? UserData.fromJson(json['id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['title'] = title;
    data['type'] = type;
    data['notificationTypeId'] = notificationTypeId;
    data['message'] = message;
    /*   if (id != null) {
      data['id'] = id?.toJson();
    }*/
    return data;
  }
}

class UserData {
  UserData({
    this.profileImg,
    this.lastName,
    this.id,
    this.firstName,
  });

  UserData.fromJson(dynamic json) {
    profileImg = json['profile_img'];
    lastName = json['last_name'];
    id = json['id'];
    firstName = json['first_name'];
  }
  String? profileImg;
  String? lastName;
  String? id;
  String? firstName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_img'] = profileImg;
    map['last_name'] = lastName;
    map['id'] = id;
    map['first_name'] = firstName;
    return map;
  }
}
