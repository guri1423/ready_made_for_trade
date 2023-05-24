import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/modules/trades/models/add_trades_model.dart';
import 'package:ready_made_4_trade/modules/trades/models/get_all_trades_model.dart';
import 'package:ready_made_4_trade/modules/trades/pages/trades.dart';
import 'package:ready_made_4_trade/modules/trades/search_cubit/search_trades_cubit.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class EditTradesPage extends StatefulWidget {
  DatumTrade tradeData;

  EditTradesPage({Key? key, required this.tradeData}) : super(key: key);

  @override
  State<EditTradesPage> createState() => _EditTradesPageState();
}

class _EditTradesPageState extends State<EditTradesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _title = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _nickName = TextEditingController();
  TextEditingController _trades = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();
  TextEditingController _email = TextEditingController();

  final RemoteApi apiServices = RemoteApi();

  final StorageServices _storageServices = StorageServices();

  bool isFormError = false;

  bool formValidate() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('23746329x');
      setState(() {
        isFormError = false;
      });
      return true;
    } else {
      setState(() {
        isFormError = true;
      });
      return false;
    }
  }

  getTradeDetails() {
    _title = TextEditingController()..text = widget.tradeData.title ?? "";
    _firstName = TextEditingController()
      ..text = widget.tradeData.firstName ?? "";
    _lastName = TextEditingController()..text = widget.tradeData.lastName ?? "";
    _nickName = TextEditingController()..text = widget.tradeData.nickname ?? "";
    _trades = TextEditingController()..text = widget.tradeData.trades ?? "";
    _mobileNo = TextEditingController()
      ..text = widget.tradeData.mobileNumber ?? "";
    _email = TextEditingController()
      ..text = widget.tradeData.emailAddress ?? "";
  }

  @override
  void initState() {
    getTradeDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 180,
              height: 90,
              child: Image.asset(
                'assets/images/final Logo.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/images/02 Notification.png'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 40,
                        width: 60,
                        child: customTextFieldForm(
                          context,
                          controller: _title,
                          hintText: 'Title',
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 40,
                          child: customTextFieldForm(
                            context,
                            controller: _firstName,
                            hintText: 'First Name',
                          )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 40,
                          child: customTextFieldForm(
                            context,
                            controller: _lastName,
                            hintText: 'Last Name',
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: customTextFieldForm(
                      context,
                      controller: _nickName,
                      hintText: 'Nick Name',
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: customTextFieldForm(
                      context,
                      controller: _trades,
                      hintText: 'Trades',
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: customTextFieldAddCustomer(context,
                        controller: _mobileNo,
                        hintText: 'Mobile No',
                        validator: (value) => mobilNumberValidator(value))),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: customTextFieldAddCustomer(
                      context,
                      controller: _email,
                      hintText: 'Email',
                      validator: (value) => validateEmail(value!),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          String? userId = await _storageServices.getUserId();
                          String? email = await _storageServices.getEmail();

                          debugPrint('User ID ${userId.toString()}');

                          bool statusForm = formValidate();
                          if (statusForm) {
                            PostTradesResponse? status =
                                await apiServices.editTrades(AddTradesModel(
                                    title: _title.text,
                                    first_name: _firstName.text,
                                    last_name: _lastName.text,
                                    nickname: _nickName.text,
                                    trades: _trades.text,
                                    mobile_number: _mobileNo.text,
                                    email_address: _email.text,
                                    user_email: email,
                                    user_id: userId,
                                    id: widget.tradeData.id));

                            debugPrint(status.toString());
                            if (status!.status == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Response added successfully')));
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TradesPage()),
                                  (route) => false);
                            } else {
                              Fluttertoast.showToast(
                                  msg: status.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        child: SizedBox(
                            height: 40,
                            child: longButton(
                                context, 'SAVE', CustomColors.primeColour)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                            height: 40,
                            child: longButton(
                                context, 'CANCEL', CustomColors.greyButton)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
