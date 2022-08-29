import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/core/components/components.dart';
import 'package:taQs/features/current_weather/data/local/models/current_weather.dart';
import 'package:taQs/features/permission/permission_screen.dart';

class HomeDrawer extends StatelessWidget {
  final CurrentWeather? currentWidget;

  HomeDrawer({Key? key, this.currentWidget,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Image.asset('assets/images/TaQs-logos__white.png'),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      'Settings',
                    ),
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<AppCubit>(context)
                                .GetCurrentWeatherByQue();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Favorite location',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.error_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            NavigateTo(context, PermissionScreen());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Permissions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.headphones),
                    title: Text(
                      'Contact Us',
                    ),
                    onTap: () {
                      AppCubit.get(context)
                          .GetCurrentWeatherByLatLng(lat: currentWidget?.coord?.lat, lon: currentWidget?.coord?.lng);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
