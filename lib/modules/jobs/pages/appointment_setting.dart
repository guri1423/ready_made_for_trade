import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
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

import '../widgets/sound_playing.dart';
import '../widgets/sound_recorder.dart';

class AddJobsPage extends StatefulWidget {
  String? customerId;
  DatumCustomer? model;

  AddJobsPage({Key? key, required this.customerId, this.model})
      : super(key: key);

  @override
  State<AddJobsPage> createState() => _AddJobsPageState();
}

class _AddJobsPageState extends State<AddJobsPage> {
  dynamic validationTxtField(value) {
    if (value.isEmpty) {
      return "Field is mandatory";
    } else {
      return null;
    }
  }

  dynamic validationDropField(value) {
    if (value == null) {
      return "Field is mandatory";
    } else {
      return null;
    }
  }

  final TextEditingController _projectTitle = TextEditingController();
  final TextEditingController _projectDetails = TextEditingController();

  final RemoteApi _remoteApi = RemoteApi();
  final StorageServices _storageServices = StorageServices();

  final recorder = SoundRecorder();
  final player = SoundPlayer();

  @override
  void initState() {
    recorder.init();
    player.init();
    super.initState();
  }

  @override
  void dispose() {
    recorder.dispose();
    player.dispose();
    super.dispose();
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
          GestureDetector(
            onTap: () async {
              String? user_id = await _storageServices.getUserId();

              AddAppointmentResponse? model =
              await _remoteApi.addAppointment(AddAppointmentModel(
                userId: user_id,
                customerId: widget.customerId,
                projectTitle: _projectTitle.text,
                projectDescription: _projectDetails.text,
                status: 'Appointment Set',
                fullDate:
                BlocProvider.of<PickupDateCubit>(context).getPickupDate(),
                fullTime:
                BlocProvider.of<PickupTimeCubit>(context).getPickupTime(),
              ));

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
                        builder: (context) => CreateQuote(
                          projectId: model.appointmentId,
                          jobId: model.jobId,
                          customerId: widget.customerId,
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
          physics:const NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreateQuote(customerId: widget.customerId)));
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
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 45,
              child: customTextFieldForm(context,
                  controller: _projectTitle, hintText: 'Project Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            /* SizedBox(
                  height: 200,
                  child: customTextFieldForm(context,
                      controller: _projectDetails,
                      hintText: 'Project Details'),
              ),*/
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: _projectDetails,
              validator: (value) {
                return validationTxtField(value);
              },
              maxLines: 10,
              style: TextStyle(color: CustomColors.primeColour, fontSize: 12),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                /* contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),*/
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: CustomColors.textFieldTextColour,
                      width: 1,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: CustomColors.textFieldTextColour,
                      width: 1,
                    )),
                hintStyle: TextStyle(
                    fontSize: 12, color: CustomColors.textFieldTextColour),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: CustomColors.textFieldTextColour,
                      width: 1,
                    )),
                hintText: "Product Details",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.multiline,
            ),
            Container(
              height: MediaQuery.of(context).size.height *0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  micbutton(),
                  SizedBox(
                    width: 20,
                  ),
                  playbutton(),
                  SizedBox(
                    width: 20,
                  ),
                  // ElevatedButton(onPressed: (){

                  // },
                  // child: CircleAvatar(
                  //       backgroundColor: CustomColors.blueButton,
                  //       radius: 25,
                  //       child: Icon(
                  //         Icons.delete,
                  //         size: 35,
                  //       )), )
                  deletebutton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget micbutton() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final primary = isRecording ? Colors.red : CustomColors.blueButton;
    final onprimary = isRecording ? Colors.white : Colors.white;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primary,
          onPrimary: onprimary,
          fixedSize: const Size(50, 50),
          shape: const CircleBorder(),
        ),
        onPressed: () async {
          final isRecording = await recorder.toggleRecording();
          setState(() {});
          print(isRecording);
        },
        child: Icon(icon));
  }

  Widget playbutton() {
    final isPlaying = player.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final primary = isPlaying ? Colors.red : CustomColors.blueButton;
    final onprimary = isPlaying ? Colors.white : Colors.white;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primary,
          onPrimary: onprimary,
          fixedSize: const Size(50, 50),
          shape: const CircleBorder(),
        ),
        onPressed: () async {
          await player.togglePlaying(whenFinished: () => setState(() {}));
          setState(() {});
        },
        child: Icon(icon));
  }

  Widget deletebutton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: CustomColors.blueButton,
          onPrimary: Colors.white,
          fixedSize: const Size(50, 50),
          shape: const CircleBorder(),
        ),
        onPressed: () async {
          var res=await  recorder.delete();
          if(res){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(
                  child: Text(
                    "Recording Deleted Successfully",
                  ),
                )));
            setState(() {});
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(
                  child: Text(
                    "Yet Not Any Recording Recorded",
                  ),
                )));
            setState(() {});
          }

        },
        child: Icon(Icons.delete));
  }
}
