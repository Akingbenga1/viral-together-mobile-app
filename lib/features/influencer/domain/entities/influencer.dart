class Influencer {
  final int id;
  final String name;
  final String? bio;
  final String? location;
  final int followers;
  final double? engagementRate;
  final String? profileImage;
  final List<String> socialMediaLinks;
  final List<String> contentTypes;
  final double? baseRate;

  const Influencer({
    required this.id,
    required this.name,
    this.bio,
    this.location,
    required this.followers,
    this.engagementRate,
    this.profileImage,
    this.socialMediaLinks = const [],
    this.contentTypes = const [],
    this.baseRate,
  });

  factory Influencer.fromJson(Map<String, dynamic> json) {
    return Influencer(
      id: json['id'] as int,
      name: json['name'] as String,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      followers: json['followers'] as int? ?? 0,
      engagementRate: (json['engagement_rate'] as num?)?.toDouble(),
      profileImage: json['profile_image'] as String?,
      socialMediaLinks: List<String>.from(json['social_media_links'] ?? []),
      contentTypes: List<String>.from(json['content_types'] ?? []),
      baseRate: (json['base_rate'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'location': location,
      'followers': followers,
      'engagement_rate': engagementRate,
      'profile_image': profileImage,
      'social_media_links': socialMediaLinks,
      'content_types': contentTypes,
      'base_rate': baseRate,
    };
  }

  Influencer copyWith({
    int? id,
    String? name,
    String? bio,
    String? location,
    int? followers,
    double? engagementRate,
    String? profileImage,
    List<String>? socialMediaLinks,
    List<String>? contentTypes,
    double? baseRate,
  }) {
    return Influencer(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      followers: followers ?? this.followers,
      engagementRate: engagementRate ?? this.engagementRate,
      profileImage: profileImage ?? this.profileImage,
      socialMediaLinks: socialMediaLinks ?? this.socialMediaLinks,
      contentTypes: contentTypes ?? this.contentTypes,
      baseRate: baseRate ?? this.baseRate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Influencer && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Influencer(id: $id, name: $name, followers: $followers)';
  }
} 