class UserInfo {
  num userId;

  /// 用户昵称
  String nickName;

  /// 手机号
  String mobile;

  /// 个性签名
  String introduceSign;

  /// 锁定标识字段(0-未锁定 1-已锁定)
  int lockedFlag;

  /// 注册时间
  String createTime;
  String headIco;
  UserInfo({
    required this.userId,
    required this.mobile,
    required this.nickName,
    required this.introduceSign,
    required this.lockedFlag,
    required this.createTime,
    required this.headIco,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['UserId'] ?? 0,
      mobile: json['mobile'] ?? "",
      nickName: json['nickName'] ?? "",
      introduceSign: json['introduceSign'] ?? "",
      lockedFlag: json["lockedFlag"] ?? 0,
      createTime: json["createTime"] ?? "",
      headIco: json['headIco'] ?? "assets/logo/0.jpg",
    );
  }
}

/// 登陆信息
class LoginInfo {
  String passWord;
  String mobile;

  LoginInfo({
    this.passWord = "",
    this.mobile = "",
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      passWord: json['password'] ?? "",
      mobile: json['mobile'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["password"] = passWord;
    data["mobile"] = mobile;
    return data;
  }
}

class LoginRes {
  int id;
  String token;

  LoginRes({
    required this.id,
    required this.token,
  });

  factory LoginRes.fromJson(Map<String, dynamic> json) {
    return LoginRes(
      id: json['id'] ?? 0,
      token: json['token'] ?? "",
    );
  }
}
