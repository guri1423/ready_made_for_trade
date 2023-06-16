import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/gallery/models/project_response_model.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/bloc/jobs_cubit.dart';
import 'package:ready_made_4_trade/modules/jobs/models/add_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/cofirm_job.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:ready_made_4_trade/widgets/date_picker.dart';

class DepositRequested extends StatefulWidget {
  int? jobId;
  int? projectId;
  int? customerId;

  DepositRequested(
      {Key? key, this.jobId, this.projectId, required this.customerId})
      : super(key: key);

  @override
  State<DepositRequested> createState() => _DepositRequestedState();
}

class _DepositRequestedState extends State<DepositRequested> {
  TextEditingController _materialCost = TextEditingController();
  TextEditingController _labourCost = TextEditingController();
  TextEditingController _vat = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _totalPrice = TextEditingController();
  TextEditingController _projectTitle = TextEditingController();
  TextEditingController _projectDetails = TextEditingController();

  RemoteApi _remoteApi = RemoteApi();

  StorageServices _storageServices = StorageServices();

  String? vatValue;

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.titleSmall!.copyWith();
    return Scaffold(
        backgroundColor: CustomColors.backgroundColour,
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
                                  'JOB #${state.jobData.data.quoteId} - DEPOSIT REQUESTED',
                                  style: TextStyle(
                                      fontSize: 15,
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
                        ),
                        SizedBox(
                          height: 5,
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
                                            Text(state.jobData.data.address!,
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
                                Text('Show Costs on quote',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Dongle',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Material - \£${state.jobData.data.materialCost!}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dongle Regular',
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Labour - \£${state.jobData.data.labourCost!}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dongle Regular',
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (state.jobData.data.isVat! == '1')
                              Text(
                                'Total INC VAT - \£${state.jobData.data.totalIncVat!}',
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
                            Text(
                              '                 ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dongle Regular',
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  dialogBox(context);
                                },
                                child: smallButton(context, 'ADD PAYMENT',
                                    CustomColors.blueButton, 170)),
                            SizedBox(width: 40),
                            SizedBox(
                              height: 50,
                              width: 120,
                              child: Center(
                                child: Text(
                                  'Paid - \£ ${state.jobData.data.depositAmount ?? '0'}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      String? userId =
                                          await _storageServices.getUserId();

                                      debugPrint(widget.jobId.toString());
                                      debugPrint(userId.toString());

                                      AddQuoteResponse? model = await _remoteApi
                                          .addQuote(AddQuoteModel(
                                              userId: int.parse(userId!),
                                              customerId: widget.customerId,
                                              materialCost: _materialCost.text,
                                              labourCost: _labourCost.text,
                                              vat: 0,
                                              projectId: widget.projectId,
                                              projectTitle: _projectTitle.text,
                                              projectDescription:
                                                  _projectDetails.text,
                                              jobId: widget.jobId,
                                              status: 'Deposit Requested'));

                                      if (model != null) {
                                        /* Fluttertoast.showToast(
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
                                    child: smallButton(context, 'SAVE',
                                        CustomColors.skyblue, 170)),
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
                                              builder: (context) => ConfirmJob(
                                                    customerId:
                                                        widget.customerId,
                                                    jobId: widget.jobId,
                                                  )));
                                    },
                                    child: smallButton(context, 'DEPOSIT',
                                        CustomColors.blueButton, 170)),
                              ),
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
              return FutureBuilder<GetJobData?>(
                future: _remoteApi.getJobData(widget.jobId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    vatValue = snapshot.data!.data.vat ?? vatValue;

                    _projectTitle.text =
                        snapshot.data!.data.projectTitle ?? _projectTitle.text;
                    _projectDetails.text =
                        snapshot.data!.data.projectDescription ??
                            _projectDetails.text;
                    _vat.text = snapshot.data!.data.vat ?? _vat.text;
                    _materialCost.text =
                        snapshot.data!.data.materialCost ?? _materialCost.text;
                    _labourCost.text =
                        snapshot.data!.data.labourCost ?? _labourCost.text;

                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                      'JOB #${snapshot.data!.data.quoteId} - DEPOSIT REQUESTED',
                                      style: TextStyle(
                                          fontSize: 17,
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
                            ),
                            SizedBox(
                              height: 5,
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
                                                    snapshot.data!.data
                                                        .customerName!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith()),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                    snapshot
                                                        .data!.data.address!,
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
                                    Text('Show Costs on quote',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Dongle',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Material - \£${snapshot.data!.data.materialCost!}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Labour - \£${snapshot.data!.data.labourCost!}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (snapshot.data!.data.isVat! == '1')
                                  Text(
                                    'Total INC VAT - \£${snapshot.data!.data.totalIncVat!}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Dongle Regular',
                                        color: CustomColors.blueButton,
                                        fontWeight: FontWeight.bold),
                                  )
                                else
                                  Text(
                                    'Total - \£${snapshot.data!.data.totalPrice!}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Dongle Regular',
                                        color: CustomColors.blueButton,
                                        fontWeight: FontWeight.bold),
                                  ),
                                Text(
                                  '                 ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      dialogBox(context);
                                    },
                                    child: smallButton(context, 'ADD PAYMENT',
                                        CustomColors.blueButton, 170)),
                                SizedBox(
                                  height: 50,
                                  width: 170,
                                  child: Center(
                                    child: Text(
                                      'Paid - \£ ${snapshot.data!.data.depositAmount ?? '0'}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Dongle Regular',
                                          color: CustomColors.blueButton,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () async {
                                          String? userId =
                                              await _storageServices
                                                  .getUserId();

                                          debugPrint(widget.jobId.toString());
                                          debugPrint(userId.toString());

                                          AddQuoteResponse? model =
                                              await _remoteApi.addQuote(
                                                  AddQuoteModel(
                                                      userId:
                                                          int.parse(userId!),
                                                      customerId:
                                                          widget.customerId,
                                                      materialCost:
                                                          _materialCost.text,
                                                      labourCost:
                                                          _labourCost.text,
                                                      vat: 0,
                                                      projectId:
                                                          widget.projectId,
                                                      projectTitle:
                                                          _projectTitle.text,
                                                      projectDescription:
                                                          _projectDetails.text,
                                                      jobId: widget.jobId,
                                                      status:
                                                          'Deposit Requested'));

                                          if (model != null) {
                                            /* Fluttertoast.showToast(
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
                                        child: smallButton(context, 'SAVE',
                                            CustomColors.skyblue, 170)),
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
                                                      ConfirmJob(
                                                        customerId:
                                                            widget.customerId,
                                                        jobId: widget.jobId,
                                                      )));
                                        },
                                        child: smallButton(context, 'DEPOSIT',
                                            CustomColors.blueButton, 170)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Somthing went Wrong'));
                  }

                  return const Center(child: SingleChildScrollView());
                },
              );
            },
          ),
        ));
  }

  Future<void> dialogBox(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            child: Column(
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
                          color: CustomColors.blueButton,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: textField(context, _totalPrice, 'Total Price', 40, 50)),
                    Expanded(
                        child: CustomDatePicker(
                          isMandate: false,
                          isDiary: false,
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
                            _totalPrice.text,
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
                      child: smallButton(
                          context, 'SAVE', CustomColors.greyButton, 100),
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
          ),
        );
      },
    );
  }
}
