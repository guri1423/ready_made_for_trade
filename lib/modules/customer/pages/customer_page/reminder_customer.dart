

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:ready_made_4_trade/widgets/date_picker.dart';
import 'package:ready_made_4_trade/widgets/time_picker.dart';

import '../../../../core/list/list.dart';

class ReminderCustomer extends StatefulWidget {
  const ReminderCustomer({Key? key}) : super(key: key);

  @override
  State<ReminderCustomer> createState() => _ReminderCustomerState();
}

class _ReminderCustomerState extends State<ReminderCustomer> {
  final TextEditingController _projectTitle = TextEditingController();
  final TextEditingController _projectDetails = TextEditingController();
  final TextEditingController _year = TextEditingController();

  int? hoursValue;
  int? dateValue;
  int? monthValue;
  int? minutesValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 55,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset('assets/images/02 Notification.png'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric( vertical: 18, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: (){

                          Navigator.pop(context);

                        },
                        child: smallButton(context, 'DELETE', CustomColors.greyButton, 170)),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: smallButton(context, 'SAVE', CustomColors.blueButton, 170),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            const BottomToolsForInsidePage(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  GestureDetector(
                      onTap: (){


                      },
                      child: Icon(Icons.close_outlined)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'SERVICE REMINDER',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          color: CustomColors.blueButton,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'SET REMINDER',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          color: CustomColors.blueButton,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: CustomDatePicker(
                        isMandate: false,
                        isDiary: false,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTimePicker(
                      isMandate: false,
                      isDiary: false,
                    ),
                  ),
            /*      SizedBox(
                    width: 60,
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
                          buttonWidth: 40,
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'DD',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: dateValue,
                          onChanged: (value) {
                            setState(() {
                              dateValue = value as int?;
                            });
                          },
                          items: dateList
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
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 60,
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
                          buttonWidth: 40,
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'MM',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: monthValue,
                          onChanged: (value) {
                            setState(() {
                              monthValue = value as int?;
                            });
                          },
                          items: monthList
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
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      height: 40,
                      width: 60,
                      child: customTextFieldForm(
                          context,
                          controller: _year, hintText: 'YYYY')),
                  const SizedBox(
                    width: 5,
                  ),*/
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: customTextFieldForm(context,
                        controller: _projectTitle, hintText: 'Project Title'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _projectDetails,
                    validator: (value) {
                      return validationTxtField(value);
                    },
                    maxLines: 10,
                    style: TextStyle(color: CustomColors.primeColour),
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: CustomColors.textFieldTextColour,
                            width: 1,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: CustomColors.textFieldTextColour,
                            width: 1,
                          )),
                      hintStyle:
                      TextStyle(fontSize: 13, color: CustomColors.textFieldTextColour),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: CustomColors.textFieldTextColour,
                            width: 1,
                          )),
                      hintText: "Product Details",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
/*  SizedBox(
                    width: 60,
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
                          buttonWidth: 40,
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'hrs',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: hoursValue,
                          onChanged: (value) {
                            setState(() {
                              hoursValue = value as int?;
                            });
                          },
                          items: hoursList
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
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 65,
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
                          buttonWidth: 40,
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 10),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'mins',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: minutesValue,
                          onChanged: (value) {
                            setState(() {
                              minutesValue = value as int?;
                            });
                          },
                          items: minuteList
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
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),*/