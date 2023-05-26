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
  final TextEditingController homeTitle = TextEditingController();
  final TextEditingController homeMsg = TextEditingController();
  final TextEditingController about = TextEditingController();
  final TextEditingController aboutMsg = TextEditingController();
  final TextEditingController service = TextEditingController();
  final TextEditingController serviceMsg = TextEditingController();

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
                        controller: homeTitle,
                        hintText: 'Home Title',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            customTextFieldForm(
              context,
              controller: homeMsg,
              isBig: true,
              hintText:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed '
                  'do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                  ' Ut enim ad minim veniam, quis nostrud exercitation ullamco'
                  ' laboris nisi ut aliquip ex ea commodo consequat. Duis aute '
                  'irure dolor in reprehenderit in',
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
                        controller: about,
                        hintText: 'About Title',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            customTextFieldForm(
              context,
              controller: aboutMsg,
              isBig: true,
              hintText:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed '
                  'do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                  ' Ut enim ad minim veniam, quis nostrud exercitation ullamco'
                  ' laboris nisi ut aliquip ex ea commodo consequat. Duis aute '
                  'irure dolor in reprehenderit in',
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
                        controller: service,
                        hintText: 'Services Title',
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            customTextFieldForm(
              context,
              controller: serviceMsg,
              isBig: true,
              hintText:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed '
                  'do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                  ' Ut enim ad minim veniam, quis nostrud exercitation ullamco'
                  ' laboris nisi ut aliquip ex ea commodo consequat. Duis aute '
                  'irure dolor in reprehenderit in',
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
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: themeColors.length,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: themeColors[index]),
                  );
                },
              ),
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

List<Color> themeColors = [
  const Color.fromRGBO(0, 29, 255, 1),
  const Color.fromRGBO(137, 4, 255, 1),
  const Color.fromRGBO(255, 0, 0, 1),
  const Color.fromRGBO(255, 98, 0, 1),
  const Color.fromRGBO(255, 235, 0, 1),
  const Color.fromRGBO(51, 216, 29, 1),
  const Color.fromRGBO(0, 0, 0, 1),
  const Color.fromRGBO(250, 13, 186, 1),
];
