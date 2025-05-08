import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    primaryColor: const Color(0xFF3B82F6),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF0F172A),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFF8FAFC)),
      titleTextStyle: TextStyle(
        color: Color(0xFFF8FAFC),
        fontSize: 20,
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: const Color(0xFF1E293B),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFF8FAFC), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E293B),
      hintStyle: TextStyle(color: Color(0xFF94A3B8)),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF94A3B8)),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFFF1F5F9),
    primaryColor: const Color(0xFF3B82F6),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF1F5F9),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF0F172A)),
      titleTextStyle: TextStyle(
        color: Color(0xFF0F172A),
        fontSize: 20,
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF0F172A), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF475569), fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFE2E8F0),
      hintStyle: TextStyle(color: Color(0xFF94A3B8)),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF475569)),
  );
}
