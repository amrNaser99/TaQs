import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/colors.dart';
import 'package:taQs/features/home/presentation/widgets/home_body.dart';
import 'package:taQs/features/home/presentation/widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        return AdvancedDrawer(
          backdropColor: Colors.blue[900],
          controller: cubit.advancedDrawerController,
          childDecoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(20),
            ),
          ),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8.0,
                ),
                child: IconButton(
                    onPressed: () {
                      cubit.advancedDrawerController.showDrawer();
                    },
                    icon: Image.asset(
                      'assets/images/menu_icon.png',
                      color: colorPrimary,
                    )),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: HomeBody(),
            ),
          ),
          drawer: HomeDrawer(currentWidget: cubit.currentWeather),
        );
      },
    );
  }
}
