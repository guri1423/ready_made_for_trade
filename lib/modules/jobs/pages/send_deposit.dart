

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/deposit_requested.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

class SendDeposit extends StatefulWidget {
  int? jobId;
  int? projectId;
  int? customerId;
   SendDeposit({Key? key, required this.jobId, required this.projectId, required this.customerId}) : super(key: key);

  @override
  State<SendDeposit> createState() => _SendDepositState();
}

class _SendDepositState extends State<SendDeposit> {


  RemoteApi _remoteApi = RemoteApi();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
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

      body: FutureBuilder<GetJobData?>(
        future: _remoteApi.getJobData(widget.jobId.toString()),
        builder: (context,  snapshot){

          if(snapshot.hasData){


            return Stack(
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
                              children:  [
                                Text('INVOICE  #${snapshot.data!.data!.quoteId}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily:'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold
                                  ),),

                                Text(snapshot.data!.data!.customerName!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily:'Dongle Regular',
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network('${snapshot.data!.data!.filePath}/${snapshot.data!.data!.userLogo}'),
                              ),
                            )
                          ],
                        ),




                        Row(
                          children:  [
                            Text('1 EXAMPLE LANE,\n''SOUTHEND,\n''ESSEX,\n''D50 HHD'  ,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily:'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold
                                )),

                            Spacer(),

                            Text('${formattedDate}\n''Quote #${snapshot.data!.data!.quoteId}'  ,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily:'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold
                                )),
                          ],
                        ),

                        Text(snapshot.data!.data!.projectDescription!,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily:'Dongle Regular',
                              color: CustomColors.greyButton,
                              fontWeight: FontWeight.bold
                          ), ),

                        Column(
                          children: [
                            Row(
                              children:  [
                                Text('TOTAL',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular',
                                      color: CustomColors.greyButton,
                                      fontWeight: FontWeight.bold
                                  ),),

                                Spacer(),

                                Text('\$ ${snapshot.data!.data!.totalPrice}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular' ,
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
                              children:  [
                                Text('TOTAL INC VAT',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular',
                                      color: CustomColors.greyButton,
                                      fontWeight: FontWeight.bold
                                  ),),

                                Spacer(),

                                Text('\$ ${snapshot.data!.data.vat}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular',
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
                              children:  [
                                Text('PAID',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular',
                                      color: CustomColors.greyButton,
                                      fontWeight: FontWeight.bold
                                  ),),

                                Spacer(),

                                Text('\$ ${snapshot.data!.data.depositAmount}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular',
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
                              children:  [
                                Text('REMAINING',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular',
                                      color: CustomColors.greyButton,
                                      fontWeight: FontWeight.bold
                                  ),),

                                Spacer(),

                                Text('\$ ${snapshot.data!.data.totalPrice}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:'Dongle Regular',
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



                        // const Text('Lorem ipsum dolor sit amet, consectetur adipiscing '
                        //     'elit, sed do eiusmod tempor incididunt ut labore et '
                        //     'dolore magna aliqua. Ut enim ad minim veniam, quis '
                        //     'nostrud exercitation ullamco laboris nisi ut aliquip ex '
                        //     'ea commodo consequat',
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       fontFamily:'Dongle Regular',
                        //       color: CustomColors.greyButton,
                        //       fontWeight: FontWeight.bold
                        //   ),),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Row(

                      crossAxisAlignment: CrossAxisAlignment.end,

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap:(){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DepositRequested(
                                customerId: widget.customerId,
                                jobId: widget.jobId,projectId: widget.projectId,)));
                            },

                            child: smallButton(context, 'SEND INVOICE', CustomColors.blueButton, 170)),
                      ],
                    ),
                  ),

                ]
            );
          }

          if(snapshot.hasError){
            return const Center(child: Text('Somthing went Wrong'));
          }

          return const Center(child: SingleChildScrollView());
        },
      )




    );
  }
}
