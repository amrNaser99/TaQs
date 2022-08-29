// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:taQs/core/constants.dart';
// import 'package:taQs/core/services/network/local/cache_helper.dart';
//
// class PermissionHandler {
//   static Future<void> appPermission() async {
//
//     Map<Permission, PermissionStatus> permissions = await [
//       Permission.location,
//     ].request();
//
//     var permissionsGranted = permissions[Permission.location]!.isGranted;
//
//     if (permissionsGranted == true) {
//       debugPrint('permissionsGranted Successfully');
//       CacheHelper.saveData(key: 'permissionsGranted', value: permissionsGranted)
//           .then((value) {
//         print('permissionsGranted Cached Successfully');
//       }).catchError((error) {
//         print('permissionsGranted  failed to Cached : $error');
//       });
//     }
//   }
// }
