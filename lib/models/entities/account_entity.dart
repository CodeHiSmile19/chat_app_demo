import 'package:json_annotation/json_annotation.dart';

part 'account_entity.g.dart';

@JsonSerializable()
class AccountEntity {
  @JsonKey()
  final String? firstName;
  @JsonKey()
  final String? lastName;
  @JsonKey()
  final String? uId;
  @JsonKey()
  final String? phoneNumber;
  @JsonKey()
  final String? passWord;
  @JsonKey()
  final String? avatar;
  @JsonKey()
  final String? address;

  AccountEntity({
    this.firstName,
    this.lastName,
    this.uId,
    this.passWord,
    this.avatar,
    this.address,
    this.phoneNumber,
  });

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountEntityToJson(this);
}
