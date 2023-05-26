import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class UploadLogoPage extends StatefulWidget {
  const UploadLogoPage({Key? key}) : super(key: key);

  @override
  State<UploadLogoPage> createState() => _UploadLogoPageState();
}

class _UploadLogoPageState extends State<UploadLogoPage> {
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
            child: GestureDetector(
                onTap: () {},
                child: extraLongButton(context, 'GET A PROFESSIONAL LOGO')),
          ),
          BottomToolsForInsidePage(
            onBackPress: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColors.primeColour,
                  borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        height: 40,
                        child: smallButton(
                            context, 'UPLOAD', CustomColors.primeColour, 50)),
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
          ],
        ),
      ),
    );
  }
}
