import 'package:flutter/material.dart';

abstract final class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF202020);
  static const charcoal = Color(0xFF313131);
  static const mutedText = Color(0xFF7B7676);
  static const referralText = Color(0xFFCECECE);
  static const brandGreen = Color(0xFF5BC98B);
  static const discountGreen = Color(0xFF00725B);
  static const readyPink = Color(0xFFE785C4);
  static const glass = Color(0x63313131);
  static const productGlass = Color(0x63BBBBBB);
  static const overlay = Color(0x73000000);
  static const inactiveIndicator = Color(0x99FFFFFF);
  static const loadingTrack = Color(0xFFD8D8D8);

  static const postScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0x002F2F2F), Color(0x992F2F2F), Color(0xCC2F2F2F)],
    stops: <double>[0, 0.54, 1],
  );

  static const assistantGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF62D5A2), Color(0xFF2BAF78)],
  );
}
