///Vẽ UI
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:chat_app_demo/ui/pages/chats/chats_page.dart';
import 'package:chat_app_demo/ui/pages/contacts/contacts_page.dart';
import 'package:chat_app_demo/ui/pages/main/main_cubit.dart';
import 'package:chat_app_demo/ui/pages/menu/menu_page.dart';
import 'package:chat_app_demo/ui/widgets/dot/dot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController controller = PageController();
  late final MainCubit _cubit;

  @override
  void initState() {
    _cubit = MainCubit();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return _cubit;
      },
      child: BlocBuilder<MainCubit, MainState>(
        buildWhen: (previous, current) {
          return previous.selectedIndex != current.selectedIndex;
        },
        builder: (context, state) {
          return Scaffold(
            body: PageView(
              controller: controller,
              children: const <Widget>[
                ContactsPage(),
                ChatsPage(),
                MenuPage(),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppVectors.icGroupUser,
                    ),
                    activeIcon: Column(
                      children: const [
                        Text(
                          "Contacts",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F1828)),
                        ),
                        SizedBox(height: 8),
                        DotWidget(),
                      ],
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppVectors.icMessageCircle,
                    ),
                    activeIcon: Column(
                      children: const [
                        Text(
                          "Chats",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F1828),
                          ),
                        ),
                        SizedBox(height: 8),
                        DotWidget(),
                      ],
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppVectors.icMoreHorizontal,
                    ),
                    activeIcon: Column(
                      children: const [
                        Text(
                          "More",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F1828)),
                        ),
                        SizedBox(height: 8),
                        DotWidget(),
                      ],
                    ),
                    label: '',
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: state.selectedIndex,
                selectedItemColor: Colors.black,
                onTap: (index) {
                  _cubit.changeTab(index);
                  controller.jumpToPage(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
