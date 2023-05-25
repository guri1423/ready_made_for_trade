import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/modules/trades/models/add_trades_model.dart';
import 'package:ready_made_4_trade/modules/trades/pages/trades.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class AddTradesPage extends StatefulWidget {
  const AddTradesPage({Key? key}) : super(key: key);

  @override
  State<AddTradesPage> createState() => _AddTradesPageState();
}

class _AddTradesPageState extends State<AddTradesPage> {
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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
      bottomNavigationBar:  BottomToolsForInsidePage(
        onBackPress: (){
          Navigator.pop(context);
        },
      ),
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
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2(
                    decoration: const InputDecoration(
                      isDense: true,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    buttonHeight: 45,
                    buttonWidth: MediaQuery.of(context).size.width,
                    buttonDecoration: BoxDecoration(
                      color: CustomColors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: CustomColors.textFieldBorderColor,
                        width: 1,
                      ),
                    ),
                    itemPadding: EdgeInsets.symmetric(horizontal: 15),
                    itemHeight:
                    MediaQuery.of(context).size.height * 0.056,
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: CustomColors.primeColour,
                      ),
                    ),
                    iconOnClick: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: CustomColors.primeColour,
                      ),
                    ),
                    hint: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Trade',
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: CustomColors.textFieldTextColour),
                      ),
                    ),
                    items: tradeType
                        .map((item) => DropdownMenuItem(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            item.toString(),
                            style:
                            TextStyle(color: CustomColors.blackText),
                          ),
                        )))
                        .toList(),
                    onChanged: (val){

                    },
                  ),
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
                                await apiServices.addTrades(AddTradesModel(
                                    title: _title.text,
                                    first_name: _firstName.text,
                                    last_name: _lastName.text,
                                    nickname: _nickName.text,
                                    trades: _trades.text,
                                    mobile_number: _mobileNo.text,
                                    email_address: _email.text,
                                    user_email: email,
                                    user_id: userId));

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
