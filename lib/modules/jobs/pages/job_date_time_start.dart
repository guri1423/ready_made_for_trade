import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
import 'package:ready_made_4_trade/modules/jobs/models/job_agreed_model.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/send_deposit.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/date_picker.dart';
import 'package:ready_made_4_trade/widgets/time_picker.dart';

import '../../../widgets/bottom_bar_for_all.dart';

class JobStartDateTime extends StatefulWidget {
  int? jobId;
  int? projectId;
  int? customerId;

  JobStartDateTime(
      {Key? key,
      required this.jobId,
      required this.projectId,
      required this.customerId})
      : super(key: key);

  @override
  State<JobStartDateTime> createState() => _JobStartDateTimeState();
}

class _JobStartDateTimeState extends State<JobStartDateTime> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _dateEnd = TextEditingController();
  final TextEditingController _monthEnd = TextEditingController();
  final TextEditingController _yearEnd = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _timeEnd = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  bool _isChecked = false;

  final RemoteApi _remoteApi = RemoteApi();

  int? hoursValue;
  int? dateValue;
  int? monthValue;
  int? minutesValue;

  int? endHoursValue;
  int? endDateValue;
  int? endMonthValue;
  int? endMinutesValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 8),
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
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: smallButton(
                            context, 'DELETE', CustomColors.greyButton, 170)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () async {
                          JobAgreeResponse? model =
                              await _remoteApi.jobAgreed(JobAgreedModel(
                            jobId: widget.jobId,
                            jobStartDate:  BlocProvider.of<PickupDateCubit>(context).getPickupDate(),
                            jobEndDate:  BlocProvider.of<PickupDateCubit2>(context).getPickupDate(),
                            depositAmount: extractNumericValue(_amount.text),
                            status: 'Confirm Start Date',
                                jobStartTime: BlocProvider.of<PickupTimeCubit>(context).getPickupTime(),
                                jobEndTime: BlocProvider.of<PickupTimeCubit2>(context).getPickupTime(),
                          ));

                          debugPrint(
                              'model print${model!.toJson().toString()}');

                          if (model != null) {
                            /*Fluttertoast.showToast(
                                msg: model.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);*/

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SendDeposit(
                                          customerId: widget.customerId,
                                          jobId: widget.jobId,
                                          projectId: widget.projectId,
                                        )));
                          } else {
                            /*Fluttertoast.showToast(
                                msg: 'Something went wrong',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);*/
                          }
                        },
                        child: smallButton(context, 'SAVE & SEND',
                            CustomColors.blueButton, 170)),
                  ),
                ],
              ),
            ),
            const BottomToolsForInsidePage(),
          ],
        ),
        body: FutureBuilder<GetJobData?>(
            future: _remoteApi.getJobData(widget.jobId.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('JOB #${snapshot.data!.data.quoteId!}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: CustomColors.blueText)),
                        SizedBox(
                          height: 15,
                        ),
                        Text('JOB START DATE',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: CustomColors.blueText)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Expanded(
                                child: CustomDatePicker(
                              isMandate: false,
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomTimePicker(
                              isMandate: false,
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text('JOB END DATE',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: CustomColors.blueText)),
                        const SizedBox(
                          height: 15,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: const [
                        //     Expanded(
                        //         child: CustomDatePicker2(
                        //       isMandate: false,
                        //     )),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Expanded(
                        //         child: CustomTimePicker2(
                        //       isMandate: false,
                        //     ))
                        //   ],
                        // ),
                        SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: customTextFieldForm(context,
                                      controller: _amount,
                                      hintText: 'Deposit Amount')),
                              Expanded(child: Container())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                const Center(child: Text('Something went wrong'));
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
