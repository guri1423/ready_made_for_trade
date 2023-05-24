

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/pages/icon_models/customer_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/appointment_setting.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../../../home/pages/icon_models/jobs_model.dart';

class ViewDetails extends StatefulWidget {
  DatumCustomer data;
   ViewDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
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
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [

              viewCustomerDetails(context, widget.data),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: customisedButton(context, 'CALL', CustomColors.blueButton, 'assets/images/Phone Icon.png')),

                  Expanded(child: customisedButton(context, 'EMAIL', CustomColors.blueButton, 'assets/images/Email Icon.png')),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: customisedButton(context, 'MESSAGE', CustomColors.blueButton, 'assets/images/whatsapp.png')),

                  Expanded(child: customisedButton(context, 'REMINDER', CustomColors.blueButton, 'assets/images/Book Appointment.png')),
                ],
              ),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddJobsPage(customerId: widget.data.id.toString(),)));
                  },
                  child: extraLongButton(context, 'START A NEW JOB')),

              SizedBox(height: 15,),


              Text('JOBS',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.primeColour)),




              viewCustomerJobs(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
    );
  }
}
