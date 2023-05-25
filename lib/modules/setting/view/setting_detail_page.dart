import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/setting/view/add_reminders_page.dart';
import 'package:ready_made_4_trade/modules/setting/view/ask_expert_page.dart';
import 'package:ready_made_4_trade/modules/setting/view/edit_website_page.dart';
import 'package:ready_made_4_trade/modules/setting/view/quote_invoice_terms_page.dart';
import 'package:ready_made_4_trade/modules/setting/view/setup_company_info_page.dart';
import 'package:ready_made_4_trade/modules/setting/view/upload_logo_page.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class SettingDetailPage extends StatefulWidget {
  const SettingDetailPage({Key? key}) : super(key: key);

  @override
  State<SettingDetailPage> createState() => _SettingDetailPageState();
}

class _SettingDetailPageState extends State<SettingDetailPage> {
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: extraLongButton(context, 'LOG OUT'),
          ),
          BottomToolsForInsidePage(
            onBackPress: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: settingList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      navigateToNextPage(index)!));
                        },
                        child: extraLongButton(context, settingList[index],
                            isShowIcon: true),
                      )),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: extraLongButton(context, 'ASK AN EXPERT',
                    color: CustomColors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> settingList = [
  'SET UP COMAPNY INFO',
  'EDIT WEBSITE TEXT',
  'UPLOAD LOGO',
  'QUOTE & INVOICE TERMS',
  'ADD REMINDERS',
];

Widget? navigateToNextPage(int index) {
  switch (index) {
    case 0:
      return SetupCompanyInfoPage();

    case 1:
      return EditWebsitePage();

    case 2:
      return UploadLogoPage();

    case 3:
      return QuoteInvoiceTermsPage();

    case 4:
      return AddRemaindersPage();

    case 5:
      return AskExpertPage();
  }
  return null;
}
