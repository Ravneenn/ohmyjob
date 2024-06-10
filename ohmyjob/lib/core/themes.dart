import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  fontFamily: "Quicksand",
  colorScheme:
      ColorScheme.fromSeed(background: Colors.black, seedColor: Colors.red),
);

final lightTheme = FlexThemeData.light(
    scheme: FlexScheme.aquaBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: "QuickSand");

final darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.aquaBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: "QuickSand");
