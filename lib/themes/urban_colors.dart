// lib/theme/urban_colors.dart

import 'package:flutter/material.dart';

class UrbanColors {
  // Paleta de Fondos (Gris muy oscuro/azul noche)
  static const Color darkBg      = Color(0xFF13151D);
  static const Color darkCard    = Color(0xFF1D2029);
  static const Color darkSurface = Color(0xFF262A35);

  // Paleta de Textos y Contenidos
  static const Color textMain    = Color(0xFFFFFFFF);
  static const Color textMuted   = Color(0xFF8B8E99);
  static const Color textGraySub = Color(0xFFC7CAD3);

  // Paleta de Acentos y Estados
  static const Color accentGreen = Color(0xFF22C55E); // Para '+%' y 'Todos activos'
  static const Color accentRed   = Color(0xFFEF4444); // Para 'bajo stock'
  static const Color purpleLight = Color(0xFF8B8FA8); // Para el badge del AppBar
  static const Color grayBorder  = Color(0xFF2E3340); // Bordes suaves

  // Paleta Degradado del Banner
  static const Color gradientStart = Color(0xFF5A6178);
  static const Color gradientEnd   = Color(0xFF383C4D);
}