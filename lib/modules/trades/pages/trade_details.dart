

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/modules/trades/models/get_all_trades_model.dart';
import 'package:ready_made_4_trade/modules/trades/pages/edit_trades.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

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
                  Expanded(child: customisedButton(context, 'CALL', CustomColors.blueButton, 'assets/images/small_icons/005-phone-call.png')),

                  Expanded(child: customisedButton(context, 'EMAIL', CustomColors.blueButton, 'assets/images/small_icons/001-email.png')),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: customisedButton(context, 'MESSAGE', CustomColors.blueButton, 'assets/images/small_icons/031-whatsapp.png')),

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
}
