import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class AskExpertPage extends StatefulWidget {
  const AskExpertPage({Key? key}) : super(key: key);

  @override
  State<AskExpertPage> createState() => _AskExpertPageState();
}

class _AskExpertPageState extends State<AskExpertPage> {
  final TextEditingController messageController = TextEditingController();

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
            Text(
              'ASK AN EXPERT',
              style: theme.textTheme.titleLarge!
                  .copyWith(color: CustomColors.primeColour),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            customTextFieldForm(
              context,
              controller: messageController,
              isBig: true,
              hintText:
                  'Message one of our trusted experts who will help run through your options',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        height: 40,
                        child: smallButton(
                            context, 'SEND', CustomColors.primeColour, 50)),
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
                            context, 'DELETE', CustomColors.greyButton, 50)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: extraLongButton(context, 'REQUEST A CALLBACK',
                  color: CustomColors.primeColour),
            ),
          ],
        ),
      ),
    );
  }
}
