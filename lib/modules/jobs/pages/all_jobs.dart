import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/bloc/jobs_cubit.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/cofirm_job.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/create_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/invoice_paid.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/job_date_time_start.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/job_live_page.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/quote_sent.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class AllJobs extends StatefulWidget {
  String? status;

  AllJobs({Key? key, required this.status}) : super(key: key);

  @override
  State<AllJobs> createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  RemoteApi _remoteApi = RemoteApi();
  String? jobStatus;


  @override
  void initState() {
   jobStatus = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.white,
        elevation: 0,
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
              child: Image.asset('assets/images/updated_images/012-bell.png'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BlocProvider<JobsCubit>(
          create: (context) =>
              JobsCubit()..getAllJobsByStatus(widget.status.toString()),
          child: BlocBuilder<JobsCubit, JobsState>(
            builder: (context, state) {
              print(state);
              if (state is JobsDataByStatusLoaded) {
                return Column(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2(
                        decoration: const InputDecoration(
                          isDense: true,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        buttonHeight: 37,
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonDecoration: BoxDecoration(
                          color: CustomColors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: CustomColors.textFieldBorderColor,
                            width: 1,
                          ),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 15),
                        itemHeight: MediaQuery.of(context).size.height * 0.056,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        iconOnClick: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Status of Job',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: CustomColors.textFieldTextColour),
                          ),
                        ),
                        items: statusList
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    item.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: CustomColors.primeColour),
                                  ),
                                )))
                            .toList(),
                        onChanged: (val) {
                          jobStatus = val.toString();
                          BlocProvider.of<JobsCubit>(context)
                              .getAllJobsByStatus(val.toString());
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.jobData.data.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              navigateUserBasedOnStatus(
                                  context: context,
                                  status: jobStatus!,
                                  customerId:
                                      state.jobData.data[index].customerId ??
                                          '',
                                  jobId: state.jobData.data[index].id ?? 0,
                                  projectId:
                                      state.jobData.data[index].projectId ?? 0);
                            },
                            child: viewCustomerJobs(
                                context, state.jobData.data[index], index),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              if (state is JobsFailure) {
                return const Center(child: Text('Something went wrong'));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
    );
  }
}

List<String> statusList = [
  'Appointment Set',
  'Confirm Start Date',
  'Create Quotes',
  'Deposit Paid',
  'Quote Sent',
  'Deposit Requested',
  'Final Invoice Paid',
  'Live Job',
  'Send Final Invoice',
  'Job Complete'
];

void navigateUserBasedOnStatus({
  required BuildContext context,
  required String status,
  required String customerId,
  required int jobId,
  required int projectId,
}) {
  switch (status) {
    case 'Appointment Set':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateQuote(
                    customerId: customerId,
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
    case 'Confirm Start Date':
     /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmJob(
                customerId: int.tryParse(customerId),
                jobId: jobId,
              )));*/
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JobLivePage(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                  )));
      break;
    case 'Create Quotes':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuoteSent(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
    case 'Deposit Paid':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmJob(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                  )));
      break;
    case 'Quote Sent':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JobStartDateTime(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
    case 'Deposit Requested':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmJob(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
    case 'Final Invoice Paid':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoicePaid(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
    case 'Live Job':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JobLivePage(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
    case 'Send Final Invoice':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoicePaid(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
    case 'Job Complete':
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoicePaid(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
                  )));
      break;
  }
}
