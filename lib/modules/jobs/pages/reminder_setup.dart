

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/bottom_nav/view/bottom_navigation.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/dairy/pages/diary.dart';
import 'package:ready_made_4_trade/modules/gallery/models/project_response_model.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/add_reminder.dart';
import 'package:ready_made_4_trade/modules/jobs/models/appointment_models.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class ReminderSetup extends StatefulWidget {
  int? jobId;
  int? customerId;
  int? projectId;
  ReminderSetup({Key? key,  required this.jobId, required this.customerId, required this.projectId}) : super(key: key);

  @override
  State<ReminderSetup> createState() => _ReminderSetupState();
}

class _ReminderSetupState extends State<ReminderSetup> {


  final TextEditingController _year = TextEditingController();
  final TextEditingController _projectTitle = TextEditingController();
  final TextEditingController _projectDetails = TextEditingController();



  final RemoteApi _remoteApi = RemoteApi();
  final StorageServices _storageServices = StorageServices();



  @override
  void initState() {
    super.initState();

  }

  int? hoursValue;
  int? dateValue;
  int? monthValue;
  int? minutesValue;
  @override
  Widget build(BuildContext context) {


    ThemeData theme = Theme.of(context);
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
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric( vertical: 18, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: (){

                          Navigator.pop(context);

                        },
                        child: smallButton(context, 'DELETE', CustomColors.greyButton, 170)),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: GestureDetector(

                        onTap: ()async{
                         String? userId = await _storageServices.getUserId();
                         AddProjectResponse? model = await   _remoteApi.addReminder(AddReminderModel(userId: userId, customerId: widget.customerId.toString(),
                              date: dateValue.toString(), month: monthValue.toString(),
                              year: _year.text, hours: hoursValue.toString(),
                              minutes: minutesValue.toString(),
                              projectTitle: _projectTitle.text, projectDescription: _projectDetails.text,
                              jobId: widget.jobId.toString(), projectId: widget.projectId.toString()));


                         if(model != null){
                           Fluttertoast.showToast(
                               msg: model.message!,
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.CENTER,
                               timeInSecForIosWeb: 2,
                               backgroundColor: Colors.green,
                               textColor: Colors.white,
                               fontSize: 16.0);

                           Navigator.push(context,
                               MaterialPageRoute(builder: (context) =>  BottomNavigation()));

                         }

                         else{

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


                        child: smallButton(context, 'SAVE', CustomColors.blueButton, 170)),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            const BottomToolsForInsidePage(),
          ],
        ),
        body:  FutureBuilder<GetJobData?>(
          future: _remoteApi.getJobData(widget.jobId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {



              _projectTitle.text = snapshot.data!.data.projectTitle ?? _projectTitle.text;
              _projectDetails.text =
                  snapshot.data!.data.projectDescription ?? _projectDetails.text;


              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        GestureDetector(
                            onTap: (){


                            },
                            child: Icon(Icons.close_outlined)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'SERVICE REMINDER',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                color: CustomColors.blueButton,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'SET REMINDER',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                color: CustomColors.blueButton,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
                                    dateValue = value as int?;
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
                                value: monthValue,
                                onChanged: (value) {
                                  setState(() {
                                    monthValue = value as int?;
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
                                    hoursValue = value as int?;
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
                                    minutesValue = value as int?;
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

                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                Center(
                                  child: Text('   ${snapshot.data!.data.projectTitle!}',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.primeColour),),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              Flexible(  // Wrap the Text widget with Flexible
                                child: Text(
                                  '${snapshot.data!.data.projectDescription!}',
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.primeColour),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Somthing went Wrong'));
            }

            return const Center(child: SingleChildScrollView());
          },
        )



    );
  }
}
