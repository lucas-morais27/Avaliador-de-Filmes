import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromRGBO(23, 23, 23, 1.0),
  primaryContainer: Color.fromRGBO(218, 0, 55, 1.0),
  onPrimary: Color.fromRGBO(218, 0, 55, 1.0),
  onPrimaryContainer: Color.fromRGBO(237, 237, 237, 1.0),
  secondary: Color.fromRGBO(68, 68, 68, 1.0),
  secondaryContainer: Color.fromRGBO(237, 237, 237, 1.0),
  onSecondary: Color.fromRGBO(237, 237, 237, 1.0),
  onSecondaryContainer: Color.fromRGBO(68, 68, 68, 1.0),
  tertiary: Color(0xFF745470),
  tertiaryContainer: Color(0xFFFFD6F7),
  onTertiary: Color(0xFFFFFFFF),
  onTertiaryContainer: Color(0xFF2B122A),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  outline: Color(0xFF767680),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF1B1B1F),
  surface: Color(0xFFFEFBFF),
  onSurface: Color(0xFF1B1B1F),
  surfaceVariant: Color(0xFFE2E1EC),
  onSurfaceVariant: Color(0xFF45464F),
  inverseSurface: Color(0xFF303034),
  onInverseSurface: Color(0xFFF2F0F4),
  inversePrimary: Color(0xFFB5C4FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF405AA9),
  outlineVariant: Color(0xFFC6C6D0),
  scrim: Color(0xFF000000),
);

const primary95 = Color(0xFFEFF0FF);

const darkColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromRGBO(23, 23, 23, 1.0),
  primaryContainer: Color.fromRGBO(218, 0, 55, 1.0),
  onPrimary: Color.fromRGBO(218, 0, 55, 1.0),
  onPrimaryContainer: Color.fromRGBO(237, 237, 237, 1.0),
  secondary: Color.fromRGBO(68, 68, 68, 1.0),
  secondaryContainer: Color.fromRGBO(237, 237, 237, 1.0),
  onSecondary: Color.fromRGBO(237, 237, 237, 1.0),
  onSecondaryContainer: Color.fromRGBO(68, 68, 68, 1.0),
  tertiary: Color(0xFF745470),
  tertiaryContainer: Color(0xFFFFD6F7),
  onTertiary: Color(0xFFFFFFFF),
  onTertiaryContainer: Color(0xFF2B122A),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  outline: Color(0xFF767680),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF1B1B1F),
  surface: Color(0xFFFEFBFF),
  onSurface: Color(0xFF1B1B1F),
  surfaceVariant: Color(0xFFE2E1EC),
  onSurfaceVariant: Color(0xFF45464F),
  inverseSurface: Color(0xFF303034),
  onInverseSurface: Color(0xFFF2F0F4),
  inversePrimary: Color(0xFFB5C4FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF405AA9),
  outlineVariant: Color(0xFFC6C6D0),
  scrim: Color(0xFF000000),
);

//estilos de textos
const estiloTitulo1 = TextStyle(fontWeight: FontWeight.w800, fontSize: 60);
const estiloTitulo2 = TextStyle(fontWeight: FontWeight.w700, fontSize: 48);
const estiloTitulo3 = TextStyle(fontWeight: FontWeight.w600, fontSize: 38);
const estiloSubTitulo1 = TextStyle(fontWeight: FontWeight.w700, fontSize: 30);
const estiloSubTitulo2 = TextStyle(fontWeight: FontWeight.w600, fontSize: 24);
const estiloSubTitulo3 = TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
final estiloSubTitulo3_OnBackground = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: lightColorScheme.onBackground);
const estiloSubTitulo4 = TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
final estiloSubTitulo4_OnBackground = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: lightColorScheme.onBackground);
const estiloSubTitulo5 = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
final estiloSubTitulo5_OnBackground = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: lightColorScheme.onBackground);
const estiloSubTitulo6 = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);
final estiloSubTitulo6_OnBackground = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: lightColorScheme.onBackground);
const estiloCorpoTexto1 = TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
final estiloCorpoTexto1_OnBackground = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: lightColorScheme.onBackground);
const estiloCorpoTexto2 = TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
final estiloCorpoTexto2_OnSurfaceVariant = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: lightColorScheme.onSurfaceVariant);
const estiloCorpoTexto3 = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);
final estiloCorpoTexto3_Primary = TextStyle(
    fontWeight: FontWeight.w500, fontSize: 14, color: lightColorScheme.primary);
const estiloBarraNavegacao =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 12);
const estiloDescricao = TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
const estiloLegendas = TextStyle(fontWeight: FontWeight.w400, fontSize: 10);
