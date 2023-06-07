

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/model/add_customer_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/login/model/login_model.dart';
import 'package:ready_made_4_trade/modules/login/model/login_response.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';

import 'login.dart';

class ChangePassword extends StatefulWidget {
  String? email;
   ChangePassword({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final RemoteApi apiServices = RemoteApi();
  StorageServices _storageServices = StorageServices();
  bool _isLoading = false;

  TextEditingController _newPassword = TextEditingController();
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

            GestureDetector( onTap: () async{
              setState(() {
                _isLoading = true;
              });

              AddCustomerResponse? response = await apiServices.changePassword(ChangePasswordModal(email: widget.email, password: _newPassword.text));

              debugPrint(response.toString());
              if (response != null && response.status == true) {


                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password change successful')));



                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
              } else {
                Fluttertoast.showToast(
                    msg: response != null
                        ? response.message
                        : 'Please check your credentials',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

                setState(() {
                  _isLoading = false;
                });
              }

            },
              child: SizedBox(
                height: 40,
                width: 180,
                child: longButton(context, 'SUBMIT', CustomColors.blueButton),
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
                  child: textField(context, _newPassword, 'New Password', 390, 50),
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
          _isLoading
              ? Center(
              child: SpinKitCircle(
                color: CustomColors.primeColour,
                size: 50.0,
              ))
              : Container()

        ],
      ),
    );
  }
}
