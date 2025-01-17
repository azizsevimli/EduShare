import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:edushare/models/university_model.dart';
import 'package:edushare/models/associate_model.dart';
import 'package:edushare/models/bachelor_model.dart';

class UniAndDepService {
  Future<List<UniversityModel>> loadUniversities() async {
    String jsonString = await rootBundle.loadString('assets/data/universities.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => UniversityModel.fromJson(json)).toList();
  }

  Future<List<AssociateModel>> loadAssociates() async {
    final String jsonString = await rootBundle.loadString('assets/data/associate.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => AssociateModel.fromJson(json)).toList();
  }

  Future<List<BachelorModel>> loadBachelors() async {
    final String jsonString = await rootBundle.loadString('assets/data/bachelor.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => BachelorModel.fromJson(json)).toList();
  }
}