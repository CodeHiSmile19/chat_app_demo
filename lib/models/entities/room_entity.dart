import 'package:chat_app_demo/models/entities/account_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_entity.g.dart';

@JsonSerializable()
class RoomEntity{
  final bool? isGroup;
  final String? groupName;
  final String? roomId;
  final List<AccountEntity> users;
  final String? createdDate;


}