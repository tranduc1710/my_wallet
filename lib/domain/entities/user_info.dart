class UserInfo {
  String? id;
  String? username;
  bool? enabled;
  String? firstName;
  String? lastName;
  String? email;
  String? staffId;
  String? staffCode;
  String? staffName;
  String? shopId;
  List<String>? roles;
  bool? checkResult;

  UserInfo(
      {this.id,
      this.username,
      this.enabled,
      this.firstName,
      this.lastName,
      this.email,
      this.staffId,
      this.staffCode,
      this.staffName,
      this.shopId,
      this.roles,
      this.checkResult});
}
