import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  textTheme: GoogleFonts.archivoTextTheme().copyWith(
    bodySmall: GoogleFonts.archivo(
      fontSize: 16.0,
      fontWeight: FontWeight.w200, // ou FontWeight.w100
    ),
    labelSmall: GoogleFonts.archivo(
      fontSize: 14.0,
      fontWeight: FontWeight.w200, // ou FontWeight.w100
    ),
    // Adicione outros estilos de texto conforme necessário
  ),
);
