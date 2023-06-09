

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/gallery/models/project_response_model.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/invoice_paid.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/preview_after_deposit.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

class JobLivePage extends StatefulWidget {
  int? customerId;
  int? jobId;
  int? projectId;

  JobLivePage({Key? key, required this.customerId, required this.jobId, this.projectId }) : super(key: key);



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

      body: FutureBuilder<GetJobData?>(
        future: _remoteApi.getJobData(widget.jobId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            vatValue = snapshot.data!.data.vat ?? vatValue;

            _projectTitle.text = snapshot.data!.data.projectTitle ?? _projectTitle.text;
            _projectDetails.text =
                snapshot.data!.data.projectDescription ?? _projectDetails.text;
            _vat.text = snapshot.data!.data.vat ?? _vat.text;
            _materialCost.text = snapshot.data!.data.materialCost ?? _materialCost.text;
            _labourCost.text = snapshot.data!.data.labourCost ?? _labourCost.text;

            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('JOB #${snapshot.data!.data.quoteId} - JOB LIVE',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold
                              ),),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: CustomColors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Image.asset('assets/images/user.png'),
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(  snapshot.data!.data.customerName!,
                                            style: Theme.of(context).textTheme.titleLarge!.copyWith()),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text( snapshot.data!.data.address!,
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith()),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Image.asset('assets/images/Phone Icon.png',height: 25,width: 25,),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset('assets/images/Book Appointment.png',height: 25,width: 25,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Text('Show Costs on quote',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Dongle',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
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


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Material - \$${snapshot.data!.data.materialCost}',
                          style: TextStyle(
                              fontSize: 16,
                              color: CustomColors.blueButton,
                              fontWeight: FontWeight.bold
                          ),),

                        Text('Labour - \$${snapshot.data!.data.labourCost}',
                          style: TextStyle(
                              fontSize: 16,

                              color: CustomColors.blueButton,
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),


                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [


                        if(snapshot.data!.data.isVat! == '1' )
                          Text(
                            'Total INC VAT - \$${snapshot.data!.data.totalIncVat!}',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Dongle Regular',
                                color: CustomColors.blueButton,
                                fontWeight: FontWeight.bold),
                          ) else  Text(
                          'Total - \$${snapshot.data!.data.totalPrice!}',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Dongle Regular',
                              color: CustomColors.blueButton,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text('          ',
                          style: TextStyle(
                              fontSize: 16,

                              color: CustomColors.blueButton,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    SizedBox(height: 20,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        GestureDetector(
                            onTap: (){
                              dialogBox(context);
                            },
                            child: smallButton(context, 'ADD PAYMENT', CustomColors.blueButton, 170)),

                        SizedBox(
                          height: 50,
                          width: 170,
                          child: Center(
                            child: Text('Paid - \$${snapshot.data!.data.depositAmount ?? '0'}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Expanded(
                          child: GestureDetector(
                              onTap: (){

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewAfterDeposit(jobId: widget.jobId, customerId: widget.customerId, projectId: widget.customerId)));
                              },
                              child: smallButton(context, 'PREVIEW', CustomColors.skyblue, 170)),
                        ),

                        SizedBox(width: 20,),

                        if(int.parse(snapshot.data!.data.depositAmount ?? '0') <= int.parse(snapshot.data!.data.totalPrice!) )

                          Expanded(
                            child: GestureDetector(

                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewAfterDeposit(jobId: widget.jobId, customerId: widget.customerId, projectId: widget.customerId)));
                                },
                                child: smallButton(context, 'SEND INVOICE', CustomColors.blueButton, 170)),
                          ) else  Expanded(
                            child: GestureDetector(

                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> InvoicePaid(jobId: widget.jobId, customerId: widget.customerId, projectId: widget.customerId)));
                              },
                              child: smallButton(context, 'FINAL INVOICE', CustomColors.blueButton, 170)),
                          )

                      ],
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
      )





    );
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
                    Text('PAYMENT',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily:'Dongle',
                          color: CustomColors.blueButton,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textField(context, _totalPrice, 'Total Price', 120, 50),
                    textField(context, _date, 'DD/MM/YY', 120, 50),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: ()async{
                          AddProjectResponse? model = await  _remoteApi.addPayment(_totalPrice.text, widget.jobId.toString(), 'Deposit Paid',_date.text);

                          if(model != null){
                            Fluttertoast.showToast(
                                msg: model.message!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.pop(context);
                            setState(() {

                            });

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
                        child: smallButton(context, 'SAVE', CustomColors.greyButton, 100)),
                    GestureDetector(
                        onTap: (){
                          _totalPrice.clear();
                          _date.clear();
                          Navigator.pop(context);

                          setState(() {

                          });
                        },
                        child: smallButton(context, 'DELETE', CustomColors.yellow, 100)),
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
