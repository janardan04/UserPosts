class ModuleModel {
  final int moduleNumber;
  final String moduleTitle;
  final List<String> topics;
  final List<String> learningOutcomes;

  ModuleModel({
    required this.moduleNumber,
    required this.moduleTitle,
    required this.topics,
    required this.learningOutcomes,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      moduleNumber: json['module_number'],
      moduleTitle: json['module_title'],
      topics: List<String>.from(json['topics']),
      learningOutcomes: List<String>.from(json['learning_outcomes']),
    );
  }
}
