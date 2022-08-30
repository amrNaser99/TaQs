import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/colors.dart';
import 'package:taQs/core/components/components.dart';
import 'package:taQs/core/constants.dart';
import 'package:taQs/features/home/presentation/home_screen.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  initState()  {
    super.initState();
     BlocProvider.of<AppCubit>(context)
        .GetCurrentWeatherByLatLng()
        .then((value) {
      debugPrint('GetCurrentWeatherByLatLng Success');
    }).catchError((error) {
      debugPrint('GetCurrentWeatherByLatLng Error : ${error.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is TaqsGetCurrentWeatherSuccessState ||
            permissionsGranted == true && BlocProvider.of<AppCubit>(context).currentWeather != null) {
          NavigateAndFinish(context, HomeScreen());
        }
        // else if (state is TaqsGetPositionLoadingState ||
        //     state is TaqsEnableLocationLoadingState ||
        //     state is TaqsGetCurrentWeatherLoadingState ||
        //     state is TaqsGetCacheDataLoadingState) {
        //   showLoading(context);
        // }
        else if (state is TaqsGetPositionErrorState) {
          showError(context, state.error);
        } else if (state is TaqsEnableLocationSuccessState && permissionsGranted == true){
          BlocProvider.of<AppCubit>(context).GetCurrentWeatherByLatLng();
        }
      },
      builder: (context, state) {

        return SafeArea(
          child: Scaffold(
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      child: Lottie.asset(
                        'assets/background_weather.json',
                      ),
                    ),
                    PositionedDirectional(
                      top: 10,
                      end: 10,
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: IconButton(
                          onPressed: () {
                            NavigateTo(
                              context,
                              HomeScreen(),
                            );
                          },
                          icon: Text(
                            'SKIP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 200,
                      end: 10,
                      start: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'We Want Use Location Permission to Show Your Location Weather',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: colorWhite,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConditionalBuilder(
                                condition:
                                    state is! TaqsEnableLocationLoadingState,
                                builder: (context) {
                                  if (permissionsGranted == false) {
                                    return MaterialButton(
                                      color: Colors.blueAccent[400],
                                      textColor: Colors.white,
                                      elevation: 10,
                                      padding: EdgeInsetsDirectional.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<AppCubit>(context)
                                            .enableLocation();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                          ),
                                          Text(
                                            'Enable Permission',
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Text(
                                        '--You Have Permission To Use Location--');
                                  }
                                },
                                fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
