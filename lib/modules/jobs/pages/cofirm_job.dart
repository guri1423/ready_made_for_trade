

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/job_agreed_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';

import 'job_live_page.dart';

class ConfirmJob extends StatefulWidget {
  int? jobId;
  int? customerId;
  int? projectId;
   ConfirmJob({Key? key, required this.jobId, required this.customerId, this.projectId}) : super(key: key);

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

        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CustomColors.backgroundColour,


          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text('CONFIRM JOB #001',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.blueText)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
                    },
                    child: const Icon(
                      Icons.close_outlined,
                      size: 30,
                      color: CustomColors.primeColour,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),

              Text('JOB START DATE',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.blueText),),

              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'DD',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: endDateValue,
                          onChanged: (value) {
                            setState(() {
                              endDateValue = value as int;
                            });
                          },
                          items: dateList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 60,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'MM',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: endMonthValue,
                          onChanged: (value) {
                            setState(() {
                              endMonthValue = value as int;
                            });
                          },
                          items: monthList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      height: 40,
                      width: 60,
                      child: customTextFieldForm(
                          context,
                          controller: _yearEnd, hintText: 'YYYY')),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 60,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
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
                              'hrs',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: endHoursValue,
                          onChanged: (value) {
                            setState(() {
                              endHoursValue = value as int?;
                            });
                          },
                          items: hoursList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 65,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 10),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'mins',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: endMinutesValue,
                          onChanged: (value) {
                            setState(() {
                              endMinutesValue = value as int;
                            });
                          },
                          items: minuteList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  /* const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: smallButton(
                          context, 'SAVE', CustomColors.blueButton, 0))*/
                ],
              ),

              SizedBox(height: 40,),

              Text('JOB END DATE',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.blueText),),

              SizedBox(height: 15,),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'DD',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: dateValue,
                          onChanged: (value) {
                            setState(() {
                              dateValue = value as int;
                            });
                          },
                          items: dateList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 60,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
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
                              'MM',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: monthValue,
                          onChanged: (value) {
                            setState(() {
                              monthValue = value as int;
                            });
                          },
                          items: monthList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      height: 40,
                      width: 60,
                      child: customTextFieldForm(
                          context,
                          controller: _year, hintText: 'YYYY')),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 60,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
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
                              'hrs',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: hoursValue,
                          onChanged: (value) {
                            setState(() {
                              hoursValue = value as int;
                            });
                          },
                          items: hoursList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 65,
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
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 10),
                          itemHeight: MediaQuery.of(context).size.height * 0.056,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'mins',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: minutesValue,
                          onChanged: (value) {
                            setState(() {
                              minutesValue = value as int;
                            });
                          },
                          items: minuteList
                              .map((item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  item.toString(),
                                  style:
                                  TextStyle(color: CustomColors.blackText),
                                ),
                              )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  /* const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: smallButton(
                          context, 'SAVE', CustomColors.blueButton, 0))*/
                ],
              ),





              Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: (){

                          Navigator.pop(context);

                        },
                        child: smallButton(context, 'DELETE', CustomColors.greyButton, 170)),

                    GestureDetector(

                        onTap: ()async{

                          JobAgreeResponse? model = await  _remoteApi.confirmJob(JobAgreedModel(jobId: widget.jobId, jobStartDate: dateValue.toString(),
                              jobStartMonth: monthValue.toString(), jobStartYear: _year.text, jobEndDate: endDateValue.toString(),
                              jobEndMonth: endMonthValue.toString(), jobEndYear: _yearEnd.text,
                              jobStartHours: hoursValue.toString(), jobStartMinutes: minutesValue.toString(),
                              jobEndHours: endHoursValue.toString(), jobEndMinutes: endMinutesValue.toString(), status: 'Confirm Start Date',
                              depositAmount: '600'));

                          debugPrint('model print${model!.toJson().toString()}');


                          if(model != null){
                            /*Fluttertoast.showToast(
                                msg: model.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);*/


                            Navigator.push(context, MaterialPageRoute(builder: (context)=> JobLivePage(
                              customerId: widget.customerId, jobId: widget.jobId,
                            )));


                          }

                          else{

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





                        child: smallButton(context, 'SAVE & SEND', CustomColors.blueButton, 170)),

                  ],
                ),
              )




            ],
          ),
        )


    );
  }
}
