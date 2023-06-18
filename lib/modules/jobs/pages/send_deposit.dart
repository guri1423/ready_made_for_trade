import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/bloc/jobs_cubit.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/deposit_requested.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class SendDeposit extends StatefulWidget {
  int? jobId;
  int? projectId;
  int? customerId;

  SendDeposit(
      {Key? key,
      required this.jobId,
      required this.projectId,
      required this.customerId})
      : super(key: key);

  @override
  State<SendDeposit> createState() => _SendDepositState();
}

class _SendDepositState extends State<SendDeposit> {
  RemoteApi _remoteApi = RemoteApi();

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
                        builder: (context) => DepositRequested(
                              customerId: widget.customerId,
                              jobId: widget.jobId,
                              projectId: widget.projectId,
                            )));
              },
              child: smallButton(
                  context, 'SEND QUOTE', CustomColors.blueButton, 170)),
          SizedBox(
            height: 10,
          ),
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
      body: BlocProvider<JobsCubit>(
        create: (context) => JobsCubit()..getJobInvoiceData(widget.jobId!),
        child: BlocBuilder<JobsCubit, JobsState>(
          builder: (context, state) {
            if (state is JobsInvoiceLoaded) {
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
                                'INVOICE  #${state.data.data.quoteId}',
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
                                state.data.data.customerName,
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
                                '${state.data.data.filePath}/${state.data.data.userLogo}',
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
                          Text(state.data.data.customerAddress,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Dongle Regular',
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text(
                              '${formattedDate}\n'
                              'Quote #${state.data.data.quoteId}',
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
                        state.data.data.projectDescription,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Invoice terms - ${state.data.data.invoiceTerms}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Dongle Regular',
                          height: 1.5,
                          color: CustomColors.greyButton,
                        ),
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
                                  '\£ ${state.data.data.totalPrice}',
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: CustomColors.black,
                          ),
                          if (state.data.data.isVat == '1')
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 47),
                              child: Row(
                                children: [
                                  Text(
                                    'TOTAL INC VAT',
                                    style: style,
                                  ),
                                  Spacer(),
                                  Text(
                                    '\£ ${state.data.data.totalIncVat}',
                                    style: style,
                                  ),
                                ],
                              ),
                            )
                          else
                            SizedBox.shrink(),
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
                                  '\£ ${state.data.data.remaining}',
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: CustomColors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Quote terms - ${state.data.data.quoteTerms}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Dongle Regular',
                          height: 1.5,
                          color: CustomColors.greyButton,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is JobsFailure) {
              return const Center(child: Text('Something went wrong'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
