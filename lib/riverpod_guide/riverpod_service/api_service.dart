import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_for_all/riverpod_guide/riverpod_model/suggestion_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  Future<Suggestion> getSuggestion() async {
    // when passing id
  // Future<Suggestion> getSuggestion(String id) async {
    try {
      final res = await Dio().get('https://boredapi.com/api/activity');
      // when passing parameter then you can apend it after /activity/$id
      // final res = await Dio().get('https://boredapi.com/api/activity');
      return Suggestion.fromJson(res.data);
    } catch (e) {
      throw Exception('Error getting suggestion');
    }
  }
}

// https://boredapi.com/api/activity