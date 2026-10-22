import 'package:flutter/material.dart';

class AppColors {
  // 1. Warna Utama (Primary Colors)
  static const Color primaryRed = Color(0xFFA81A1A); // Redup agar nyaman di mata
  static const Color primaryNavy = Color(0xFF1E293B); // Modern & Profesional

  // 2. Warna Pendukung & Status (Secondary & Semantic Colors)
  static const Color success = Color(0xFF10B981); // Tepat Waktu/Hadir
  static const Color warning = Color(0xFFF59E0B); // Terlambat/Izin
  static const Color info = Color(0xFF3B82F6); // Sisa Cuti/Pengumuman[cite: 1]

  // 3. Warna Latar & Netral (Background & Neutral Colors)
  static const Color background = Color(0xFFF8FAFC); 
  static const Color card = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color whitePrimary = Color(0xFFFFFFFF);   // Putih murni (Judul/Header di background gelap)
  static const Color whiteDisabled = Color(0xFF94A3B8);  // Putih pudar (Text disabled/Hint text)
}