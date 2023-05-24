

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';

class ConfirmJob extends StatefulWidget {
  int? jobId;
   ConfirmJob({Key? key, required this.jobId}) : super(key: key);

  @override
  State<ConfirmJob> createState() => _ConfirmJobState();
}

class _ConfirmJobState extends State<ConfirmJob> {




  final TextEditingController _date = TextEditingController();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _dateEnd = TextEditingController();
  final TextEditingController _monthEnd = TextEditingController();
  final TextEditingController _yearEnd = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _timeEnd = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  RemoteApi _remoteApi = RemoteApi();
  StorageServices _storageServices = StorageServices();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10,),
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

        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CustomColors.backgroundColour,


          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              SizedBox(height: 10,),

              Text('CONFIRM JOB #001',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily:'Dongle',
                    color: CustomColors.blueButton,
                    fontWeight: FontWeight.bold
                ),),

              SizedBox(height: 15,),

              Text('JOB START DATE',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily:'Dongle',
                    color: CustomColors.blueButton,
                    fontWeight: FontWeight.bold
                ),),

              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  textField(context, _date , 'DD', 55, 50),

                  textField(context, _month , 'MM', 55, 50),

                  textField(context, _year , 'YY', 50, 50),

                  textField(context, _time , '00:00', 80, 50),


                  smallButton(context, 'Save', CustomColors.blueButton, 90)


                ],
              ),

              SizedBox(height: 40,),

              Text('JOB END DATE',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily:'Dongle',
                    color: CustomColors.blueButton,
                    fontWeight: FontWeight.bold
                ),),

              SizedBox(height: 15,),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  textField(context, _dateEnd , 'DD', 55, 50),

                  textField(context, _monthEnd , 'MM', 55, 50),

                  textField(context, _yearEnd , 'YY', 50, 50),

                  textField(context, _timeEnd , '00:00', 80, 50),


                  smallButton(context, 'Save', CustomColors.blueButton, 90)


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

                       /* onTap: ()async{

                          JobAgreeResponse? model = await  _remoteApi.confirmJob(JobAgreedModel(jobId: widget.jobId, jobStartDate: _date.text,
                              jobStartMonth: _month.text, jobStartYear: _year.text, jobEndDate: _dateEnd.text,
                              jobEndMonth: _monthEnd.text, jobEndYear: _yearEnd.text, depositAmount: '221',
                              jobStartTime: , jobEndTime: _timeEnd.text));

                          debugPrint('model print${model!.toJson().toString()}');


                          if(model != null){
                            Fluttertoast.showToast(
                                msg: model.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);


                            Navigator.push(context, MaterialPageRoute(builder: (context)=> JobLivePage()));


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



                        },*/





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
