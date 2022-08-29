import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/end_point.dart';
import 'package:taQs/features/current_weather/data/local/models/current_weather.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        CurrentWeather? currentWeather = cubit.currentWeather;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              cubit.currentWeather!.name.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Text(
                          "${DateFormat.yMMMd().format(DateTime.now())}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(currentWeather!.main!.temp! - 273.15).round().toString()} °C',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${(currentWeather.main!.tempMax! - 273.15).round().toString()}°C / ${(currentWeather.main!.tempMin! - 273.15).round().toString()}°C',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      currentWeather.weather![0].description!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            Image.network(
                              IconLink +
                                  currentWeather.weather![0].icon! +
                                  '.png',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                            // Icon(Icons.sunny, color: Colors.white, size: 60),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[900]?.withOpacity(0.3),
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Sunrise',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  // format sunset time
                                  Text(
                                    '${DateTime.fromMillisecondsSinceEpoch(currentWeather.sys!.sunrise! * 1000).hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(currentWeather.sys!.sunrise! * 1000).minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Lottie.asset(
                                    'assets/sunrise.json',
                                    height: 60,
                                    width: 60,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Sunset',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  // format sunset time
                                  Text(
                                    '${DateTime.fromMillisecondsSinceEpoch(currentWeather.sys!.sunset! * 1000).hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(currentWeather.sys!.sunset! * 1000).minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Lottie.asset(
                                    'assets/sunset.json',
                                    height: 60,
                                    width: 60,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[900]?.withOpacity(0.3),
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Wind',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                currentWeather.wind!.speed!.toString() + ' m/s',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Humidity',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                currentWeather.main!.humidity!.toString() +
                                    ' %',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[900]?.withOpacity(0.3),
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsetsDirectional.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Wind',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                currentWeather.wind!.speed!.toString() + ' m/s',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Humidity',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                currentWeather.main!.humidity!.toString() +
                                    ' %',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
