

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/modules/home/pages/icon_models/jobs_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
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

    const SizedBox sizedBox = SizedBox(height: 8);

    ThemeData theme = Theme.of(context);

    return Scaffold(


      appBar: AppBar(
        toolbarHeight: 150 * oneLogicalPixelInPhysicalPixels,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 8 * oneLogicalPixelInPhysicalPixels,
            ),
            SizedBox(
              width: 135,
              height: 45,
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

        child: Container(
          height: MediaQuery.of(context).size.height, // or specify a fixed height
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                FutureBuilder<JobsModel?>(
                  future: _remoteApi.getJobsOnStatusBasis(widget.status),
                  builder: (BuildContext context, AsyncSnapshot<JobsModel?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return viewCustomerJobs(context, snapshot.data!.data![index], index);
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

      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
    );
  }
}
