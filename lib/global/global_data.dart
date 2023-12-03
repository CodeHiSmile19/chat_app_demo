import 'package:chat_app_demo/models/entities/authenticate_entity.dart';

class GlobalData {
  GlobalData._privateConstructor();
  static final GlobalData instance = GlobalData._privateConstructor();

  AccountEntity? currentUser;
}
