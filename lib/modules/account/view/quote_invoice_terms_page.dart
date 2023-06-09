import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class QuoteInvoiceTermsPage extends StatefulWidget {
  const QuoteInvoiceTermsPage({Key? key}) : super(key: key);

  @override
  State<QuoteInvoiceTermsPage> createState() => _QuoteInvoiceTermsPageState();
}

class _QuoteInvoiceTermsPageState extends State<QuoteInvoiceTermsPage> {
  final TextEditingController inbox1 = TextEditingController();
  final TextEditingController inbox2 = TextEditingController();
  final TextEditingController expiry = TextEditingController();
  final TextEditingController payments = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              'QUOTE TERMS',
              style: theme.textTheme.titleLarge!
                  .copyWith(color: CustomColors.primeColour),
            ),
            const SizedBox(
              height: 10,
            ),
            customTextFieldForm(
              context,
              controller: inbox1,
              isBig: true,
              hintText: '',
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'EXPIRY',
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: CustomColors.primeColour),
                ),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  height: 40,
                  width: 80,
                  child: customTextFieldForm(
                    context,
                    controller: expiry,
                    hintText: '30',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'INVOICE TERMS',
              style: theme.textTheme.titleLarge!
                  .copyWith(color: CustomColors.primeColour),
            ),
            const SizedBox(
              height: 10,
            ),
            customTextFieldForm(
              context,
              controller: inbox2,
              isBig: true,
              hintText: '',
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'PAYMENT TERMS',
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: CustomColors.primeColour),
                ),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  height: 40,
                  width: 80,
                  child: customTextFieldForm(
                    context,
                    controller: payments,
                    hintText: '30',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
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
