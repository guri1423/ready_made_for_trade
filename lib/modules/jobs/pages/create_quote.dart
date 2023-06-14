import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/add_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/preview_job_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/widgets/job_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class CreateQuote extends StatefulWidget {
  int? jobId;
  int? projectId;
  String? customerId;

  CreateQuote({Key? key, this.jobId, this.projectId, required this.customerId})
      : super(key: key);

  @override
  State<CreateQuote> createState() => _CreateQuoteState();
}

class _CreateQuoteState extends State<CreateQuote> {
  TextEditingController _materialCost = TextEditingController();
  TextEditingController _labourCost = TextEditingController();
  TextEditingController _vat = TextEditingController();
  TextEditingController _projectTitle = TextEditingController();
  TextEditingController _projectDetails = TextEditingController();

  final RemoteApi _remoteApi = RemoteApi();
  final StorageServices _storageServices = StorageServices();

  String? vatValue;


  int changeValue(String value) {
    if (value == 'YES')
      return 1;
    else
      return 0;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
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
        bottomNavigationBar: const BottomToolsForInsidePage(),
        body: FutureBuilder<GetJobData?>(
          future: _remoteApi.getJobData(widget.jobId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              _projectTitle.text =
                  snapshot.data!.data.projectTitle ?? _projectTitle.text;
              _projectDetails.text = snapshot.data!.data.projectDescription ??
                  _projectDetails.text;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'JOB #${snapshot.data!.data.quoteId!} - QUOTE NEEDED',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: CustomColors.primeColour),
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
                        child: viewJobQuote(context,
                            model: JobData(
                                customerName: snapshot.data!.data.customerName,
                                address: snapshot.data!.data.address,
                                userName: snapshot.data!.data.userName)),
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
                        height: 10,
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
                                            color: CustomColors.textFieldBorderColor,
                                          ),
                                          color: CustomColors.white),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      itemHeight:
                                          MediaQuery.of(context).size.height *
                                              0.056,
                                      icon: const Padding(
                                        padding: EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: CustomColors.primeColour,
                                        ),
                                      ),
                                      iconOnClick: const Padding(
                                        padding: EdgeInsets.only(right: 2),
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
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          color: CustomColors
                                                              .black),
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
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PreviewJobQuote(
                                              customerId:
                                                  int.parse(widget.customerId!),
                                              jobId: widget.jobId,
                                              projectId: widget.projectId,
                                            )));
                              },
                              child: SizedBox(
                                height: 40,
                                child: smallButton(context, 'PREVIEW',
                                    CustomColors.skyblue, 0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                String? userId =
                                    await _storageServices.getUserId();

                                AddQuoteResponse? model =
                                    await _remoteApi.addQuote(AddQuoteModel(
                                        userId: int.parse(userId!),
                                        customerId:
                                            int.parse(widget.customerId!),
                                        materialCost: extractNumericValue(_materialCost.text),
                                        labourCost: extractNumericValue(_labourCost.text),
                                        vat: changeValue(vatValue!),
                                        projectId: widget.projectId,
                                        projectTitle: _projectTitle.text,
                                        projectDescription:
                                            _projectDetails.text,
                                        jobId: widget.jobId,
                                        status: 'Create Quotes'));

                               /* if (model != null) {
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
                                }*/
                              },
                              child: SizedBox(
                                height: 40,
                                child: smallButton(
                                    context, 'SAVE', CustomColors.skyblue, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: smallButton(
                                  context, '', CustomColors.bodyColor, 0),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                String? userId =
                                    await _storageServices.getUserId();

                                AddQuoteResponse? model =
                                    await _remoteApi.addQuote(AddQuoteModel(
                                        userId: int.parse(userId!),
                                        customerId:
                                            int.parse(widget.customerId!),
                                        materialCost: extractNumericValue(_materialCost.text),
                                        labourCost: extractNumericValue(_labourCost.text),
                                        vat: changeValue(vatValue!),
                                        projectId: widget.projectId,
                                        projectTitle: _projectTitle.text,
                                        projectDescription:
                                            _projectDetails.text,
                                        jobId: widget.jobId,
                                        status: 'Create Quotes'));

                                if (model != null) {
                                  /*Fluttertoast.showToast(
                                      msg: model.message!,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);*/

                                  if (widget.projectId != null &&
                                      widget.jobId != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PreviewJobQuote(
                                          customerId:
                                              int.parse(widget.customerId!),
                                          projectId: widget.projectId,
                                          jobId: widget.jobId,
                                        ),
                                      ),
                                    );
                                  } else {
                                    /*Fluttertoast.showToast(
                                      msg: 'Missing jobId or projectId',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );*/
                                  }
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
                              child: SizedBox(
                                height: 40,
                                child: smallButton(context, 'SEND QUOTE',
                                    CustomColors.primeColour, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
