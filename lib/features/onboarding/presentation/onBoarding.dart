// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:taQs/bloc/app_cubit.dart';
// import 'package:taQs/bloc/app_cubit.dart';
// import 'package:taQs/bloc/app_cubit.dart';
// import 'package:taQs/bloc/app_cubit.dart';
// import 'package:taQs/bloc/app_cubit.dart';
// import 'package:taQs/bloc/app_state.dart';
// import 'package:taQs/core/components/components.dart';
// import 'package:taQs/core/services/network/local/cache_helper.dart';
// import 'package:taQs/features/home/presentation/home_screen.dart';
// import 'package:taQs/features/onboarding/data/models/boarding_model.dart';
//
// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }
//
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//
//   var boardingController = PageController();
//   bool isLast = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   void submit() {
//     CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
//       if (value) {
//         NavigateAndFinish(
//           context,
//           const HomeScreen(),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//
//         List<BoardingModel> boardingList = [
//           BoardingModel(
//             image: 'assets/images/m_c_q.png',
//             title: "Multiple Choice Questions",
//             body:"Provides Multiple Choice Questions",
//           ),
//           BoardingModel(
//             image: 'assets/images/to_easy.jpg',
//             title: "Too Many Questions",
//             body: "Many questions in various fields",
//           ),
//           BoardingModel(
//             image: 'assets/images/calc.png',
//             title: "calculate your score",
//             body: "calculate your score and get your rank"),
//
//         ];
//
//         return Scaffold(
//           appBar: AppBar(
//             elevation: 0.0,
//             title: AdvancedSwitch(
//               controller: BlocProvider.of<AppCubit>(context).switchController,
//               activeColor: Colors.deepPurpleAccent,
//               activeChild: const Text('en'),
//               inactiveColor: Colors.indigo.shade400,
//               inactiveChild: const Text('ar'),
//               enabled: true,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   submit();
//                 },
//                 child: const Text(
//                   'SKIP',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: Colors.indigo,
//           body: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: Column(
//               children: [
//                 Expanded(
//                     child: PageView.builder(
//                   itemBuilder: (context, index) =>
//                       buildBoardingItem(boardingList[index]),
//                   controller: boardingController,
//                   physics: const BouncingScrollPhysics(),
//                   onPageChanged: (int index) {
//                     if (index == boardingList.length - 1) {
//                       setState(() {
//                         isLast = true;
//                       });
//                     } else {
//                       setState(() {
//                         isLast = false;
//                       });
//                     }
//                   },
//                   itemCount: boardingList.length,
//                 )),
//                 const SizedBox(
//                   height: 50.0,
//                 ),
//                 Row(
//                   children: [
//                     SmoothPageIndicator(
//                       controller: boardingController,
//                       effect: const ExpandingDotsEffect(
//                         dotColor: Colors.white,
//                         activeDotColor: Colors.deepOrange,
//                         dotWidth: 10,
//                         dotHeight: 10,
//                         expansionFactor: 4,
//                         spacing: 5,
//                       ),
//                       count: boardingList.length,
//                     ),
//                     const Spacer(),
//                     FloatingActionButton(
//                       backgroundColor: Colors.white,
//                       onPressed: () {
//                         if (isLast == true) {
//                           submit();
//                         } else {
//                           boardingController.nextPage(
//                             duration: const Duration(milliseconds: 750),
//                             curve: Curves.fastOutSlowIn,
//                           );
//                         }
//                       },
//                       child: Icon(
//                         Icons.arrow_forward_ios,
//                         color: mainColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
