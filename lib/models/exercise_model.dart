class ExerciseModel {
  final String name;
  final String difficulty;
  final String muscle;
  final String type;
  final String? safetyInfo;
  final String? equipment;
  final List<dynamic>? equipments;
  final String? imageUrl;
  final String? reps;
  final String? time;

  ExerciseModel({
    required this.name,
    required this.difficulty,
    required this.muscle,
    required this.type,
    this.safetyInfo,
    this.equipment,
    this.equipments,
    this.imageUrl,
    this.reps,
    this.time,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json, {bool isTimeBased = false}) {
    final primaryMuscles = json['primaryMuscles'] as List?;
    final images = json['images'] as List?;
    
    return ExerciseModel(
      name: json['name'] ?? 'Unknown',
      difficulty: json['level'] ?? 'Unknown',
      muscle: (primaryMuscles != null && primaryMuscles.isNotEmpty) 
          ? primaryMuscles[0].toString() 
          : 'Unknown',
      type: json['category'] ?? 'Unknown',
      safetyInfo: json['safety_info']?.toString(),
      equipment: json['equipment']?.toString(),
      equipments: json['equipments'] as List?,
      imageUrl: (images != null && images.isNotEmpty)
          ? 'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/${images[0]}'
          : null,
      reps: isTimeBased ? null : '3 sets x 12 reps',
      time: isTimeBased ? '30 seconds' : null,
    );
  }
}
