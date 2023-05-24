import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/invoice_sent.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/quote_sent.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class PreviewJobQuote extends StatefulWidget {
  int? jobId;
  int? projectId;

  PreviewJobQuote({Key? key, required this.jobId, required this.projectId})
      : super(key: key);

  @override
  State<PreviewJobQuote> createState() => _PreviewJobQuoteState();
}

class _PreviewJobQuoteState extends State<PreviewJobQuote> {
  RemoteApi _remoteApi = RemoteApi();

  GetJobInvoiceData? jobInvoiceData;

  Future<GetJobInvoiceData?> getJobInvoice() async {
    return await _remoteApi.getJobInvoice(widget.jobId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuoteSent(
                              jobId: widget.jobId,
                              projectId: widget.projectId,
                            )));
              },
              child: smallButton(
                  context, 'SEND QUOTE', CustomColors.blueButton, 170)),
          const BottomToolsForInsidePage(),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
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
      body: FutureBuilder<GetJobInvoiceData?>(
          future: getJobInvoice(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              jobInvoiceData = snapshot.data;
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
                                'INVOICE  #${jobInvoiceData?.data?.quoteId ?? ''}',
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
                                jobInvoiceData?.data?.customerName ?? '',
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
                            height: 70,
                            width: 120,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.network(
                                '${jobInvoiceData?.data?.filePath}/${jobInvoiceData?.data?.userLogo}',
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                              '1 EXAMPLE LANE,\n'
                              'SOUTHEND,\n'
                              'ESSEX,\n'
                              'D50 HHD',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Dongle Regular',
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text(
                              '${formattedDate}\n'
                              'Quote #${jobInvoiceData?.data?.quoteId}',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Dongle Regular',
                                color: CustomColors.blueButton,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        jobInvoiceData!.data!.projectDescription!,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Dongle Regular',
                          height: 1.5,
                          color: CustomColors.greyButton,
                        ),
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
                                  '\$ ${jobInvoiceData?.data?.totalPrice}',
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
                                  '\$ ${jobInvoiceData?.data?.vat}',
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: CustomColors.black,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 47),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         'PAID',
                          //         style: style,
                          //       ),
                          //       Spacer(),
                          //       Text(
                          //         '\$ ${jobInvoiceData?.data?.depositAmount}',
                          //         style: style,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const Divider(
                          //   thickness: 1,
                          //   color: CustomColors.black,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 47),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         'REMAINING',
                          //         style: style,
                          //       ),
                          //       Spacer(),
                          //       Text(
                          //         '\$ ${jobInvoiceData?.data?.depositAmount}',
                          //         style: style,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // const Text(
                      //   'Lorem ipsum dolor sit amet, consectetur adipiscing '
                      //   'elit, sed do eiusmod tempor incididunt ut labore et '
                      //   'dolore magna aliqua. Ut enim ad minim veniam, quis '
                      //   'nostrud exercitation ullamco laboris nisi ut aliquip ex '
                      //   'ea commodo consequat',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontFamily: 'Dongle Regular',
                      //     height: 1.5,
                      //     color: CustomColors.greyButton,
                      //   ),
                      // ),
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
