

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/strings.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/login/pages/change_password.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final RemoteApi apiServices = RemoteApi();

  TextEditingController _username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: SizedBox(
                  width: 180,
                  height: 90,
                  child: Image.asset(
                    'assets/images/final Logo.png',
                    fit: BoxFit.fill,
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> ChangePassword(email: _username.text,)), (route) => false);
              },
              child: SizedBox(
                height: 40,
                width: 180,
                child: longButton(context, 'NEXT', CustomColors.blueButton),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'FORGOT PASSWORD',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: CustomColors.primeColour),
                  ),
                ),
                SizedBox(height: 292 * oneLogicalPixelInPhysicalPixels),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: textField(context, _username, 'Username', 390, 50),
                ),
                SizedBox(
                  height: 59 * oneLogicalPixelInPhysicalPixels,
                ),



                const SizedBox(
                  height: 59,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
