import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/setting/widget/settings_widget.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class AddRemaindersPage extends StatefulWidget {
  const AddRemaindersPage({Key? key}) : super(key: key);

  @override
  State<AddRemaindersPage> createState() => _AddRemaindersPageState();
}

class _AddRemaindersPageState extends State<AddRemaindersPage> {
  final TextEditingController _quoteDays = TextEditingController();
  final TextEditingController _depositDays = TextEditingController();
  final TextEditingController _invoiceDays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    ThemeData theme = Theme.of(context);
    SizedBox sizedBox = const SizedBox(
      height: 15,
    );
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
                        onTap: () {},
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
