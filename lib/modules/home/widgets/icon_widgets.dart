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
                Text('ACTIVE JOBS: ${data[index].status}',
                    style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('PENDING JOBS: 3', style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('COMPLETED JOBS JOBS: 5',
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
        const SnackBar(content: Text('Customer details edited successfully')));
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

Widget customerSearchResult(context, List<DatumCustomer>? data, int index) {
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
                Text('ACTIVE JOBS: ${data[index].status}',
                    style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('PENDING JOBS: 3', style: theme.textTheme.titleSmall),
                const SizedBox(
                  height: 2,
                ),
                Text('COMPLETED JOBS JOBS: 5',
                    style: theme.textTheme.titleSmall),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.delete_forever_outlined,
              color: CustomColors.white,
              size: 30.0,
            )
          ],
        ),
      ),
    ),
  );
}

Widget viewCustomerJobs(context) {
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
                  child: Image.asset('assets/images/home-icon-silhouette.png')),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Title', style: theme.textTheme.titleLarge),
                SizedBox(
                  height: 5,
                ),
                Text('Address', style: theme.textTheme.titleSmall),
                Text('ACTIVE JOBS: ', style: theme.textTheme.titleSmall),
                Text('PENDING JOBS: 3', style: theme.textTheme.titleSmall),
                Text('COMPLETED JOBS JOBS: 5',
                    style: theme.textTheme.titleSmall),
              ],
            ),
            Icon(
              Icons.delete_forever_outlined,
              color: CustomColors.white,
              size: 24.0,
            )
          ],
        ),
      ),
    ),
  );
}

Widget viewCustomerDetails(context, DatumCustomer data) {
  ThemeData theme = Theme.of(context);
  return Container(
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
              SizedBox(
                width: 220,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mr ${data.firstName} ${data.lastName}',
                          softWrap: true, style: theme.textTheme.titleLarge),
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
                  child: Image.asset('assets/images/Edit Customer.png'))
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
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CustomColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset('assets/images/support.png'),
                )),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '${data[index].title!} ${data[index].firstName} ${data[index].lastName!}',
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
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CustomColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset('assets/images/support.png'),
                )),
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
                    child: Image.asset('assets/images/support.png')),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mr ${tradeData.firstName} ${tradeData.lastName}',
                        style: theme.textTheme.titleLarge),
                    SizedBox(
                      height: 10,
                    ),
                    Text('"${tradeData.nickname!}"',
                        style: theme.textTheme.titleSmall),
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
            ],
          ),
        ],
      ),
    ),
  );
}
