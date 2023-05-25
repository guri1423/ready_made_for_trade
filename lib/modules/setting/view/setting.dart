import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/setting/view/setting_detail_page.dart';
import 'package:ready_made_4_trade/modules/setting/widget/settings_widget.dart';
import 'package:ready_made_4_trade/services/storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  StorageServices _storageServices = StorageServices();

  final TextEditingController _quoteDays = TextEditingController();
  final TextEditingController _depositDays = TextEditingController();
  final TextEditingController _invoiceDays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    ThemeData theme = Theme.of(context);
    SizedBox sizedBox = const SizedBox(
      height: 15,
    );
    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 200 * oneLogicalPixelInPhysicalPixels,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 8 * oneLogicalPixelInPhysicalPixels,
              ),
              SizedBox(
                width: 160,
                height: 75,
                child: Image.asset(
                  'assets/images/final Logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset('assets/images/updated_images/012-bell.png'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'REMINDERS',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: CustomColors.primeColour),
                    ),
                  ],
                ),
                sizedBox,
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'QUOTE REMINDER NOTIFICATION',
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: CustomColors.primeColour,
                          fontWeight: FontWeight.normal),
                    )),
                    SizedBox(
                        height: 40,
                        width: 48,
                        child: customTextFieldForm(context,
                            controller: _quoteDays, hintText: 'DAYS')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'DEPOSIT REMINDER NOTIFICATION',
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: CustomColors.primeColour,
                          fontWeight: FontWeight.normal),
                    )),
                    SizedBox(
                        height: 40,
                        width: 48,
                        child: customTextFieldForm(context,
                            controller: _depositDays, hintText: 'DAYS')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'INVOICE REMINDER NOTIFICATION',
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: CustomColors.primeColour,
                          fontWeight: FontWeight.normal),
                    )),
                    SizedBox(
                        height: 40,
                        width: 48,
                        child: customTextFieldForm(context,
                            controller: _invoiceDays, hintText: 'DAYS')),
                  ],
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'QUOTE CHASE',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: CustomColors.primeColour),
                    ),
                  ],
                ),
                sizedBox,
                customContainerSettings(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'INVOICE CHASE',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: CustomColors.primeColour),
                    ),
                  ],
                ),
                sizedBox,
                customContainerSettings(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SIGNATURE',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: CustomColors.primeColour),
                    ),
                  ],
                ),
                sizedBox,
                customContainerSettings(context),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SettingDetailPage()));
                        },
                        child: SizedBox(
                            height: 40,
                            child: smallButton(context, 'CANCEL',
                                CustomColors.greyButton, 50)),
                      ),
                    ),
                  ],
                ),
                sizedBox,
              ],
            ),
          ),
        ));
  }
}
