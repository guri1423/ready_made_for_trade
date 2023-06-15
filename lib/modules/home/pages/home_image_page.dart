import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/modules/home/bloc/home_image/home_image_cubit.dart';
import 'package:ready_made_4_trade/modules/home/model/home_image_model.dart';

class HomePageImages extends StatelessWidget {
  const HomePageImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeImageCubit>(
      create: (context) => HomeImageCubit()..loadImage(),
      child: BlocBuilder<HomeImageCubit, HomeImageState>(
        builder: (context, state) {
          if (state is HomeImageLoaded) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                // '${state.homeImage.data.id}',
                '${state.homeImage.data.filePath}/${state.homeImage.data.image}',
                fit: BoxFit.fill,
              ),
            );
          }
          if (state is HomeImageFailure) {
            return const Center(child: Text('Something went wrong'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
