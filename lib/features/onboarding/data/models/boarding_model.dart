import 'package:lottie/lottie.dart';

class BoardingModel {
  final String? image;
  final Lottie? lottieFile;
  final String? title;
  final String? body;

  BoardingModel({
    this.image,
    this.lottieFile,
    required this.title,
    required this.body,
  });
}
