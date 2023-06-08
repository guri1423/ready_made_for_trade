import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/view_customer_details.dart';
import 'package:ready_made_4_trade/modules/customer/search_cubit/customer_search_cubit.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/appointment_setting.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../../../../../services/remote_api.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key, this.isComingFromJob = false})
      : super(key: key);

  final bool isComingFromJob;

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final RemoteApi apiServices = RemoteApi();

  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CustomerSearchCubit>(context).getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 8 ,
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
      bottomNavigationBar: BottomToolsForInsidePage(
        onBackPress: _search.text.isNotEmpty
            ? () {
                _search.clear();
                BlocProvider.of<CustomerSearchCubit>(context).getCustomer();
              }
            : null,
      ),
      body: BlocBuilder<CustomerSearchCubit, CustomerSearchState>(
        builder: (context, state) {
          if (state is CustomerSuccess) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddCustomerPage()));
                            },
                            child: Image.asset(
                              'assets/images/updated_images/add-friend 1.png',
                              height: 35,
                              width: 35,
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: customerSearchBarWidget(context,
                                hintText: 'Search Contacts',
                                theme: theme,
                                controller: _search, onTap: () {
                          BlocProvider.of<CustomerSearchCubit>(context)
                              .searchCustomer(_search.text);
                        }))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.model!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                if (widget.isComingFromJob) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddJobsPage(
                                                customerId: state
                                                    .model!.data[index].id
                                                    .toString(),
                                                model: state.model!.data[index],
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewDetails(
                                              data: state.model!.data[index])));
                                }
                              },
                              child: customerPage(
                                  context, state.model!.data, index));
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          if (state is CustomerSearchSuccess) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddCustomerPage()));
                            },
                            child: Image.asset(
                              'assets/images/updated_images/add-friend 1.png',
                              height: 35,
                              width: 35,
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: customerSearchBarWidget(
                          context,
                          onTap: () {
                            BlocProvider.of<CustomerSearchCubit>(context)
                                .searchCustomer(_search.text);
                          },
                          hintText: 'Search Contacts',
                          theme: theme,
                          controller: _search,
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.model!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                if (widget.isComingFromJob) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddJobsPage(
                                              customerId: state
                                                  .model!.data[index].id!
                                                  .toString())));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewDetails(
                                              data: state.model!.data[index])));
                                }
                              },
                              child: customerSearchResult(
                                  context, state.model!.data, index));
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          if (state is CustomerSearchEmpty) {
            return const Center(child: Text('No result found'));
          }

          if (state is CustomerEmpty) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddCustomerPage()));
                            },
                            child: Image.asset(
                              'assets/images/updated_images/add-friend 1.png',
                              height: 35,
                              width: 35,
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: customerSearchBarWidget(context,
                                hintText: 'Search Contacts',
                                theme: theme,
                                controller: _search, onTap: () {
                          BlocProvider.of<CustomerSearchCubit>(context)
                              .searchCustomer(_search.text);
                        }))
                      ],
                    ),
                  ),
                  const Center(child: Text('No Customer Data Available')),
                ],
              ),
            );
          }

          if (state is CustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
