import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/account/view/add_reminders_page.dart';
import 'package:ready_made_4_trade/modules/home/pages/icon_models/customer_model.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Widget viewJobQuote(context, {JobData? model}) {

  void makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    await launch(telUri.toString());
  }
  bool? value = true;
  TextStyle style = Theme.of(context).textTheme.titleSmall!.copyWith();
  return Container(
    decoration: BoxDecoration(
        color: CustomColors.primeColour,
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('assets/images/user.png'),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(model!.customerName ?? 'MR JOHN SMITH',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith()),
                      const SizedBox(
                        height: 12,
                      ),
                      /*Text(
                          model.address ??
                              "1 EXAMPLE LANE,\nSOUTHEND,\nESSEX,\nD50 HHD'",
                          style: style),*/
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/Phone Icon.png',
                        height: 25,
                        width: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddRemaindersPage()));
                        },
                        child: Image.asset(
                          'assets/images/Book Appointment.png',
                          height: 25,
                          width: 25,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Text(
                'Show Costs on quote',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Dongle',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
          ),
              /* Text('vghgh',style: TextStyle(color: Colors.black),),*/
               SizedBox(
                 width: 30,
                 child: Transform.scale(
                   scale: 0.5,
                   child: Theme(
                     data: Theme.of(context).copyWith(
                       unselectedWidgetColor: Colors.white,
                     ),
                     child: Checkbox(
                       value: false,
                       onChanged: (bool? val) {},
                       checkColor: CustomColors.primeColour,
                       activeColor: Colors.transparent,
                       fillColor: MaterialStateProperty.all(CustomColors.white),
                     ),
                   ),
                 ),
               ),
             ],
           ),
        ],
      ),
    ),
  );
}

Widget viewJobQuoteWithoutModel(context) {
  TextStyle style = Theme.of(context).textTheme.titleSmall!.copyWith();
  return Container(
    decoration: BoxDecoration(
        color: CustomColors.primeColour,
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('assets/images/user.png'),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('MR JOHN SMITH',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith()),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("1 EXAMPLE LANE,\nSOUTHEND,\nESSEX,\nD50 HHD'",
                          style: style),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/Phone Icon.png',
                        height: 25,
                        width: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/Book Appointment.png',
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text('Show Costs on quote',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Dongle',
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}
