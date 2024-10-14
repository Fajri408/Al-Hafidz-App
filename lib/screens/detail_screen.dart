import 'dart:convert';
import 'package:al_hafidz/globals.dart';
import 'package:al_hafidz/models/surah.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  Future<Surah> _getDetailSurah() async{
    var data = await Dio().get("https://equran.id/api/surat/$noSurat");
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
            return FutureBuilder<Surah>(
                future: _getDetailSurah(),
                initialData: null,
                builder: ((context, snapshot) {
                  if(!snapshot.hasData){
                    Scaffold(
              backgroundColor: background,
            );
          }
          Surah surah = snapshot.data!;
          return Scaffold(
            backgroundColor: background,
            appBar: _appbar(context: context, surah: surah),
          );
        }));
    }
  AppBar _appbar({required BuildContext context, required Surah surah}) => AppBar(
    backgroundColor: background,
    automaticallyImplyLeading: false ,
    elevation: 0,
    title: Row(children: [
      IconButton(
        onPressed: (()=>{Navigator.of(context).pop(),
      }),
      icon:SvgPicture.asset('assets/svgs/back-icon.svg')),
      const SizedBox(
        width: 24,
      ),
      Text(
        surah.namaLatin, 
        style: GoogleFonts.poppins(
          fontSize:20, fontWeight: FontWeight.bold,
          color: Colors.white),
          ),
      const Spacer(),
      IconButton(
        onPressed: (()=>{}),
        icon:SvgPicture.asset('assets/svgs/search-icon.svg')),
      ]),
  );
}