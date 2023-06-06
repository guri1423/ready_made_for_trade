import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/model/add_customer_model.dart';
import 'package:ready_made_4_trade/modules/customer/search_cubit/customer_search_cubit.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({Key? key}) : super(key: key);

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  bool isFormError = false;
  bool phoneValidationError = false;
  bool emailValidationError = false;

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

  bool check = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();
  TextEditingController _email = TextEditingController();

  String? customerTypeValue;

  final StorageServices _storageServices = StorageServices();

  final RemoteApi apiServices = RemoteApi();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 40,
                          child: customTextFieldAddCustomer(
                            context,
                            controller: _postalCode,
                            hintText: 'Postal Code',
                          )),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                        child: SizedBox(
                            height: 40,
                            child: longButton(
                                context, 'LOOK UP', CustomColors.primeColour)))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: customTextFieldForm(
                      context,
                      controller: _address,
                      hintText: 'Address',
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: phoneValidationError ? 62 : 40,
                    width: MediaQuery.of(context).size.width,
                    child: customTextFieldAddCustomer(context,
                        controller: _mobileNo,
                        hintText: 'Mobile No', validator: (value) {
                      String? error = mobilNumberValidator(value);
                      if (error != null) {
                        setState(() {
                          phoneValidationError = true;
                        });
                      } else {
                        setState(() {
                          phoneValidationError = false;
                        });
                      }
                      return error;
                    })),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: emailValidationError ? 62 : 40,
                    width: MediaQuery.of(context).size.width,
                    child: customTextFieldAddCustomer(
                      context,
                      controller: _email,
                      hintText: 'Email',
                      validator: (value) {
                        String? error = validateEmail(value!);
                        if (error != null) {
                          setState(() {
                            emailValidationError = true;
                          });
                        } else {
                          setState(() {
                            emailValidationError = false;
                          });
                        }
                        return error;
                      },
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                        decoration: const InputDecoration(
                          iconColor: CustomColors.white,
                          isDense: true,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        buttonHeight: 40,
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: CustomColors.textFldBorder,
                              width: 1,
                            ),
                            color: CustomColors.white),
                        itemPadding: EdgeInsets.symmetric(horizontal: 15),
                        itemHeight: MediaQuery.of(context).size.height * 0.056,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        iconOnClick: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.arrow_drop_up,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'CIS or General',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: CustomColors.textFieldTextColour),
                          ),
                        ),
                        value: customerTypeValue,
                        onChanged: (value) {
                          setState(() {
                            customerTypeValue = value as String;
                          });
                        },
                        items: customerType
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    item,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: CustomColors.black),
                                  ),
                                )))
                            .toList(),
                        validator: (value) {
                          return validationDropField(value);
                        }),
                  ),
                ),
                /* SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: customTextFieldForm(
                      controller: _cis,
                      hintText: 'CIS or General',
                    )),*/
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          bool statusForm = formValidate();

                          String? userId = await _storageServices.getUserId();
                          String? email = await _storageServices.getEmail();

                          debugPrint('User ID ${userId.toString()}');

                          if (statusForm) {
                            AddCustomerResponse? status =
                                await apiServices.addCustomer(AddCustomerModel(
                              title: _title.text,
                              first_name: _firstName.text,
                              last_name: _lastName.text,
                              post_code: _postalCode.text,
                              look_up: 'Static',
                              address: _address.text,
                              mobile_number: _mobileNo.text,
                              email_address: _email.text,
                              CIS_General: customerTypeValue,
                              user_email: email,
                              user_id: userId,
                              status: '1',
                            ));

                            debugPrint(status.toString());

                            if (status!.status == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Response added successfully')));

                              BlocProvider.of<CustomerSearchCubit>(context)
                                  .getCustomer();
                              Navigator.pop(context);
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
                          /*else {
                            Fluttertoast.showToast(
                                msg: 'Please Enter Correct value',
                                backgroundColor: CustomColors.main,
                                textColor: CustomColors.white,
                                gravity: ToastGravity.CENTER);
                          }*/
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

Widget customTextFieldForm(context,
    {required TextEditingController controller,
    required String hintText,
    bool isBig = false}) {
  return TextFormField(
    keyboardType: controller.text == 'Mobile No' ||
            controller.text == 'Amount' ||
            hintText.contains('Cost')
        ? TextInputType.phone
        : TextInputType.emailAddress,
    controller: controller,
    maxLines: hintText.contains('Project Details')
        ? 20
        : isBig
            ? 10
            : 1,
    style: Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: CustomColors.black),
    onChanged: (value) {
      if (hintText == 'Amount') {
        // Remove any non-digit characters from the input
        String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
        // Parse the cleaned value as an integer
        int? number = int.tryParse(cleanValue);
        if (number != null) {
          // Format the number with commas
          String formattedNumber = NumberFormat.decimalPattern().format(number);
          // Update the TextField value with the formatted number
          controller.value = TextEditingValue(
            text: formattedNumber,
            selection: TextSelection.collapsed(offset: formattedNumber.length),
          );
        }
      }
    },
    decoration: InputDecoration(
      hintText: hintText,
      contentPadding: hintText.contains('Project Details')
          ? const EdgeInsets.only(top: 10, left: 10)
          : isBig
              ? const EdgeInsets.only(top: 16, left: 10)
              : const EdgeInsets.only(top: 2, left: 10),
      hintStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: CustomColors.textFieldTextColour),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}

Widget customTextFieldAddCustomer(context,
    {required TextEditingController controller,
    required String hintText,
    FormFieldValidator<String>? validator}) {
  int maxLength = giveMaxLength(hintText);
  return TextFormField(
    validator: validator,
    controller: controller,
    maxLines: hintText.contains('Project Details') ? 20 : 1,
    maxLength: maxLength,
    style: Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: CustomColors.black),
    keyboardType: hintText.contains('Mobile No') || hintText.contains('Amount')
        ? TextInputType.phone
        : TextInputType.emailAddress,
    // inputFormatters: hintText.contains('Postal Code')
    //     ? [FilteringTextInputFormatter.digitsOnly]
    //     : [],
    decoration: InputDecoration(
      counterText: "",
      hintText: hintText,
      contentPadding: hintText.contains('Project Details')
          ? const EdgeInsets.only(top: 10, left: 10)
          : const EdgeInsets.only(top: 2, left: 10),
      hintStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: CustomColors.textFieldTextColour),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColors.textFieldBorderColor),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}

int giveMaxLength(String hintText) {
  switch (hintText) {
    case 'Mobile No':
      return 11;
    case 'Postal Code':
      return 10;

    default:
      return 30;
  }
}
