
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/invoice_sent.dart';

class SendInvoicePage extends StatefulWidget {
  int? jobId;
  int? projectId;
  int? customerId;
  SendInvoicePage({Key? key, required this.jobId, required this.projectId, required this.customerId}) : super(key: key);

  @override
  State<SendInvoicePage> createState() => _SendInvoicePageState();
}

class _SendInvoicePageState extends State<SendInvoicePage> {
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

      body: Stack(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('INVOICE  #001',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily:'Dongle',
                                color: CustomColors.blueButton,
                                fontWeight: FontWeight.bold
                            ),),

                          Text('MR JOHN SMITH',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily:'Dongle',
                                color: CustomColors.blueButton,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),

                      Spacer(),

                      SizedBox(
                        height: 80,
                        width: 120,
                        child: Container(

                          decoration: BoxDecoration(
                            color: CustomColors.pinkContainer,
                            borderRadius: BorderRadius.circular(10),


                          ),
                        ),
                      )
                    ],
                  ),




                  Row(
                    children: [
                      Text('1 EXAMPLE LANE,\n''SOUTHEND,\n''ESSEX,\n''D50 HHD'  ,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily:'Dongle',
                              color: CustomColors.blueButton,
                              fontWeight: FontWeight.bold
                          )),

                      Spacer(),

                      Text('12/09/2023\n''Quote #005'  ,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily:'Dongle',
                              color: CustomColors.blueButton,
                              fontWeight: FontWeight.bold
                          )),
                    ],
                  ),

                  Text('Lorem ipsum dolor sit amet, '
                      'consectetur adipiscing elit, sed do eiusmod '
                      'tempor incididunt ut labore et dolore magna aliqua. '
                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco '
                      'laboris nisi ut aliquip ex ea commodo consequat Lorem ipsum'
                      ' dolor sit amet, consectetur adipiscing elit, '
                      'sed do eiusmod tempor incididunt ut labore et dolore magna '
                      'aliqua. Ut enim ad minim veniam, quis nostrud exercitation '
                      'ullamco laboris nisi ut aliquip ex ea commodo consequat Lorem ipsum'
                      ' dolor sit amet, consectetur adipiscing elit,',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily:'Dongle',
                        color: CustomColors.greyButton,
                        fontWeight: FontWeight.bold
                    ), ),

                  Column(
                    children: [
                      Row(
                        children: [
                          Text('TOTAL',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),

                          Spacer(),

                          Text('\£ 5000',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),

                      Divider(
                        thickness: 2,
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          Text('TOTAL INC VAT',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),

                          Spacer(),

                          Text('\$ 5000',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),

                      Divider(
                        thickness: 2,
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          Text('PAID',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),

                          Spacer(),

                          Text('\£ 5000',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),

                      Divider(
                        thickness: 2,
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          Text('REMAINING',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),

                          Spacer(),

                          Text('\£ 5000',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:'Dongle',
                                color: CustomColors.greyButton,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),

                      Divider(
                        thickness: 2,
                      )
                    ],
                  ),



                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing '
                      'elit, sed do eiusmod tempor incididunt ut labore et '
                      'dolore magna aliqua. Ut enim ad minim veniam, quis '
                      'nostrud exercitation ullamco laboris nisi ut aliquip ex '
                      'ea commodo consequat',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily:'Dongle',
                        color: CustomColors.greyButton,
                        fontWeight: FontWeight.bold
                    ),),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(

                    crossAxisAlignment: CrossAxisAlignment.end,

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap:(){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> InvoiceSent(
                              customerId: widget.customerId,
                              jobId: widget.jobId,projectId: widget.projectId,)));
                          },

                          child: smallButton(context, 'SEND INVOICE', CustomColors.blueButton, 170)),
                    ],
                  ),
                  SizedBox(height: 6,)
                ],
              ),
            ),

          ]
      ),


    );
  }
}
