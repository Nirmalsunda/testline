
class UserData {
  final int id;
  final String? name;
  final int coins;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? referrerCode;
  final String? phone;
  final String? exam;
  final int? district;
  final String? email;
  final String? source;
  final String? subject;
  final int? attempt;
  final int? needGuidance;
  final String? interestedScholarship;
  final String? fcmToken;
  final String? installReferrer;
  final int? target;
  final int? careerStage;
  final String? studentType;
  final String? challenges;
  final String? features;
  final String? timing;
  final String? learnerStage;
  final int currentStreak;
  final int longestStreak;
  final int completedTests;
  final List<Report>? report;
  final int betterThan;
  final List<String>? firebaseTopics;
  final bool onboardingRequired;
 UserData({
    required this.id,
    this.name,
    required this.coins,
    required this.createdAt,
    required this.updatedAt,
    this.referrerCode,
    this.phone,
    this.exam,
    this.district,
    this.email,
    this.source,
    this.subject,
    this.attempt,
    this.needGuidance,
    this.interestedScholarship,
    this.fcmToken,
    this.installReferrer,
    this.target,
    this.careerStage,
    this.studentType,
    this.challenges,
    this.features,
    this.timing,
    this.learnerStage,
    required this.currentStreak,
    required this.longestStreak,
    required this.completedTests,
    this.report,
    required this.betterThan,
    this.firebaseTopics,
    required this.onboardingRequired,
  });
 factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      name: json['name']?.isNotEmpty == true ? json['name'] : 'Unknown',
      coins: json['coins'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      referrerCode: json['referrer_code'],
      phone: json['phone'],
      exam: json['exam'],
      district: _parseNullableInt(json['district']),
      email: json['email'],
      source: json['source'],
      subject: json['subject'],
      attempt: _parseNullableInt(json['attempt']),
      needGuidance: _parseNullableInt(json['need_guidance']),
      interestedScholarship: json['interested_scholarship'],
      fcmToken: json['fcm_token'],
      installReferrer: json['install_referrer'],
      target: _parseNullableInt(json['target']),
      careerStage: _parseNullableInt(json['career_stage']),
      studentType: json['student_type'],
      challenges: json['challenges'],
      features: json['features'],
      timing: json['timing'],
      learnerStage: json['learner_stage'],
      currentStreak: json['current_streak'] ?? 0,
      longestStreak: json['longest_streak'] ?? 0,
      completedTests: json['completed_tests'] ?? 0,
      report: (json['report'] as List<dynamic>?)
          ?.map((item) => Report.fromJson(item))
          .toList(),
      betterThan: json['better_than'] ?? 0,
      firebaseTopics: (json['firebase_topics'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      onboardingRequired: json['onboarding_required'] ?? false,
    );
  }

  static int? _parseNullableInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value; 
    }
    if (value is String) {
      return int.tryParse(value); 
    }
    return null; 
  }
}

class Report {
  final String title;
  final String description;
  final String icon;

  Report({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}