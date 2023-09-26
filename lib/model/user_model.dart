class User {
  String? userId;
  String? name;
  String? email;
  String? password;
  String? mobile;
  String? profilePic;
  String? referalCode;
  String? accessToken;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.profilePic,
    required this.referalCode,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['user_id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        mobile: json['mobile'],
        profilePic: json['profilePic'],
        referalCode: json['referalCode'],
        accessToken: json['accessToken'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['pasword'] = this.password;
    data['mobile'] = this.mobile;
    data['profilePic'] = this.profilePic;
    data['referal_code'] = this.referalCode;
    data['access_token'] = this.accessToken;
    return data;
  }
}
