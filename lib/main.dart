import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/theme.dart';
import 'package:ready_made_4_trade/modules/account/cubit/edit_website_text/edit_website_text_cubit.dart';
import 'package:ready_made_4_trade/modules/account/cubit/get_a_website/get_a_website_cubit.dart';
import 'package:ready_made_4_trade/modules/account/cubit/setup_company/setup_company_info_cubit.dart';
import 'package:ready_made_4_trade/modules/account/cubit/upload_logo/upload_logo_cubit.dart';
import 'package:ready_made_4_trade/modules/bottom_nav/view/bottom_navigation.dart';
import 'package:ready_made_4_trade/modules/check_list/cubit/check_list_cubit.dart';
import 'package:ready_made_4_trade/modules/customer/search_cubit/customer_search_cubit.dart';
import 'package:ready_made_4_trade/modules/dairy/bloc/dairy_cubit.dart';
import 'package:ready_made_4_trade/modules/essentials/bloc/essential_bloc_cubit.dart';
import 'package:ready_made_4_trade/modules/f_and_i/finance_insurance_cubit/finanace_insurance_cubit.dart';
import 'package:ready_made_4_trade/modules/home/bloc_home/home_cubit.dart';
import 'package:ready_made_4_trade/modules/login/pages/login.dart';
import 'package:ready_made_4_trade/modules/material/bloc/material_cubit.dart';
import 'package:ready_made_4_trade/modules/receipts/bloc/receipts_cubit.dart';
import 'package:ready_made_4_trade/modules/trades/search_cubit/search_trades_cubit.dart';
import 'package:ready_made_4_trade/modules/trainings/bloc/training_cubit.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/date_picker.dart';
import 'package:ready_made_4_trade/widgets/time_picker.dart';

import 'modules/bottom_nav/cubit/navigation_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
          BlocProvider<SetupCompanyInfoCubit>(
            create: (_) => SetupCompanyInfoCubit(),
          ),
          BlocProvider<SearchTradesCubit>(
            create: (_) => SearchTradesCubit(),
          ),
          BlocProvider<EditWebsiteTextCubit>(
            create: (_) => EditWebsiteTextCubit(),
          ),
          BlocProvider<CustomerSearchCubit>(
            create: (_) => CustomerSearchCubit(),
          ),
          BlocProvider<FinanaceInsuranceCubit>(
            create: (_) => FinanaceInsuranceCubit(),
          ),
          BlocProvider<CheckListCubit>(
            create: (_) => CheckListCubit(),
          ),
          BlocProvider<MaterialCubit>(
            create: (_) => MaterialCubit(),
          ),
         /* BlocProvider<WebSiteCubit>(
            create: (_)=> WebSiteCubit(),
          ),*/

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
          BlocProvider<PickupDateCubit>(
            create: (_) => PickupDateCubit(),
          ),
          BlocProvider<PickupTimeCubit>(
            create: (_) => PickupTimeCubit(),
          ),
          BlocProvider<DairyCubit>(
            create: (_) => DairyCubit(),
          ),
          BlocProvider<UploadLogoCubit>(
            create: (_) => UploadLogoCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'ready_made',
          debugShowCheckedModeBanner: false,
          theme: CustomThemes.getTheme(),
          home: SplashPage(),
        ));
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final StorageServices _servicesStorage = StorageServices();

  getUserLoggedInStatus() async {
    String? status = await _servicesStorage.getLoggedInStatus();
    if (status != null && status.contains('true')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavigation()));
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitCircle(
        color: CustomColors.primeColour,
        size: 50.0,
      )),
    );
  }
}
