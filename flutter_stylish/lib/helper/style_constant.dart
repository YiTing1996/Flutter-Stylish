import 'package:flutter/material.dart';

const titleTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  fontSize: 16,
  height: 2,
);

const subtitleTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  fontSize: 14,
  height: 2,
);

const descTextStyle = TextStyle(
  fontWeight: FontWeight.w200,
  letterSpacing: 0.5,
  fontSize: 12,
  height: 2,
);

const secTitleTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

const secSubtitleTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
  fontSize: 12,
);

var defaultAppBar = AppBar(
    title: Image.asset(
      'assets/logo.png',
      width: 120,
      height: 120,
    ),
    iconTheme: const IconThemeData(color: Colors.black12),
    backgroundColor: Colors.white,
);
