import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color? color,
  required String text,
  required void Function() function,
  bool isUpperCase = true,
  var padding = EdgeInsets.zero,
}) =>
    Padding(
      padding: padding,
      child: Container(
        width: width,
        height: 40.0,
        child: MaterialButton(
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: function,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.indigo,
        ),
      ),
    );

void NavigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

Widget defaultTextButton({
  required Function()? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );

void showLoading(BuildContext context) {
  showDialog(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Container(
          height: 100,
          width: 100,
          child: Center(
            child: Column(
              children: [
                Text(
                  'Please Wait',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showError(BuildContext context, String error) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Container(
          height: 100,
          width: 100,
          child: Center(
            child: Text(error),
          ),
        ),
      );
    },
  );
}

// void showToast({
//   required String message,
//   bool isShort = false,
// }) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       // backgroundColor: Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
