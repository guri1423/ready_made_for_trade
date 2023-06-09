import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/modules/bottom_nav/view/bottom_navigation.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/login/model/login_model.dart';
import 'package:ready_made_4_trade/modules/login/model/login_response.dart';
import 'package:ready_made_4_trade/modules/login/pages/forgot_password.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

import '../../../core/colors.dart';
import '../../../core/strings.dart';
import '../../../services/storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RemoteApi apiServices = RemoteApi();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  final StorageServices _servicesStorage = StorageServices();

  bool _isLoading = false;
  bool _obscureText = true;
  bool? _checkBox = false;

  getEmailAndPass() async {

    _username.text = await _servicesStorage.getEmail() ?? "";
    _password.text = await _servicesStorage.getPassword() ?? "";
    debugPrint(await _servicesStorage.getPassword());
    debugPrint(await _servicesStorage.getEmail());
    if (await _servicesStorage.getPassword() != null) {
      setState(() {
        _checkBox = true;
      });
    } else {
      setState(() {
        _checkBox = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getEmailAndPass();
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 130,
              height: 60,
              child: Image.asset(
                'assets/images/final Logo.png',
                fit: BoxFit.fill,
              ),
            ),
            /*SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/images/updated_images/012-bell.png'),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
       /*     GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
              },
              child: Text('Forgot Password',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color : CustomColors.blueButton),),
            ),*/

            GestureDetector(
              onTap: () async {
                await _servicesStorage.setEmail(_username.text);
                await _servicesStorage.setPassword(_password.text);
                setState(() {
                  _isLoading = true;
                });

                LoginResponseModel? response = await apiServices.userLogin(
                    LoginRequestModal(
                        email: _username.text, password: _password.text));

                debugPrint(response.toString());
                if (response != null && response.status == true) {

                 await _servicesStorage.setUserId(response.data.id!.toString());
                 await _servicesStorage.setUserLoggedIn('true');
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful')));
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => BottomNavigation()), (route) => false);
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
                child: longButton(context, 'LOGIN', CustomColors.blueButton),
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
                    Strings.login,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    // height: 45,
                    width: 390,
                    child: TextFormField(
                      obscureText: _obscureText,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: CustomColors.black,
                            fontWeight: FontWeight.normal,
                          ),
                      maxLines: 1,
                      controller: _password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: CustomColors.textFieldTextColour),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText =
                                  !_obscureText; // Toggle the value of _obscureText
                            });
                          },
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      checkColor: CustomColors.primeColour,
                      activeColor: CustomColors.white,
                      value: _checkBox,
                      onChanged: (value) {

                        _checkBox =! _checkBox!;

                        setState(() {



                          if(_checkBox == true){

                          }else {
                            _servicesStorage.removeEmailAndPass();
                          }

                        });

                      },
                    ),
                    Text(
                      'Remember Me',
                      style: TextStyle(fontSize: 14,
                        color: Color.fromRGBO(39, 69, 89, 1),
                      ),
                    ),
                    SizedBox(width: 85),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 14,
                          color: Color.fromRGBO(39, 69, 89, 1),
                        ),
                        /*Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: CustomColors.blueButton),*/
                      ),
                    ),
                  ],
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
