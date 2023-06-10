import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/customers.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/bloc/jobs_cubit.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/all_jobs.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 55,
          elevation: 0,
          backgroundColor: Colors.white,
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
                child: Image.asset('assets/images/02 Notification.png'),
              ),
            ],
          ),
        ),
        bottomNavigationBar:  BottomToolsForInsidePage(
            onBackPress: (){
              Navigator.pop(context);
              /*BlocProvider.of<SearchTradesCubit>(context).getTrades();*/
            }
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomersPage(
                          isComingFromJob: true,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: extraLongButton(context, 'ADD A NEW JOB'),
                  ),
                ),
                const SizedBox(height: 15),
                BlocProvider<JobsCubit>(
                  create: (BuildContext context) => JobsCubit()..loadAllJobs(),
                  child: BlocBuilder<JobsCubit, JobsState>(
                    builder: (BuildContext context, JobsState state) {
                      if (state is JobsLoaded) {
                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.jobStatus.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllJobs(
                                              status: state
                                                  .jobStatus.data[index].title,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: extraLongButton(context,
                                          state.jobStatus.data[index].title!),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: extraLongButton(context,
                                          state.jobStatus.data[index].noCount!),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (state is JobsFailure) {
                        return const Center(
                            child: Text('Something went wrong'));
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
