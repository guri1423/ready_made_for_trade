import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/bloc/jobs_cubit.dart';
import 'package:ready_made_4_trade/modules/jobs/models/add_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/job_date_time_start.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/preview_job_quote.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../models/get_job_data.dart';

class QuoteSent extends StatefulWidget {
  int? jobId;
  int? projectId;
  int? customerId;

  QuoteSent({Key? key, this.jobId, this.projectId, required this.customerId})
      : super(key: key);

  @override
  State<QuoteSent> createState() => _QuoteSentState();
}

class _QuoteSentState extends State<QuoteSent> {
  TextEditingController _materialCost = TextEditingController();
  TextEditingController _labourCost = TextEditingController();
  TextEditingController _vat = TextEditingController();
  TextEditingController _projectTitle = TextEditingController();
  TextEditingController _projectDetails = TextEditingController();

  StorageServices _storageServices = StorageServices();
  RemoteApi _remoteApi = RemoteApi();

  String? vatValue;

  String changeValue(String value) {
    debugPrint(value);
    debugPrint('vat val');
    if (value == '1') {
      return 'YES';
    } else {
      return 'NO';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.titleSmall!.copyWith();
    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 55,
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
        bottomNavigationBar: const BottomToolsForInsidePage(),
        body: BlocProvider<JobsCubit>(
          create: (context) =>
              JobsCubit()..getJobsData(widget.jobId.toString()),
          child: BlocBuilder<JobsCubit, JobsState>(
            builder: (context, state) {
              if (state is JobsDataByIdLoaded) {
                _projectTitle.text =
                    state.jobData.data.projectTitle ?? _projectTitle.text;
                _projectDetails.text = state.jobData.data.projectDescription ??
                    _projectDetails.text;
                _vat.text = state.jobData.data.vat ?? _vat.text;
                _materialCost.text =
                    '£${state.jobData.data.materialCost ?? _materialCost.text}';
                _labourCost.text =
                    '£${state.jobData.data.labourCost ?? _labourCost.text}';

                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'JOB #${state.jobData.data.quoteId} - QUOTE SENT',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
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
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Container(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: CustomColors.white,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Image.asset(
                                                      'assets/images/user.png'),
                                                )),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    state.jobData.data
                                                        .customerName!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith()),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                    state.jobData.data.customerAddress!,
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
                                    SizedBox(
                                      height: 22,
                                      child: Row(
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
                                            width: 15,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: customTextFieldForm(context,
                              controller: _projectTitle,
                              hintText: 'Project Title'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 200,
                            child: customTextFieldForm(context,
                                controller: _projectDetails,
                                hintText: 'Project Details')),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SizedBox(
                                  height: 40,
                                  child: customTextFieldForm(
                                    context,
                                    controller: _materialCost,
                                    hintText: 'Material Cost',
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: SizedBox(
                                  height: 40,
                                  child: customTextFieldForm(
                                    context,
                                    controller: _labourCost,
                                    hintText: 'Labour Cost',
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                  height: 40,
                                  child: Text(
                                    'VAT: ${changeValue(state.jobData.data.isVat!)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: CustomColors.primeColour,fontSize: 15),
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Visibility(
                              visible: state.jobData.data.isVat == '0',
                              replacement: Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: Text(
                                  'Total Inc Vat: £${state.jobData.data.totalIncVat ?? ''}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: CustomColors.primeColour,fontSize: 15
                                      ),
                                ),
                              )),
                              child: Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      'Total: £${state.jobData.data.totalPrice ?? ''}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: CustomColors.primeColour,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Expanded(child: SizedBox()),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  String? userId =
                                      await _storageServices.getUserId();

                                  debugPrint(widget.projectId.toString());
                                  debugPrint(widget.jobId.toString());
                                  debugPrint(userId.toString());

                                  AddQuoteResponse? model =
                                      await _remoteApi.addQuote(AddQuoteModel(
                                          userId: int.parse(userId!),
                                          customerId: widget.customerId,
                                          materialCost: extractNumericValue(
                                              _materialCost.text),
                                          labourCost: extractNumericValue(
                                              _labourCost.text),
                                          vat: int.parse(
                                              state.jobData.data.isVat!),
                                          projectId: widget.projectId,
                                          projectTitle: _projectTitle.text,
                                          projectDescription:
                                              _projectDetails.text,
                                          jobId: widget.jobId,
                                          status: 'Quote Sent'));

                                  if (model != null) {
                                    /*Fluttertoast.showToast(
                                      msg: model.message!,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);*/
                                  } else {
                                    /* Fluttertoast.showToast(
                                      msg: 'Something went wrong',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);*/
                                  }
                                },
                                child: smallButton(
                                    context, 'SAVE', CustomColors.skyblue, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () async {
                                    String? userId =
                                        await _storageServices.getUserId();

                                    debugPrint(widget.projectId.toString());
                                    debugPrint(widget.jobId.toString());
                                    debugPrint(userId.toString());

                                    AddQuoteResponse? model =
                                        await _remoteApi.addQuote(AddQuoteModel(
                                            userId: int.parse(userId!),
                                            customerId: widget.customerId,
                                            materialCost: extractNumericValue(
                                                _materialCost.text),
                                            labourCost: extractNumericValue(
                                                _labourCost.text),
                                            vat: int.parse(
                                                state.jobData.data.isVat!),
                                            projectId: widget.projectId,
                                            projectTitle: _projectTitle.text,
                                            projectDescription:
                                                _projectDetails.text,
                                            jobId: widget.jobId,
                                            status: 'Quote Sent'));

                                    if (model != null) {
                                      /*Fluttertoast.showToast(
                                        msg: model.message!,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);*/
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PreviewJobQuote(
                                                    customerId:
                                                        widget.customerId,
                                                    jobId: widget.jobId,
                                                    projectId: widget.projectId,
                                                  )));
                                    } else {
                                      /* Fluttertoast.showToast(
                                        msg: 'Something went wrong',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);*/
                                    }
                                  },
                                  child: smallButton(context, 'RESEND',
                                      CustomColors.blueButton, 170)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobStartDateTime(
                                                  customerId: widget.customerId,
                                                  jobId: widget.jobId,
                                                  projectId: widget.projectId,
                                                )));
                                  },
                                  child: smallButton(context, 'JOB AGREED',
                                      CustomColors.blueButton, 170)),
                            ),
                          ],
                        )
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
        ));
  }
}
