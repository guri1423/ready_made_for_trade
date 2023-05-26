import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class EditWebsitePage extends StatefulWidget {
  const EditWebsitePage({Key? key}) : super(key: key);

  @override
  State<EditWebsitePage> createState() => _EditWebsitePageState();
}

class _EditWebsitePageState extends State<EditWebsitePage> {
  final TextEditingController vatNUmber = TextEditingController();

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
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    'HOME',
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: CustomColors.primeColour),
                  ),
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
                        hintText: 'Home Title',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    'ABOUT',
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: CustomColors.primeColour),
                  ),
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
                        hintText: 'Home Title',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    'SERVICES',
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: CustomColors.primeColour),
                  ),
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
                        hintText: 'Home Title',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'THEME COLOURS',
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: CustomColors.primeColour),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                            context, 'CLEAR', CustomColors.greyButton, 50)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                  height: 40,
                  child: smallButton(context, 'GET A PROFESSIONAL WEBSITE',
                      CustomColors.primeColour, 50)),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
