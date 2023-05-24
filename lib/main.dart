import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/theme.dart';
import 'package:ready_made_4_trade/modules/customer/search_cubit/customer_search_cubit.dart';
import 'package:ready_made_4_trade/modules/essentials/bloc/essential_bloc_cubit.dart';
import 'package:ready_made_4_trade/modules/f_and_i/finance_insurance_cubit/finanace_insurance_cubit.dart';
import 'package:ready_made_4_trade/modules/home/bloc_home/home_cubit.dart';
import 'package:ready_made_4_trade/modules/login/pages/login.dart';
import 'package:ready_made_4_trade/modules/material/bloc/material_cubit.dart';
import 'package:ready_made_4_trade/modules/receipts/bloc/receipts_cubit.dart';
import 'package:ready_made_4_trade/modules/trades/search_cubit/search_trades_cubit.dart';
import 'package:ready_made_4_trade/modules/trainings/bloc/training_cubit.dart';

import 'modules/bottom_nav/cubit/navigation_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(
            create: (_) => NavigationCubit(),
          ),
          BlocProvider<SearchTradesCubit>(
            create: (_) => SearchTradesCubit(),
          ),
          BlocProvider<CustomerSearchCubit>(
            create: (_) => CustomerSearchCubit(),
          ),
          BlocProvider<FinanaceInsuranceCubit>(
            create: (_) => FinanaceInsuranceCubit(),
          ),
          BlocProvider<MaterialCubit>(
            create: (_) => MaterialCubit(),
          ),
          BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(),
          ),
          BlocProvider<EssentialBlocCubit>(
            create: (_) => EssentialBlocCubit(),
          ),
          BlocProvider<TrainingCubit>(
            create: (_) => TrainingCubit(),
          ),
          BlocProvider<ReceiptsCubit>(
            create: (_) => ReceiptsCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'ready_made',
          debugShowCheckedModeBanner: false,
          theme: CustomThemes.getTheme(),
          home: Login(),
        ));
  }
}
