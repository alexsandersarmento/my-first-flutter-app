class UserModel {
  int id;
  String email;
  String fullName;
  // LanguageCodeModel languageCode;
  // TimeZoneModel timeZone;
  TokenModel token;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    // required this.languageCode,
    // required this.timeZone,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      fullName: map['full_name'],
      // languageCode: LanguageCodeModel.fromMap(map['language_code']),
      // timeZone: TimeZoneModel.fromMap(map['time_zone']),
      token: TokenModel.fromMap(map['token']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      // 'language_code': languageCode.toMap(),
      // 'time_zone': timeZone.toMap(),
      'token': token.toMap(),
    };
  }
}

// class LanguageCodeModel {
//   String value;
//   String human;

//   LanguageCodeModel({
//     required this.value,
//     required this.human,
//   });

//   factory LanguageCodeModel.fromMap(Map<String, dynamic> json) {
//     return LanguageCodeModel(
//       value: json['value'],
//       human: json['human'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'value': value,
//       'human': human,
//     };
//   }
// }

// class TimeZoneModel {
//   String value;
//   String human;

//   TimeZoneModel({
//     required this.value,
//     required this.human,
//   });

//   factory TimeZoneModel.fromMap(Map<String, dynamic> json) {
//     return TimeZoneModel(
//       value: json['value'],
//       human: json['human'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'value': value,
//       'human': human,
//     };
//   }
// }

class TokenModel {
  String type;
  String access;
  String refresh;

  TokenModel({
    required this.type,
    required this.access,
    required this.refresh,
  });

  factory TokenModel.fromMap(Map<String, dynamic> json) {
    return TokenModel(
      type: json['type'],
      access: json['access'],
      refresh: json['refresh'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'access': access,
      'refresh': refresh,
    };
  }
}