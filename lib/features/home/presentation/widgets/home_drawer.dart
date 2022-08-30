import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/core/components/components.dart';
import 'package:taQs/features/current_weather/data/local/models/current_weather.dart';
import 'package:taQs/features/home/presentation/home_screen.dart';
import 'package:taQs/features/permission/permission_screen.dart';

class HomeDrawer extends StatelessWidget {
  final CurrentWeather? currentWidget;

  HomeDrawer({
    Key? key,
    this.currentWidget,
  }) : super(key: key);

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
                    leading: Icon(Icons.home_filled),
                    title: Text(
                      'Home',
                    ),
                    onTap: () {
                      NavigateAndFinish(context, HomeScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text(
                      'Search By City',
                    ),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.star_border),
                    title: Text(
                      'Favourite Locations',
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      'Forecast Report',
                    ),
                    onTap: () {},
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
                    onTap: () async {
                       await BlocProvider.of<AppCubit>(context)
                          .GetCurrentWeatherByLatLng();
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
