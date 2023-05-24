import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/bottom_nav/constants/items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.Home,0));

  void getNavBarItem(NavbarItem navbarItem){
    switch (navbarItem){
      case NavbarItem.Back:
        emit(NavigationState(NavbarItem.Back, 0));
        break;
      case NavbarItem.Home:
        emit(NavigationState(NavbarItem.Home, 1));
        break;
      case NavbarItem.Account:
        emit(NavigationState(NavbarItem.Account, 2));
        break;
      case NavbarItem.Setting:
        emit(NavigationState(NavbarItem.Setting, 3));
        break;


    }
  }
}
