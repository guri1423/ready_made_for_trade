import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class SetupCompanyInfoPage extends StatefulWidget {
  const SetupCompanyInfoPage({Key? key}) : super(key: key);

  @override
  State<SetupCompanyInfoPage> createState() => _SetupCompanyInfoPageState();
}

class _SetupCompanyInfoPageState extends State<SetupCompanyInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController webAddress = TextEditingController();
  final TextEditingController companyNumber = TextEditingController();
  final TextEditingController vatNUmber = TextEditingController();
  final TextEditingController sortCode = TextEditingController();
  final TextEditingController accountNum = TextEditingController();
  final TextEditingController insurancePolicy = TextEditingController();
  final TextEditingController accountEmailAddress = TextEditingController();
  List<String> addressList = [
    'Address1',
    'Address2',
  ];

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
      bottomNavigationBar: BottomToolsForInsidePage(
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
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
                child: customTextFieldForm(
                  context,
                  controller: _firstName,
                  hintText: 'Company Name',
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                      height: 42,
                      child: customTextFieldAddCustomer(context,
                          controller: _postalCode,
                          hintText: 'Postal Code',
                          validator: (value) => postalCodeValidator(value))),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(
                        height: 40,
                        child: longButton(
                            context, 'LOOK UP', CustomColors.primeColour)),
                    // SizedBox(
                    //   height: 22,
                    // )
                  ],
                ))
              ],
            ),
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
                itemHeight: MediaQuery.of(context).size.height * 0.056,
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Address',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: CustomColors.textFieldTextColour),
                  ),
                ),
                items: addressList
                    .map((item) => DropdownMenuItem(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            item.toString(),
                            style: TextStyle(color: CustomColors.blackText),
                          ),
                        )))
                    .toList(),
                onChanged: (val) {},
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 40,
                child: customTextFieldForm(
                  context,
                  controller: mobileNo,
                  hintText: 'Mobile Number',
                )),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 40,
                child: customTextFieldForm(
                  context,
                  controller: email,
                  hintText: 'Email Adddress',
                )),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 40,
                child: customTextFieldForm(
                  context,
                  controller: webAddress,
                  hintText: 'Web Address',
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                      height: 40,
                      child: customTextFieldForm(
                        context,
                        controller: companyNumber,
                        hintText: 'Company Number',
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
                        controller: vatNUmber,
                        hintText: 'VAT Number',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                      height: 40,
                      child: customTextFieldForm(
                        context,
                        controller: sortCode,
                        hintText: 'Sort Code',
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
                        controller: accountNum,
                        hintText: 'Account Number',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 40,
                child: customTextFieldForm(
                  context,
                  controller: insurancePolicy,
                  hintText: 'Insurance Policy Number',
                )),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 40,
                child: customTextFieldForm(
                  context,
                  controller: accountEmailAddress,
                  hintText: 'Account Email Address',
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        height: 40,
                        child: smallButton(
                            context, 'SAVE', CustomColors.primeColour, 50)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        height: 40,
                        child: smallButton(
                            context, 'CANCEL', CustomColors.greyButton, 50)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
