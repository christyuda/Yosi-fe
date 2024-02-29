import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidang_apps/model/SASidangData.dart';

Widget _buildSidangIcon2(SidangData sidangData) {
  switch (sidangData.jenisSidang) {
    case 'p1':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 45, right: 45),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7091F5),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF7091F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('P1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Proyek 1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'p2':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 45, right: 45),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4B527E),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF4B527E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('P2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Proyek 2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'p3':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 45, right: 45),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7752FE),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF7752FE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('P3 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Proyek 3 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'i1':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 35, right: 35),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 95, 94, 94),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF419197),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('I1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Internship 1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'i2':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 35, right: 35),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 95, 94, 94),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF12486B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('I2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Internship 2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'ta':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 35, right: 35),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 95, 94, 94),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF6499E9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('TA ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Tugas Akhir ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    default:
      return Container();
  }
}
