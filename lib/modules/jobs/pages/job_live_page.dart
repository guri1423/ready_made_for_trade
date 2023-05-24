

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';

class JobLivePage extends StatefulWidget {
  const JobLivePage({Key? key}) : super(key: key);

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
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Row(
                  children: [
                    Text('JOB #001 - JOB LIVE',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily:'Dongle',
                          color: CustomColors.blueButton,
                          fontWeight: FontWeight.bold
                      ),),
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
                            Text(  'MR JOHN SMITH',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith()),
                            const SizedBox(
                              height: 12,
                            ),
                            Text( "1 EXAMPLE LANE,\nSOUTHEND,\nESSEX,\nD50 HHD'",
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
                children: [
                  Text('Material - \$0',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily:'Dongle',
                        color: CustomColors.blueButton,
                        fontWeight: FontWeight.bold
                    ),),

                  Text('Labour - \$0',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily:'Dongle',
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
                      child: Text('Paid - \$0',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily:'Dongle',
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
                  GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewJobQuote()));
                      },
                      child: smallButton(context, 'PREVIEW', CustomColors.skyblue, 170)),
                  smallButton(context, 'SAVE', CustomColors.skyblue, 170),
                ],
              ),
              SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewJobQuote()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    smallButton(context, 'RESEND', CustomColors.blueButton, 170),
                    GestureDetector(

                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmJob()));
                        },
                        child: smallButton(context, 'SEND INVOICE', CustomColors.blueButton, 170)),

                  ],
                ),
              )






            ],
          ),
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
