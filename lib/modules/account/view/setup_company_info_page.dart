import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/account/model/setup_cmpany_model.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../cubit/setup_company/setup_company_info_cubit.dart';

class SetupCompanyInfoPage extends StatefulWidget {
 SetupCompanyInfoPage({Key? key}) : super(key: key);

  @override
  State<SetupCompanyInfoPage> createState() => _SetupCompanyInfoPageState();
}

class _SetupCompanyInfoPageState extends State<SetupCompanyInfoPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController webAddress = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyNumber = TextEditingController();
  TextEditingController vatNUmber = TextEditingController();
  TextEditingController sortCode = TextEditingController();
  TextEditingController accountNum = TextEditingController();
  TextEditingController insurancePolicy = TextEditingController();
  TextEditingController accountEmailAddress = TextEditingController();
  List<String> addressList = [
    'Address1',
    'Address2',
  ];

  @override
  void initState() {
    BlocProvider.of<SetupCompanyInfoCubit>(context).getCompanyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.white,
        elevation: 0,
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
      bottomNavigationBar: BottomToolsForInsidePage(
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: BlocListener<SetupCompanyInfoCubit, SetupCompanyInfoState>(
        listener: (context, state) {
          debugPrint(_firstName.text);
          if (state is SetupCompanyInfoLoaded) {
            _title = TextEditingController(text: state.data.title);
            _firstName = TextEditingController(text: state.data.firstName);
            _lastName = TextEditingController(text: state.data.lastName);
            _postalCode = TextEditingController(text: state.data.postCode);
            address = TextEditingController(text: state.data.address);
            mobileNo = TextEditingController(text: state.data.mobile);
            email = TextEditingController(text: state.data.email);
            webAddress = TextEditingController(text: state.data.webAddress);
            companyName = TextEditingController(text: state.data.companyName);
            companyNumber = TextEditingController(text: state.data.companyNumber);
            vatNUmber = TextEditingController(text: state.data.vatNumber);
            sortCode = TextEditingController(text: state.data.sortCode);
            accountNum = TextEditingController(text: state.data.accountNumber);
            insurancePolicy = TextEditingController(text: state.data.insurancePolicyNumber);
            accountEmailAddress = TextEditingController(text: state.data.accountantEmailAddress);
          }
        },
        child: BlocBuilder<SetupCompanyInfoCubit, SetupCompanyInfoState>(
          builder: (context, state) {
            if (state is SetupCompanyInfoLoaded) {
              return loadedBody(state.data);
            }
            if (state is SetupCompanyInfoUpdateLoading) {
              return Stack(
                children: [
                  loadedBody(state.data),
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget loadedBody(SetupCompanyData data) {
    ThemeData theme = Theme.of(context);
    return Padding(
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
                controller: companyName,
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
          SizedBox(
              height: 40,
              child: customTextFieldForm(
                context,
                controller: address,
                hintText: 'Address',
              )),
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
                  onTap: () {
                    BlocProvider.of<SetupCompanyInfoCubit>(context)
                        .updateCompany(
                            model: SetupCompanyData(
                                userId: data.userId,
                                title: _title.text,
                                firstName: _firstName.text,
                                lastName: _lastName.text,
                                companyName: companyName.text,
                                postCode: _postalCode.text,
                                address: address.text,
                                mobile: mobileNo.text,
                                email: email.text,
                                webAddress: webAddress.text,
                                companyNumber: companyNumber.text,
                                vatNumber: vatNUmber.text,
                                sortCode: sortCode.text,
                                accountNumber: accountNum.text,
                                insurancePolicyNumber: insurancePolicy.text,
                                accountantEmailAddress:
                                    accountEmailAddress.text));
                  },
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
                  onTap: () {
                    Navigator.pop(context);
                  },
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
    );
  }
}
