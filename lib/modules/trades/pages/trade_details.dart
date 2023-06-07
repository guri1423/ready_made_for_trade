

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/modules/trades/models/get_all_trades_model.dart';
import 'package:ready_made_4_trade/modules/trades/pages/edit_trades.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher.dart';

class TradeDetails extends StatefulWidget {
  DatumTrade tradeData;
   TradeDetails({Key? key, required this.tradeData}) : super(key: key);

  @override
  State<TradeDetails> createState() => _TradeDetailsState();
}

class _TradeDetailsState extends State<TradeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10,),
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
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [

              tradeDetails(context, widget.tradeData),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: GestureDetector(
                      onTap: (){
                        makePhoneCall(widget.tradeData.mobileNumber!);
                      },
                      child: customisedButton(context, 'CALL', CustomColors.blueButton, 'assets/images/small_icons/005-phone-call.png'))),

                  SizedBox(width: 20,),

                  Expanded(child: GestureDetector(
                      onTap: (){

                        sendEmail(widget.tradeData.emailAddress!);

                      },
                      child: customisedButton(context, 'EMAIL', CustomColors.blueButton, 'assets/images/small_icons/001-email.png'))),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: GestureDetector(
                      onTap: (){
                        sendWhatsAppMessage(widget.tradeData.mobileNumber!);
                      },
                      child: customisedButton(context, 'MESSAGE', CustomColors.blueButton, 'assets/images/small_icons/031-whatsapp.png'))),

                  SizedBox(width: 20,),

                  const Expanded(child: SizedBox())
                ],
              ),

              GestureDetector(
                  onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditTradesPage(tradeData: widget.tradeData,)));
                  },
                  child: customisedButton(context, 'EDIT TRADES PERSON', CustomColors.blueButton, 'assets/images/small_icons/002-editing.png')),



            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),


    );


  }
  void makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunch(telUri.toString())) {
      await launch(telUri.toString());
    } else {
      throw 'Could not launch phone call';
    }
  }


  void sendEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }


  void sendWhatsAppMessage(String phoneNumber) async {
    final Uri whatsappUri = Uri(
      scheme: 'whatsapp',
      path: 'send',
      queryParameters: {'phone': phoneNumber},
    );

    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      throw 'Could not launch WhatsApp';
    }
  }




}
