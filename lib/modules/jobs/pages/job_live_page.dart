import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/gallery/models/project_response_model.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/bloc/jobs_cubit.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/invoice_paid.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/preview_after_deposit.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:ready_made_4_trade/widgets/date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobLivePage extends StatefulWidget {
  int? customerId;
  int? jobId;
  int? projectId;

  JobLivePage(
      {Key? key, required this.customerId, required this.jobId, this.projectId})
      : super(key: key);

  @override
  State<JobLivePage> createState() => _JobLivePageState();
}

class _JobLivePageState extends State<JobLivePage> {
  TextEditingController _materialCost = TextEditingController();
  TextEditingController _labourCost = TextEditingController();
  TextEditingController _vat = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _totalPrice = TextEditingController();
  TextEditingController _projectTitle = TextEditingController();
  TextEditingController _projectDetails = TextEditingController();

  RemoteApi _remoteApi = RemoteApi();
  String? vatValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:BottomToolsForInsidePage(

        ) ,
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
        body: BlocProvider<JobsCubit>(
          create: (context) =>
              JobsCubit()..getJobsData(widget.jobId.toString()),
          child: BlocBuilder<JobsCubit, JobsState>(
            builder: (context, state) {
              if (state is JobsDataByIdLoaded) {
                vatValue = state.jobData.data.vat ?? vatValue;

                _projectTitle.text =
                    state.jobData.data.projectTitle ?? _projectTitle.text;
                _projectDetails.text = state.jobData.data.projectDescription ??
                    _projectDetails.text;
                _vat.text = state.jobData.data.vat ?? _vat.text;
                _materialCost.text =
                    state.jobData.data.materialCost ?? _materialCost.text;
                _labourCost.text =
                    state.jobData.data.labourCost ?? _labourCost.text;

                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'JOB #${state.jobData.data.quoteId} - JOB LIVE',
                                  style: TextStyle(
                                      fontSize: 20,
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
                        ),
                        Container(
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
                                              padding:
                                                  const EdgeInsets.all(20.0),
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
                                                state
                                                    .jobData.data.customerName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith()),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(state.jobData.data.customerAddress!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith()),
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
                                Row(
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
                                      width: 30,
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: customTextFieldForm(context,
                              controller: _projectTitle,
                              hintText: 'Project Title'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 200,
                            child: customTextFieldForm(context,
                                controller: _projectDetails,
                                hintText: 'Project Details')),
                        /*Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.jobData.data.projectTitle!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color:
                                                  CustomColors.primeColour,fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            )),*/
                       /* Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 180,
                                    child: Text(
                                      '${state.jobData.data.projectDescription!}',
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: CustomColors.primeColour,fontSize: 15),
                                    ),
                                  ),
                                 *//* SizedBox(
                                      height: 200,
                                      child: customTextFieldForm(context,
                                          controller: _projectDetails,
                                          hintText: 'Project Details')),*//*
                                ],
                              ),
                            ),
                          ),
                        ),*/
                        Padding(
                          padding:  EdgeInsets.only(left:10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Material - \£${state.jobData.data.materialCost}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 80),
                              Text(
                                'Labour - \£${state.jobData.data.labourCost}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (state.jobData.data.isVat! == '1')
                                Text(
                                  'Total Inc VAT - \£${state.jobData.data.totalIncVat!}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold),
                                )
                              else
                                Text(
                                  'Total - \£${state.jobData.data.totalPrice!}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold),
                                ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '          ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    dialogBox(context);
                                  },
                                  child: smallButton(context, 'ADD PAYMENT',
                                      CustomColors.blueButton, 140)),
                              SizedBox(width: 40),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Paid -\£${state.jobData.data.depositAmount ?? '0'}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.blueButton,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PreviewAfterDeposit(
                                                      jobId: widget.jobId,
                                                      customerId:
                                                          widget.customerId,
                                                      projectId:
                                                          widget.customerId)));
                                    },
                                    child: smallButton(context, 'PREVIEW',
                                        CustomColors.skyblue, 170)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              if (int.parse(
                                      state.jobData.data.depositAmount ?? '0') <=
                                  int.parse(state.jobData.data.totalPrice!))
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PreviewAfterDeposit(
                                                        jobId: widget.jobId,
                                                        customerId:
                                                            widget.customerId,
                                                        projectId:
                                                            widget.customerId)));
                                      },
                                      child: smallButton(context, 'SEND INVOICE',
                                          CustomColors.blueButton, 170)),
                                )
                              else
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => InvoicePaid(
                                                    jobId: widget.jobId,
                                                    customerId: widget.customerId,
                                                    projectId:
                                                        widget.customerId)));
                                      },
                                      child: smallButton(context, 'FINAL INVOICE',
                                          CustomColors.blueButton, 170)),
                                )
                            ],
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
        ));
  }

  Future<void> dialogBox(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustomColors.primeColour,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PAYMENT',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Dongle',
                        color: CustomColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                            color: CustomColors.textFieldBorderColor, width: 1),
                            color: Colors.white,
                          ),
                        child: SizedBox(
                          height: 40,
                          child: textField1(
                            context, _totalPrice, '£ Total Price', 40, 50,
                          ),
                        ),
                      ),
                  ),
                  SizedBox(width: 15),
                 Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: CustomDatePicker(
                          isMandate: false,
                          isDiary: false,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          AddProjectResponse? model = await _remoteApi.addPayment(
                              _totalPrice.text.replaceAll('£', ' '),
                              widget.jobId.toString(),
                              'Deposit Paid',
                              BlocProvider.of<PickupDateCubit>(context).getPickupDate());

                          if (model != null) {
                            /*Fluttertoast.showToast(
                            msg: model.message!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);*/

                            Navigator.pop(context);
                            setState(() {});
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
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: smallButton(
                              context, 'SAVE', CustomColors.greyButton, 100),
                        ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _totalPrice.clear();
                          _date.clear();
                          Navigator.pop(context);

                          setState(() {});
                        },
                        child: smallButton(
                            context, 'DELETE', CustomColors.yellow, 100),
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
