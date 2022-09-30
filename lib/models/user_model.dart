import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.uid,
    this.email,
    this.emailVerified,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.type,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  String? type;
  bool? emailVerified;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
