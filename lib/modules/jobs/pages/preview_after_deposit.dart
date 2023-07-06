

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/invoice_paid.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/job_live_page.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../../../core/colors.dart';

class PreviewAfterDeposit extends StatefulWidget {
  int? jobId;
  int? customerId;
  int? projectId;
   PreviewAfterDeposit({Key? key, required this.jobId, required this.customerId, required this.projectId, this.isComingFromInvoicePaid = false}) : super(key: key);

  final bool isComingFromInvoicePaid;

  @override
  State<PreviewAfterDeposit> createState() => _PreviewAfterDepositState();
}



RemoteApi _remoteApi = RemoteApi();

class _PreviewAfterDepositState extends State<PreviewAfterDeposit> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    TextStyle style = const TextStyle(
      fontSize: 14,
      fontFamily: 'Dongle Regular',
      color: CustomColors.greyButton,
    );


    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () {

                if(widget.isComingFromInvoicePaid){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> InvoicePaid(customerId: widget.customerId, jobId: widget.jobId, projectId: widget.projectId, isComingFromReceipt: true,)));

                }
                else {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> JobLivePage(customerId: widget.customerId, jobId: widget.jobId)));
                }
              },
              child: smallButton(
                  context, 'SEND INVOICE', CustomColors.blueButton, 170)),
          SizedBox(height: 10,),
          const BottomToolsForInsidePage(),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: FutureBuilder<GetJobInvoiceData?>(
          future: _remoteApi.getJobInvoice(widget.jobId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'INVOICE  #${snapshot.data!.data.quoteId}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                snapshot.data!.data.customerName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            height: 80,
                            width: 140,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15,top: 9,bottom: 9),
                                child: Image.network(
                                  '${snapshot.data!.data.filePath}/${snapshot.data!.data.userLogo}',fit: BoxFit.fill,
                                ),
                              ),
                              // Show an empty SizedBox if logo is null
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          /*SizedBox(
                            height: 70,
                            width: 120,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.network(
                                '${snapshot.data!.data.filePath}/${snapshot.data!.data.userLogo}',
                              ),
                            ),
                          )*/
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text( snapshot.data!.data.customerAddress,

                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Dongle Regular',
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text(
                              '   ${formattedDate}\n'
                                  'Quote #${snapshot.data!.data.quoteId}',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Dongle Regular',
                                color: CustomColors.blueButton,
                              ),),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.data.projectDescription,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Dongle Regular',
                              height: 1.5,
                              color: CustomColors.greyButton,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.black,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 47),
                            child: Row(
                              children: [
                                Text(
                                  'TOTAL',
                                  style: style,
                                ),
                                Spacer(),
                                Text(
                                  '\£  ${snapshot.data!.data.totalPrice}',
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: CustomColors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 47),
                            child: Row(
                              children: [
                                Text(
                                  'TOTAL INC VAT',
                                  style: style,
                                ),
                                Spacer(),
                                Text(
                                  '\£${snapshot.data!.data.totalIncVat}',
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: CustomColors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 47),
                            child: Row(
                              children: [
                                Text(
                                  'PAID',
                                  style: style,
                                ),
                                Spacer(),
                                Text(
                                  '\£ ${snapshot.data!.data.depositAmount}',
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: CustomColors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 47),
                            child: Row(
                              children: [
                                Text(
                                  'REMAINING',
                                  style: style,
                                ),
                                Spacer(),
                                Text(
                                  '\£ ${snapshot.data!.data.remaining}',
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.data.invoiceTerms,style: style,),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
