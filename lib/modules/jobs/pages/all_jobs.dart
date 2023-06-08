import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/modules/home/pages/icon_models/jobs_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/create_quote.dart';
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

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FutureBuilder<JobsModel?>(
          future: _remoteApi.getJobsOnStatusBasis(widget.status),
          builder: (BuildContext context, AsyncSnapshot<JobsModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.data.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      navigateUserBasedOnStatus(
                          context: context,
                          status: widget.status ?? '',
                          customerId:
                              snapshot.data!.data[index].customerId ?? '',
                          jobId: snapshot.data!.data[index].id ?? 0,
                          projectId: snapshot.data!.data[index].projectId ?? 0);
                    },
                    child: viewCustomerJobs(
                        context, snapshot.data!.data[index], index),
                  );
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
    );
  }
}

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
              builder: (context) => JobStartDateTime(
                    customerId: int.tryParse(customerId),
                    jobId: jobId,
                    projectId: projectId,
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
  }
}
