import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/add_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/job_date_time_start.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/preview_job_quote.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class QuoteSent extends StatefulWidget {
  int? jobId;
  int? projectId;

  QuoteSent({Key? key, this.jobId, this.projectId}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.titleSmall!.copyWith();
    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 80,
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
        bottomNavigationBar: const BottomToolsForInsidePage(),
        body: FutureBuilder<GetJobInvoiceData?>(
          future: _remoteApi.getJobData(widget.jobId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              GetJobInvoiceData? jobInvoiceData = snapshot.data;

              _projectTitle.text =
                  jobInvoiceData?.data?.projectTitle ?? _projectTitle.text;
              _projectDetails.text = jobInvoiceData?.data?.projectDescription ??
                  _projectDetails.text;
              _vat.text = jobInvoiceData?.data?.vat ?? _vat.text;
              _materialCost.text =
                  jobInvoiceData?.data?.materialCost ?? _materialCost.text;
              _labourCost.text =
                  jobInvoiceData?.data?.labourCost ?? _labourCost.text;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'JOB #${snapshot.data!.data!.quoteId} - QUOTE SENT',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Dongle Regular',
                                color: CustomColors.blueButton,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
                                                  snapshot.data!.data!
                                                      .customerName!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith()),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                  "1 EXAMPLE LANE,\nSOUTHEND,\nESSEX,\nD50 HHD'",
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
                          )),
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
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SizedBox(
                                height: 54,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField2(
                                      decoration: const InputDecoration(
                                        iconColor: CustomColors.white,
                                        isDense: true,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      buttonHeight: 40,
                                      buttonWidth: 40,
                                      buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color: CustomColors.textFldBorder,
                                            width: 1,
                                          ),
                                          color: CustomColors.white),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      itemHeight:
                                          MediaQuery.of(context).size.height *
                                              0.056,
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: CustomColors.primeColour,
                                        ),
                                      ),
                                      iconOnClick: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.arrow_drop_up,
                                          color: CustomColors.primeColour,
                                        ),
                                      ),
                                      hint: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          'VAT',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: CustomColors
                                                      .textFieldTextColour),
                                        ),
                                      ),
                                      value: vatValue,
                                      onChanged: (value) {
                                        setState(() {
                                          vatValue = value as String;
                                        });
                                      },
                                      items: vatList
                                          .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Text(
                                                  item.toString(),
                                                  style: TextStyle(
                                                      color: CustomColors
                                                          .blackText),
                                                ),
                                              )))
                                          .toList(),
                                      validator: (value) {
                                        return validationDropField(value);
                                      }),
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: SizedBox(
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
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
                                        customerId: int.parse(userId),
                                        materialCost: _materialCost.text,
                                        labourCost: _labourCost.text,
                                        vat: _vat.text,
                                        projectId: widget.projectId,
                                        projectTitle: _projectTitle.text,
                                        projectDescription:
                                            _projectDetails.text,
                                        jobId: widget.jobId,
                                        status:  int.parse('0')));

                                if (model != null) {
                                  Fluttertoast.showToast(
                                      msg: model.message!,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Something went wrong',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: smallButton(
                                  context, 'SAVE', CustomColors.skyblue, 0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                                          customerId: int.parse(userId),
                                          materialCost: _materialCost.text,
                                          labourCost: _labourCost.text,
                                          vat: _vat.text,
                                          projectId: widget.projectId,
                                          projectTitle: _projectTitle.text,
                                          projectDescription:
                                              _projectDetails.text,
                                          jobId: widget.jobId,
                                          status:  0));

                                  if (model != null) {
                                    Fluttertoast.showToast(
                                        msg: model.message!,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewJobQuote(
                                                  jobId: widget.jobId,
                                                  projectId: widget.projectId,
                                                )));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Something went wrong',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
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

            if (snapshot.hasError) {
              return const Center(child: Text('Somthing went Wrong'));
            }

            return const Center(child: SingleChildScrollView());
          },
        ));
  }
}
