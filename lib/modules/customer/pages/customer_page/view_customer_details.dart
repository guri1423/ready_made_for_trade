

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/pages/icon_models/customer_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/appointment_setting.dart';
import 'package:ready_made_4_trade/modules/login/widgets/login_widget.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../home/pages/icon_models/jobs_model.dart';

class ViewDetails extends StatefulWidget {
  DatumCustomer data;
   ViewDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {


  RemoteApi _remoteApi = RemoteApi();

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    const SizedBox sizedBox = SizedBox(height: 8);

    ThemeData theme = Theme.of(context);
    return Scaffold(


      appBar: AppBar(
        toolbarHeight: 200 * oneLogicalPixelInPhysicalPixels,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 8 * oneLogicalPixelInPhysicalPixels,
            ),
            SizedBox(
              width: 160,
              height: 75,
              child: Image.asset(
                'assets/images/final Logo.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/images/updated_images/012-bell.png'),
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
                  Expanded(child: GestureDetector(
                      onTap: () async{

                         launchPhoneCall();
                        // final Uri url = Uri(
                        //   scheme: 'tel',
                        //   path: widget.data.mobileNumber
                        // );
                        //
                        // if( await canLaunchUrl(url)){
                        //   await launchUrl(url);
                        // }
                        // else{
                        //   print('cannot launch url');
                        // }


                      },
                      child: customisedButton(context, 'CALL', CustomColors.blueButton, 'assets/images/small_icons/005-phone-call.png'))),

                  SizedBox(width: 30,),

                  Expanded(child: GestureDetector(
                      onTap: ()async{

                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: widget.data.emailAddress,
                        );

                        await launch(emailUri.toString());

                      },
                      child: customisedButton(context, 'EMAIL', CustomColors.blueButton, 'assets/images/small_icons/001-email.png'))),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: customisedButton(context, 'MESSAGE', CustomColors.blueButton, 'assets/images/small_icons/031-whatsapp.png')),

                  SizedBox(width: 30,),

                  Expanded(child: customisedButton(context, 'REMINDER', CustomColors.blueButton, 'assets/images/small_icons/004-appointment.png')),
                ],
              ),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddJobsPage(customerId: widget.data.id.toString(),)));
                  },
                  child: customisedButton(context, 'START A NEW JOB', CustomColors.blueButton, 'assets/images/small_icons/003-add.png' )),

              SizedBox(height: 15,),


              Text('JOBS',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.primeColour)),




          FutureBuilder<JobsModel?>(
            future: _remoteApi.getJobsOnCustomerBasis(widget.data.id.toString()),
            builder: (BuildContext context, AsyncSnapshot<JobsModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData && snapshot.data != null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height *0.40,
                  child: ListView.builder(
                    itemCount: snapshot.data!.data.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return viewCustomerJobs(context, snapshot.data!.data[index], index);
                    },
                  ),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
    );
  }
  void launchPhoneCall() async {
    const phoneNumber = 'tel:12345678909';
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    await launch(telUri.toString());
  }
}
