import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/model/add_customer_model.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/edit_customer.dart';
import 'package:ready_made_4_trade/modules/customer/search_cubit/customer_search_cubit.dart';
import 'package:ready_made_4_trade/modules/trades/models/get_all_trades_model.dart';
import 'package:ready_made_4_trade/modules/trades/models/search_trades_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

import '../pages/icon_models/customer_model.dart';
import '../pages/icon_models/jobs_model.dart';

Widget customerPage(context, List<DatumCustomer>? data, int index) {
  RemoteApi _api = RemoteApi();

  ThemeData theme = Theme.of(context);
  TextStyle style = const TextStyle(
      fontSize: 10,
      fontFamily: 'Dongle',
      color: Colors.white,
      fontWeight: FontWeight.w600);
  return Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColors.primeColour,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
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
                Text('${data![index].title!} ${data[index].lastName}',
                    style: theme.textTheme.titleLarge),
                const SizedBox(
                  height: 8,
                ),
                Text(data[index].address!, style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('ACTIVE JOBS: ${data[index].statusCounts!.confirmJob}',
                    style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('PENDING JOBS: ${data[index].statusCounts!.createQuotes}',
                    style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text(
                    'COMPLETED JOBS JOBS: ${data[index].statusCounts!.sendFinalInvoice}',
                    style: theme.textTheme.titleSmall),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                await handlingOnTap(_api, data, index, context);
              },
              child: const Icon(
                Icons.delete_forever_outlined,
                color: CustomColors.white,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Future<void> handlingOnTap(
    RemoteApi _api, List<DatumCustomer> data, int index, context) async {
  AddCustomerResponse? status =
      await _api.deleteCustomer(data[index].id!.toString());

  if (status!.status == true) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer details deleted successfully')));
    BlocProvider.of<CustomerSearchCubit>(context).getCustomer();
  } else {
    Fluttertoast.showToast(
        msg: status.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}


Future<void> deleteJobs(
    RemoteApi _api, JobsDatum data, int index, context) async {
  AddCustomerResponse? status =

  await _api.deleteJob(data.id.toString());

  if (status!.status == true) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer details deleted successfully')));

  } else {
    Fluttertoast.showToast(
        msg: status.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

Widget customerSearchResult(context, List<DatumCustomer>? data, int index) {
  RemoteApi _api = RemoteApi();
  ThemeData theme = Theme.of(context);
  TextStyle style = const TextStyle(
      fontSize: 10,
      fontFamily: 'Dongle',
      color: Colors.white,
      fontWeight: FontWeight.w600);
  return Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColors.primeColour,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
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
                Text('${data![index].title!} ${data[index].lastName}',
                    style: theme.textTheme.titleLarge),
                const SizedBox(
                  height: 8,
                ),
                Text(data[index].address!, style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('ACTIVE JOBS: ${data[index].statusCounts!.confirmJob}',
                    style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('PENDING JOBS: ${data[index].statusCounts!.createQuotes}',
                    style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text(
                    'COMPLETED JOBS JOBS: ${data[index].statusCounts!.sendFinalInvoice}',
                    style: theme.textTheme.titleSmall),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                await handlingOnTap(_api, data, index, context);
              },
              child: const Icon(
                Icons.delete_forever_outlined,
                color: CustomColors.white,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget viewCustomerJobs(context, JobsDatum data, int index) {
  RemoteApi _api = RemoteApi();
  ThemeData theme = Theme.of(context);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColors.blueButton,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors.white,
                  ),
                  child: Image.asset('assets/images/home-icon-silhouette.png')),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(data.projectTitle != null ? data.projectTitle! : '',
                      style: theme.textTheme.titleLarge),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    data.jobStartFullDate != null
                        ? 'Job start date -${data.jobStartFullDate.toString()}'
                        : '',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                deleteJobs(_api, data, index, context);
              },
              child: Icon(
                Icons.delete_forever_outlined,
                color: CustomColors.white,
                size: 24.0,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget viewCustomerDetails(context, DatumCustomer data) {
  ThemeData theme = Theme.of(context);
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.blueButton,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.white,
                        ),
                        child: Image.asset('assets/images/user.png')),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mr ${data.firstName} ${data.lastName}',
                              softWrap: true,
                              style: theme.textTheme.titleLarge),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${data.emailAddress}\n' '${data.mobileNumber} ',
                              style: theme.textTheme.titleSmall),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${data.address}',
                              style: theme.textTheme.titleSmall),
                          Text('${data.postCode}',
                              style: theme.textTheme.titleSmall),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditCustomerPage(
                                      model: data,
                                    )));
                      },
                      child: SizedBox(
                          height: 35,
                          width: 40,
                          child: Image.asset(
                              'assets/images/small_icons/002-editing.png')))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('1', style: theme.textTheme.titleLarge),
                      Text('PENDING', style: theme.textTheme.titleSmall),
                    ],
                  ),
                  Column(
                    children: [
                      Text('1', style: theme.textTheme.titleLarge),
                      Text('DEPOSITS', style: theme.textTheme.titleSmall),
                    ],
                  ),
                  Column(
                    children: [
                      Text('1', style: theme.textTheme.titleLarge),
                      Text('ACTIVE', style: theme.textTheme.titleSmall),
                    ],
                  ),
                  Column(
                    children: [
                      Text('1', style: theme.textTheme.titleLarge),
                      Text('COMPLETED', style: theme.textTheme.titleSmall),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget tradePage(context, List<DatumTrade> data, int index) {
  ThemeData theme = Theme.of(context);

  return Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColors.blueButton,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                        'assets/images/updated_images/Materials 1.png'),
                  )),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '${data[index].title!} ${data[index].firstName} ${data[index].lastName!}',
                    style: theme.textTheme.titleMedium),
                const SizedBox(
                  height: 2,
                ),
                Text('"${data[index].nickname}"',
                    style: theme.textTheme.titleMedium),
                const SizedBox(
                  height: 4,
                ),
                Text(data[index].trades!,
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.normal)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget searchTradeResult(context, List<DatumTrade> data, int index) {
  ThemeData theme = Theme.of(context);

  return Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColors.blueButton,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                        'assets/images/updated_images/Materials 1.png'),
                  )),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '${data[index].title} ${data[index].firstName} ${data[index].lastName}',
                    style: theme.textTheme.titleLarge),
                const SizedBox(
                  height: 2,
                ),
                Text('${data[index].nickname}',
                    style: theme.textTheme.titleLarge),
                const SizedBox(
                  height: 4,
                ),
                Text(data[index].trades!, style: theme.textTheme.titleMedium),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget tradeDetails(context, DatumTrade tradeData) {
  ThemeData theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
        color: CustomColors.blueButton,
        borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                          'assets/images/updated_images/Materials 1.png'),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mr ${tradeData.firstName} ${tradeData.lastName}',
                          style: theme.textTheme.titleLarge),
                      SizedBox(
                        height: 10,
                      ),
                      Text('"${tradeData.nickname!}"',
                          style: theme.textTheme.titleLarge),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          '${tradeData.emailAddress!} \n ${tradeData.mobileNumber} ',
                          style: theme.textTheme.titleSmall),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${tradeData.trades}',
                          style: theme.textTheme.titleSmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
