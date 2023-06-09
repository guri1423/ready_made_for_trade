import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/pages/icon_models/customer_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/appointment_models.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/create_quote.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:ready_made_4_trade/widgets/date_picker.dart';
import 'package:ready_made_4_trade/widgets/time_picker.dart';

class AddJobsPage extends StatefulWidget {
  String? customerId;
  DatumCustomer? model;

  AddJobsPage({Key? key, required this.customerId, this.model})
      : super(key: key);

  @override
  State<AddJobsPage> createState() => _AddJobsPageState();
}

class _AddJobsPageState extends State<AddJobsPage> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _time = TextEditingController();
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
          toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
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
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                String? user_id = await _storageServices.getUserId();

                AddAppointmentResponse? model =
                    await _remoteApi.addAppointment(AddAppointmentModel(
                  userId: user_id,
                  customerId: widget.customerId,
                  projectTitle: _projectTitle.text,
                  projectDescription: _projectDetails.text,
                  status: 'Appointment Set', fullDate: BlocProvider.of<PickupDateCubit>(context).getPickupDate(),
                      fullTime: BlocProvider.of<PickupTimeCubit>(context).getPickupTime(),

                ));

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
                          builder: (context) => CreateQuote(
                                projectId: model.appointmentId,
                                jobId: model.jobId,
                                customerId: widget.customerId,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: extraLongButton(context, 'CREATE QUOTE'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const BottomToolsForInsidePage(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateQuote(
                                    customerId: widget.customerId)));
                      },
                      child: Icon(Icons.close_outlined)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'APPOINTMENT SETTING',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          color: CustomColors.blueButton,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  const [
                  Expanded(child: CustomDatePicker()),
                  SizedBox(width: 10,),
                  Expanded(child: CustomTimePicker())
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 40,
                child: customTextFieldForm(context,
                    controller: _projectTitle, hintText: 'Project Title'),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 200,
                  child: customTextFieldForm(context,
                      controller: _projectDetails,
                      hintText: 'Project Details')),
            ],
          ),
        ));
  }
}
