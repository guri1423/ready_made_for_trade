import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/f_and_i/finance_insurance_cubit/finanace_insurance_cubit.dart';
import 'package:ready_made_4_trade/modules/f_and_i/widgets/finance_insurance_widgets.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class FAndIPage extends StatefulWidget {
  const FAndIPage({Key? key}) : super(key: key);

  @override
  State<FAndIPage> createState() => _FAndIPageState();
}

class _FAndIPageState extends State<FAndIPage> {
  final TextEditingController _search = TextEditingController();

  final RemoteApi _api = RemoteApi();

  String typeOfData = 'finance';

  @override
  void initState() {
    super.initState();

    BlocProvider.of<FinanaceInsuranceCubit>(context)
        .getFinanceInsuranceData(typeOfData);
  }

  @override
  Widget build(BuildContext context) {
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
                width: 8 * oneLogicalPixelInPhysicalPixels,
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
        bottomNavigationBar: BottomToolsForInsidePage(
          onBackPress: _search.text.isNotEmpty
              ? () {
                  BlocProvider.of<FinanaceInsuranceCubit>(context)
                      .getFinanceInsuranceData(typeOfData);
                }
              : null,
        ),
        body: BlocBuilder<FinanaceInsuranceCubit, FinanaceInsuranceState>(
          builder: (context, state) {
            if (state is FinanaceInsuranceSuccess) {
              return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                typeOfData = 'finance';
                                BlocProvider.of<FinanaceInsuranceCubit>(context)
                                    .getFinanceInsuranceData(typeOfData);
                              });
                            },
                            child: SizedBox(
                              height: 40,
                              child: smallButton(
                                  context,
                                  'FINANCE',
                                  typeOfData.contains('finance')
                                      ? CustomColors.skyblue
                                      : CustomColors.primeColour,
                                  0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                typeOfData = 'insurance';
                                BlocProvider.of<FinanaceInsuranceCubit>(context)
                                    .getFinanceInsuranceData(typeOfData);
                              });
                            },
                            child: SizedBox(
                              height: 40,
                              child: smallButton(
                                  context,
                                  'INSURANCE',
                                  typeOfData.contains('insurance')
                                      ? CustomColors.skyblue
                                      : CustomColors.primeColour,
                                  0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: customerSearchBarWidget(
                            context,
                            onTap: () {
                              BlocProvider.of<FinanaceInsuranceCubit>(context)
                                  .getFinanceInsuranceSearchData(
                                      _search.text, typeOfData);
                            },
                            hintText: 'Stocklists',
                            theme: Theme.of(context),
                            controller: _search,
                          ))
                        ],
                      ),
                    ),
                    /*Row(
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
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
                              buttonHeight: 49,
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
                              itemHeight:
                                  MediaQuery.of(context).size.height * 0.056,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Trade',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color:
                                              CustomColors.textFieldTextColour),
                                ),
                              ),
                              items: [],
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    viewFinanceAndInsurance(context, state.model!.data)
                  ]));
            }

            if (state is FinanaceInsuranceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FinanaceInsuranceFailure) {
              return const Center(child: Text('Something went wrong'));
            }

            if (state is FinanaceInsuranceSearchLoading) {
              debugPrint(state.toString());
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FinanaceInsuranceSearchSuccess) {
              debugPrint(state.toString());
              return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                typeOfData = 'finance';
                                BlocProvider.of<FinanaceInsuranceCubit>(context)
                                    .getFinanceInsuranceData(typeOfData);
                              });
                            },
                            child: SizedBox(
                              height: 40,
                              child: smallButton(
                                  context, 'FINANCE', CustomColors.skyblue, 0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                typeOfData = 'insurance';
                                BlocProvider.of<FinanaceInsuranceCubit>(context)
                                    .getFinanceInsuranceData(typeOfData);
                              });
                            },
                            child: SizedBox(
                              height: 40,
                              child: smallButton(context, 'INSURANCE',
                                  CustomColors.primeColour, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: customerSearchBarWidget(context,
                                  hintText: 'Search Contacts',
                                  theme: Theme.of(context),
                                  controller: _search, onTap: () {
                            BlocProvider.of<FinanaceInsuranceCubit>(context)
                                .getFinanceInsuranceSearchData(
                                    _search.text, typeOfData);
                          }))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
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
                              buttonHeight: 49,
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
                              itemHeight:
                                  MediaQuery.of(context).size.height * 0.056,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Trade',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color:
                                              CustomColors.textFieldTextColour),
                                ),
                              ),
                              items: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                    viewFinanceAndInsurance(context, state.model.data)
                  ]));
            }

            if (state is FinanaceInsuranceSearchFailure) {
              debugPrint(state.toString());
              return const Center(child: Text('Something went wrong'));
            }

            if (state is FinanaceInsuranceSearchEmpty) {
              debugPrint(state.toString());
              return const Center(child: Text('Data not found'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
