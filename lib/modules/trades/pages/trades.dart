import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/home/widgets/icon_widgets.dart';
import 'package:ready_made_4_trade/modules/trades/pages/add_trades.dart';
import 'package:ready_made_4_trade/modules/trades/pages/trade_details.dart';
import 'package:ready_made_4_trade/modules/trades/search_cubit/search_trades_cubit.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class TradesPage extends StatefulWidget {
  const TradesPage({Key? key}) : super(key: key);

  @override
  State<TradesPage> createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage> {
  final TextEditingController _searchTrades = TextEditingController();

  final RemoteApi apiServices = RemoteApi();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchTradesCubit>(context).getTrades();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
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
              child: Image.asset('assets/images/02 Notification.png'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomToolsForInsidePage(
        onBackPress: () {
          BlocProvider.of<SearchTradesCubit>(context).getTrades();
        },
      ),
      body: BlocBuilder<SearchTradesCubit, SearchTradesState>(
        builder: (context, state) {
          if (state is TradesSuccess) {
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
                                          const AddTradesPage()));
                            },
                            child: Image.asset(
                              'assets/images/add-friend.png',
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
                            BlocProvider.of<SearchTradesCubit>(context)
                                .searchTrades(_searchTrades.text);
                          },
                          hintText: 'Search Contacts',
                          theme: theme,
                          controller: _searchTrades,
                        ))
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
                                style: theme.textTheme.titleMedium!.copyWith(
                                    color: CustomColors.textFieldTextColour),
                              ),
                            ),
                            items: [],
                          ),
                        ),
                      ),
                    ],
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TradeDetails(
                                            tradeData:
                                                state.model!.data[index])));
                              },
                              child:
                                  tradePage(context, state.model!.data, index));
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          if (state is TradesFailure) {
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
                                          const AddTradesPage()));
                            },
                            child: Image.asset(
                              'assets/images/add-friend.png',
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
                            BlocProvider.of<SearchTradesCubit>(context)
                                .searchTrades(_searchTrades.text);
                          },
                          hintText: 'Search Contacts',
                          theme: theme,
                          controller: _searchTrades,
                        ))
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
                                style: theme.textTheme.titleMedium!.copyWith(
                                    color: CustomColors.textFieldTextColour),
                              ),
                            ),
                            items: [],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(child: Text('No Trades Available')),
                ],
              ),
            );
          }

          if (state is SearchTradesSuccess) {
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
                                          const AddTradesPage()));
                            },
                            child: Image.asset(
                              'assets/images/add-friend.png',
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
                            BlocProvider.of<SearchTradesCubit>(context)
                                .searchTrades(_searchTrades.text);
                          },
                          hintText: 'Search Contacts',
                          theme: theme,
                          controller: _searchTrades,
                        ))
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
                                style: theme.textTheme.titleMedium!.copyWith(
                                    color: CustomColors.textFieldTextColour),
                              ),
                            ),
                            items: [],
                          ),
                        ),
                      ),
                    ],
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TradeDetails(
                                            tradeData:
                                                state.model!.data[index])));
                              },
                              child: searchTradeResult(
                                  context, state.model!.data, index));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SearchTradesEmpty) {
            return Column(
              children: [
                const Center(child: Text('No Result Found')),
              ],
            );
          }
          if (state is TradesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
