import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/components/components.dart';
import 'package:taQs/core/constants.dart';
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

    logoController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        debugPrint(
            'in splash screen permissionsGranted is : $permissionsGranted');
        if (permissionsGranted == false || permissionsGranted == null) {
          debugPrint('Go to : PermissionScreen');
          NavigateAndFinish(context, PermissionScreen());
        } else if (permissionsGranted == true) {
          BlocProvider.of<AppCubit>(context)
              .GetCurrentWeatherByLatLng()
              .then((value) {
            debugPrint('Go to : HomeScreen');
            NavigateAndFinish(context, HomeScreen());
          }).catchError((error){
            debugPrint('error in GetCurrentWeatherByLatLng now in Splash Screen $error+');

          });
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
        // if (permissionsGranted == true) {
        //
        //   NavigateAndFinish(context, HomeScreen());
        // }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/weather.json',
                  controller: logoController,
                  onLoaded: (composition) {
                    logoController.forward();
                  },
                ),
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
