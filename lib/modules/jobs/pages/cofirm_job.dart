import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/job_agreed_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/date_picker.dart';
import 'package:ready_made_4_trade/widgets/time_picker.dart';

import 'job_live_page.dart';

class ConfirmJob extends StatefulWidget {
  int? jobId;
  int? customerId;
  int? projectId;

  ConfirmJob(
      {Key? key, required this.jobId, required this.customerId, this.projectId})
      : super(key: key);

  @override
  State<ConfirmJob> createState() => _ConfirmJobState();
}

class _ConfirmJobState extends State<ConfirmJob> {
  final TextEditingController _year = TextEditingController();

  final TextEditingController _yearEnd = TextEditingController();

  RemoteApi _remoteApi = RemoteApi();
  StorageServices _storageServices = StorageServices();

  int? hoursValue;
  int? dateValue;
  int? monthValue;
  int? minutesValue;

  int? endHoursValue;
  int? endDateValue;
  int? endMonthValue;
  int? endMinutesValue;

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundColour,
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text('CONFIRM JOB #001',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: CustomColors.blueText)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                    },
                    child: const Icon(
                      Icons.close_outlined,
                      size: 30,
                      color: CustomColors.primeColour,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'JOB START DATE',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: CustomColors.blueText),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Expanded(
                      child: CustomDatePicker(
                    isMandate: false,
                    isDiary: false,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTimePicker(
                    isMandate: false,
                    isDiary: false,
                  ))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'JOB END DATE',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: CustomColors.blueText),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Expanded(
                      child: CustomDatePicker2(
                    isMandate: false,
                    isDiary: false,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTimePicker2(
                    isMandate: false,
                    isDiary: false,
                  ))
                ],
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                await _remoteApi.confirmJob(JobAgreedModel(
                              jobId: widget.jobId,
                              jobStartDate:
                                  BlocProvider.of<PickupDateCubit>(context)
                                      .getPickupDate(),
                              status: 'Confirm Start Date',
                              depositAmount: '600',
                              jobEndDate:
                                  BlocProvider.of<PickupDateCubit2>(context)
                                      .getPickupDate(),
                              jobStartTime:
                                  BlocProvider.of<PickupTimeCubit>(context)
                                      .getPickupTime(),
                              jobEndTime:
                                  BlocProvider.of<PickupTimeCubit2>(context)
                                      .getPickupTime(),
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
                                      builder: (context) => JobLivePage(
                                            customerId: widget.customerId,
                                            jobId: widget.jobId,
                                          )));
                            } else {
                              /*   Fluttertoast.showToast(
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
                              CustomColors.blueButton, 12)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
