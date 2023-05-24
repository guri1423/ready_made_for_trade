import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/check_list/pages/checklist.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/customers.dart';
import 'package:ready_made_4_trade/modules/dairy/pages/diary.dart';
import 'package:ready_made_4_trade/modules/essentials/pages/essentials.dart';
import 'package:ready_made_4_trade/modules/f_and_i/pages/fAndI.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/jobs.dart';
import 'package:ready_made_4_trade/modules/receipts/pages/receipts.dart';
import 'package:ready_made_4_trade/modules/trades/pages/trades.dart';
import 'package:ready_made_4_trade/modules/trainings/pages/trainings.dart';

import '../model/get_user_data.dart';

List<String> images = [
  'assets/images/updated_images/017-dslr-camera.png',
  'assets/images/Path 6834.png',
  'assets/images/Customer Icon.png',
  'assets/images/JOB Icon.png',
  'assets/images/Diary Icon.png',
  'assets/images/Materials Icon.png',
  'assets/images/Trades Icon.png',
  'assets/images/Checklist Icon.png',
  'assets/images/updated_images/027-insurance-policy.png',
  'assets/images/Receipt Icon.png',
  'assets/images/updated_images/028-delivery-van.png',
  'assets/images/Training Icon.png'
];

List<String> iconNames = [
  'CAMERA',
  'GALLERY',
  'CUSTOMER',
  'JOBS',
  'DIARY',
  'MATERIALS',
  'TRADES',
  'CHECKLIST',
  'F & I',
  'RECEIPTS',
  'ESSENTIALS',
  'TRAINING'
];

Widget jobsContainer(context, UserData userModel) {
  final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

  const SizedBox sizedBox = SizedBox(height: 8);

  ThemeData theme = Theme.of(context);
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(userModel.fullName,
                          softWrap: true,
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: CustomColors.primeColour,
                            fontWeight: FontWeight.normal,
                          )),
                      sizedBox,
                      Text(userModel.businessName,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: CustomColors.primeColour,
                          )),
                      sizedBox,
                      Text(getMonthFromDate(userModel.businessTradingDate.toString()),
                          style: theme.textTheme.titleMedium!
                              .copyWith(color: CustomColors.primeColour)),
                      sizedBox,
                      Text('£ 16,543',
                          style: theme.textTheme.titleLarge!
                              .copyWith(color: CustomColors.skyblue)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 140,
                  child: Container(
                    child: Image.network(
                      '${userModel.filePath}/${userModel.logo}',
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/Path 8242.png'),
                SizedBox(
                  height: 65,
                  width: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColors.greyButton,
                        // set the border color here
                        width: 1.0, // set the border width here
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          userModel.status!,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: CustomColors.primeColour,
                                  ),
                        ),
                        Text(
                          'JOBS QUOTED',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: CustomColors.primeColour),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                  width: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColors.greyButton,
                        // set the border color here
                        width: 1.0, // set the border width here
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '18',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: CustomColors.primeColour),
                        ),
                        Text(
                          'JOBS WON',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: CustomColors.primeColour),
                        )
                      ],
                    ),
                  ),
                ),
                Image.asset('assets/images/right direction.png'),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
String getMonthFromDate(String dateString) {
  DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
  String month = DateFormat.MMMM().format(dateTime);
  return month;
}


Widget homeButtons(context) {
  final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.32,
      child: GridView.builder(
          itemCount: images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                switch (index) {
                  case 0:
                    await getImage(ImageSource.camera).then((value) {});

                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomersPage()));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomersPage()));
                    break;
                  case 3:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JobsPage()));
                    break;
                  case 4:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DiaryPage()));
                    break;
                  case 5:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomersPage()));
                    break;
                  case 6:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TradesPage()));
                    break;
                  case 7:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChecklistPage()));
                    break;
                  case 8:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FAndIPage()));
                    break;
                  case 9:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReceiptsPage()));
                    break;
                  case 10:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EssentialsPage()));
                    break;
                  case 11:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrainingsPage()));
                    break;
                }
              },
              child: Container(
                height: 79.56 * oneLogicalPixelInPhysicalPixels,
                width: 80.18 * oneLogicalPixelInPhysicalPixels,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(images[index]),
                    Text(
                      iconNames[index],
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Dongle',
                          color: CustomColors.blueText,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          }),
    ),
  );
}

Widget homePageImage(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.16,
    width: MediaQuery.of(context).size.width,
    child: Image.asset(
      'assets/images/Ad.png',
      fit: BoxFit.fill,
    ),
  );
}

Future<XFile?> getImage(ImageSource source) async {
  XFile? pickedFile = await ImagePicker().pickImage(source: source);

  return pickedFile;
}
