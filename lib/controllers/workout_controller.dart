import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkoutController extends ChangeNotifier {
  List<dynamic> _exercises = [];
  bool _isLoading = false;

  List<dynamic> get exercises => _exercises;
  bool get isLoading => _isLoading;

  Future<void> fetchExercises(String query) async {
    if (query.isEmpty) {
      _exercises = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json');
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> allExercises = json.decode(response.body);
        _exercises = allExercises.where((ex) {
          final name = (ex['name'] ?? '').toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).take(15).map((ex) {
          return {
            'name': ex['name'],
            'difficulty': ex['level'],
            'muscle': (ex['primaryMuscles'] != null && (ex['primaryMuscles'] as List).isNotEmpty) 
                ? ex['primaryMuscles'][0] 
                : 'Unknown',
            'type': ex['category'],
            'safety_info': ex['safety_info'],
            'equipment': ex['equipment'],
            'equipments': ex['equipments'],
            'imageUrl': (ex['images'] != null && (ex['images'] as List).isNotEmpty)
                ? 'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/${ex['images'][0]}'
                : null,
          };
        }).toList();
      } else {
        _exercises = [];
      }
    } catch (e) {
      _exercises = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<dynamic>> fetchExercisesByMuscle(String targetMuscle) async {
    final url = Uri.parse('https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json');
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> allExercises = json.decode(response.body);
        return allExercises.where((ex) {
          final primary = (ex['primaryMuscles'] as List?)?.cast<String>() ?? [];
          final secondary = (ex['secondaryMuscles'] as List?)?.cast<String>() ?? [];
          return primary.contains(targetMuscle) || secondary.contains(targetMuscle);
        }).take(20).map((ex) {
          final isTimeBased = (ex['category'] == 'stretching' || ex['category'] == 'cardio');
          
          return {
            'name': ex['name'],
            'difficulty': ex['level'],
            'muscle': (ex['primaryMuscles'] != null && (ex['primaryMuscles'] as List).isNotEmpty) 
                ? ex['primaryMuscles'][0] 
                : 'Unknown',
            'type': ex['category'],
            'reps': isTimeBased ? null : '3 sets x 12 reps',
            'time': isTimeBased ? '30 seconds' : null,
            'imageUrl': (ex['images'] != null && (ex['images'] as List).isNotEmpty)
                ? 'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/${ex['images'][0]}'
                : null,
          };
        }).toList();
      }
    } catch (e) {
      // Return empty on error
    }
    return [];
  }
}
