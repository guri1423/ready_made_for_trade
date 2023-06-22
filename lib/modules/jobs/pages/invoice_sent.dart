

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/preview_job_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/widgets/job_widgets.dart';

class InvoiceSent extends StatefulWidget {

  int? jobId;
  int? projectId;
  int? customerId;
  InvoiceSent({Key? key, required this.jobId, required this.projectId, required this.customerId}) : super(key: key);

  @override
  State<InvoiceSent> createState() => _InvoiceSentState();
}

class _InvoiceSentState extends State<InvoiceSent> {



  TextEditingController _materialCost = TextEditingController();
  TextEditingController _labourCost = TextEditingController();
  TextEditingController _vat = TextEditingController();
  TextEditingController _totalPrice = TextEditingController();
  TextEditingController _projectTitle = TextEditingController();
  TextEditingController _projectDetails = TextEditingController();
  TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
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
          color: Colors.grey.shade300,


        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: Row(
                children: [
                  Text('JOB #001 - DEPOSIT PAID',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily:'Dongle Regular',
                        color: CustomColors.blueButton,
                        fontWeight: FontWeight.bold
                    ),),
                ],
              ),
            ),

            // viewJobQuote(context,),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: textField(context, _projectTitle ,'Project Title', MediaQuery.of(context).size.width, 50),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: textField(context, _projectDetails ,'Project Details', MediaQuery.of(context).size.width, 100),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text('Material - \£5,000',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily:'Dongle Regular',
                      color: CustomColors.blueButton,
                      fontWeight: FontWeight.bold
                  ),),

                Text('Labour - \£5,000',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily:'Dongle Regular',
                      color: CustomColors.blueButton,
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),

            SizedBox(height: 10,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textField(context, _materialCost , 'Material Cost', 170, 50),
                textField(context, _labourCost , 'Labour Cost', 170, 50),
              ],
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textField(context, _vat , 'VAT', 170, 50),
                textField(context, _totalPrice , 'Total Price', 170, 50),
              ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                GestureDetector(
                    onTap: (){
                      dialogBox(context);
                    },
                    child: smallButton(context, 'ADD PAYMENT', CustomColors.blueButton, 170)),

                const SizedBox(
                  height: 50,
                  width: 170,
                  child: Center(
                    child: Text('Paid - \£5,000',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily:'Dongle Regular',
                          color: CustomColors.blueButton,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewJobQuote(
                        customerId: widget.customerId!,
                        jobId: widget.jobId,projectId: widget.projectId,)));
                    },
                    child: smallButton(context, 'PREVIEW', CustomColors.skyblue, 170)),
                smallButton(context, 'SAVE', CustomColors.skyblue, 170),
              ],
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewJobQuote(
                  customerId: widget.customerId!,
                  jobId: widget.jobId,projectId: widget.projectId,)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  smallButton(context, 'RESEND', CustomColors.blueButton, 170),
                  smallButton(context, 'INVOICE PAID', CustomColors.blueButton, 170),

                ],
              ),
            )






          ],
        ),
      ),

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
                  children: const [
                    Text('PAYMENT',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily:'Dongle Regular',
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
                    smallButton(context, 'SAVE', CustomColors.greyButton, 100),
                    smallButton(context, 'DELETE', CustomColors.yellow, 100),
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
