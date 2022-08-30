import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taQs/bloc/app_cubit.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/bloc_observer.dart';
import 'package:taQs/core/services/network/local/cache_helper.dart';
import 'package:taQs/core/services/network/remote/dio_helper.dart';
import 'core/app_themes.dart';
import 'features/splash/presentation/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  await CacheHelper.getCacheData().then((value) {
    debugPrint('CacheData Loaded Successfully');
  });
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaQs',
            themeMode: ThemeMode.light,
            theme: lightTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
