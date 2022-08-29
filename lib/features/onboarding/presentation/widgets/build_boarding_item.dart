
import 'package:flutter/material.dart';
import 'package:taQs/features/onboarding/data/models/boarding_model.dart';

Widget buildBoardingItem(BoardingModel model) => Container(
  height: 100.0,
  color: Colors.indigo,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image!),
        ),
      ),
      const SizedBox(
        height: 40.0,
      ),
      Text(
        model.title!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        model.body!,
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 20.0,
        ),
      ),
    ],
  ),
);
