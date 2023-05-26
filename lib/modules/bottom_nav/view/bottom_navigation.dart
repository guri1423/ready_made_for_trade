



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/account/view/account_page.dart';
import 'package:ready_made_4_trade/modules/bottom_nav/cubit/navigation_cubit.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/setting/view/setting.dart';

import '../constants/items.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {

    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state.navbarItem == NavbarItem.Back) {
              return HomePage();
            } else if (state.navbarItem == NavbarItem.Home) {
              return HomePage();
            } else if (state.navbarItem == NavbarItem.Account) {
              return AccountPage();
            } else if (state.navbarItem == NavbarItem.Setting) {
              return SettingsPage();
            }



            return Container();
          }

      ),
      bottomNavigationBar:BlocBuilder<NavigationCubit, NavigationState> (
          builder: (context, state) {
            return Container(
              height: bottomBarHeight(),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: BottomAppBar(
                elevation: 30,
                color: Colors.white ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavbarItem.Home);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child:state.index ==0
                                ? Image.asset("assets/images/updated_images/013-back.png",)
                                :Image.asset("assets/images/updated_images/013-back.png"),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavbarItem.Home);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: state.index==1
                                ?Image.asset("assets/images/updated_images/014-menu.png")
                                :Image.asset("assets/images/updated_images/014-menu.png"),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavbarItem.Account);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child:state.index==2
                                ? Image.asset("assets/images/updated_images/016-user.png",)
                                :Image.asset("assets/images/updated_images/016-user.png"),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavbarItem.Setting);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: state.index == 3
                                ?Image.asset("assets/images/updated_images/015-settings.png",)
                                :Image.asset("assets/images/updated_images/015-settings.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );



          }
      ),
    );
  }


}
