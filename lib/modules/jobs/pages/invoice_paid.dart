
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/dairy/pages/diary.dart';
import 'package:ready_made_4_trade/modules/home/pages/home.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/models/appointment_models.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/appointment_setting.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/preview_after_deposit.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/reminder_setup.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class InvoicePaid extends StatefulWidget {
  int? jobId;
  int? customerId;
  int? projectId;
 InvoicePaid({Key? key, required this.jobId, required this.customerId, required this.projectId, this.isComingFromReceipt = false}) : super(key: key);

  final bool isComingFromReceipt;

  @override
  State<InvoicePaid> createState() => _InvoicePaidState();
}

class _InvoicePaidState extends State<InvoicePaid> {

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint(widget.isComingFromReceipt.toString());
      if (widget.isComingFromReceipt) {
        setReminder(context);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.titleSmall!.copyWith();
    return Scaffold(
        backgroundColor: CustomColors.backgroundColour,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              'JOB #${snapshot.data!.data.quoteId} - INVOICE PAID',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Dongle Regular',
                                  color: CustomColors.blueButton,
                                  fontWeight: FontWeight.bold),
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
                                            padding: const EdgeInsets.all(20.0),
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
                                              snapshot
                                                  .data!.data.customerName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith()),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                              snapshot.data!.data.address!,
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
                      Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration:  BoxDecoration(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Material - \£${snapshot.data!.data.materialCost!}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
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

                          Column(
                            children: [
                              if(snapshot.data!.data.isVat! == '1' )
                                Text(
                                  'Total INC VAT - \£${snapshot.data!.data.totalIncVat!}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Dongle Regular',
                                      color: CustomColors.blueButton,
                                      fontWeight: FontWeight.bold),
                                ) else  Text(
                                'Total - \£${snapshot.data!.data.totalPrice!}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),

                              SizedBox(height: 10,),

                              Text(
                                'Paid - \£${snapshot.data!.data.depositAmount!}                 ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Dongle Regular',
                                    color: CustomColors.blueButton,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),


                        ],
                      ),




                      const SizedBox(
                        height: 20,
                      ),



                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            GestureDetector(
                                onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewAfterDeposit(
                                      jobId: widget.jobId, customerId: widget.customerId, projectId: widget.customerId,isComingFromInvoicePaid: true,)));

                                },
                                child: smallButton(context, 'SEND RECEIPT',
                                    CustomColors.blueButton, 170)),

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
        )
    );
  }

  Future<void> setReminder(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: Container(
            width: 600,
            decoration: BoxDecoration(
              color: CustomColors.primeColour,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('SET A SERVICE REMINDER',
                        style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.white,
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),

                  SizedBox(height: 100,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: ()async{

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ReminderSetup(customerId: widget.customerId,
                              jobId: widget.jobId, projectId: widget.projectId,)));

                          },
                          child: smallButton(context, 'YES', CustomColors.greyButton, 100)),
                      GestureDetector(
                          onTap: (){

                            Navigator.pop(context);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  HomePage()));
                          },
                          child: smallButton(context, 'NO', CustomColors.yellow, 100)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
