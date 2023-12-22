import 'package:base_flutter/domain/entities/user_info.dart';

class UserInfoModel extends UserInfo {
  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    enabled = json['enabled'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    staffId = json['staffId'];
    staffCode = json['staffCode'];
    staffName = json['staffName'];
    shopId = json['shopId'];
    roles = json['roles'].cast<String>();
    checkResult = json['checkResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['enabled'] = enabled;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['staffId'] = staffId;
    data['staffCode'] = staffCode;
    data['staffName'] = staffName;
    data['shopId'] = shopId;
    data['roles'] = roles;
    data['checkResult'] = checkResult;
    return data;
  }
}
