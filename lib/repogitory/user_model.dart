class User {
  final int? id;
  final String? nickname;
  final int responseResult;
  final String responseMessage;

  User({this.id, this.nickname, required this.responseResult, required this.responseMessage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'],
      nickname: json['nickname'],
      responseResult: json['result'],
      responseMessage: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'nickname': nickname,
    };
  }
}