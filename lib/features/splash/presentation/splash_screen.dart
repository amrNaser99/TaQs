import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/components/components.dart';
import 'package:taQs/features/home/presentation/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:taQs/features/permission/permission_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController logoController;

  @override
  void initState() {
    super.initState();

    // AppCubit.get(context).GetCurrentWeatherByLatLng(lat: AppCubit().position?.latitude.toString(), lon: AppCubit().position?.longitude.toString());

    logoController = AnimationController(
    duration: Duration(seconds: 1),
    vsync: this,
    );

    logoController.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
    debugPrint(
    'in splash screen permissionsGranted : ${BlocProvider.of<AppCubit>(context).permissionsGranted}');
    if (BlocProvider.of<AppCubit>(context).permissionsGranted == false) {
    NavigateAndFinish(context, PermissionScreen());
    } else {
    NavigateAndFinish(context, HomeScreen());
    }
    }
    });
  }

  @override
  void dispose() {
    super.dispose();
    logoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {


      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFFf0e9fc),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/weather.json', controller: logoController,
                    onLoaded: (composition) {
                      logoController.forward();
                    }),
                Text(
                  'TaQs',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
