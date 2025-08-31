import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/api_service.dart';

// Events
abstract class InfluencerEvent extends Equatable {
  const InfluencerEvent();

  @override
  List<Object?> get props => [];
}

class SearchInfluencersRequested extends InfluencerEvent {
  final List<int>? countryIds;
  final String? industry;
  final String? platform;
  final double? latitude;
  final double? longitude;
  final double? radius;

  const SearchInfluencersRequested({
    this.countryIds,
    this.industry,
    this.platform,
    this.latitude,
    this.longitude,
    this.radius,
  });

  @override
  List<Object?> get props => [countryIds, industry, platform, latitude, longitude, radius];
}

class GetInfluencerByIdRequested extends InfluencerEvent {
  final int influencerId;

  const GetInfluencerByIdRequested(this.influencerId);

  @override
  List<Object?> get props => [influencerId];
}

// States
abstract class InfluencerState extends Equatable {
  const InfluencerState();

  @override
  List<Object?> get props => [];
}

class InfluencerInitial extends InfluencerState {}

class InfluencerLoading extends InfluencerState {}

class InfluencerSearchSuccess extends InfluencerState {
  final List<Map<String, dynamic>> influencers;

  const InfluencerSearchSuccess(this.influencers);

  @override
  List<Object?> get props => [influencers];
}

class InfluencerDetailSuccess extends InfluencerState {
  final Map<String, dynamic> influencer;

  const InfluencerDetailSuccess(this.influencer);

  @override
  List<Object?> get props => [influencer];
}

class InfluencerError extends InfluencerState {
  final String message;

  const InfluencerError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class InfluencerBloc extends Bloc<InfluencerEvent, InfluencerState> {
  final ApiService apiService;

  InfluencerBloc({
    required this.apiService,
  }) : super(InfluencerInitial()) {
    on<SearchInfluencersRequested>(_onSearchInfluencersRequested);
    on<GetInfluencerByIdRequested>(_onGetInfluencerByIdRequested);
  }

  Future<void> _onSearchInfluencersRequested(
    SearchInfluencersRequested event,
    Emitter<InfluencerState> emit,
  ) async {
    emit(InfluencerLoading());
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // TODO: Uncomment when API is ready
    // try {
    //   final influencers = await apiService.searchInfluencers(
    //     countryIds: event.countryIds,
    //     industry: event.industry,
    //     platform: event.platform,
    //     latitude: event.latitude,
    //     longitude: event.longitude,
    //     radius: event.radius,
    //   );
    //   
    //   emit(InfluencerSearchSuccess(influencers));
    // } catch (e) {
    //   emit(InfluencerError(e.toString()));
    // }
    
    // Return dummy influencer data
    final dummyInfluencers = [
      {
        'id': 1,
        'name': 'Sarah Johnson',
        'bio': 'Lifestyle & Travel Content Creator | Exploring the world one adventure at a time ✈️',
        'location': 'Los Angeles, CA',
        'followers': 125000,
        'engagement_rate': 4.2,
        'profile_image': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/sarahjohnson', 'https://tiktok.com/@sarahjohnson'],
        'content_types': ['Lifestyle', 'Travel', 'Fashion'],
        'base_rate': 2500.0,
      },
      {
        'id': 2,
        'name': 'Mike Chen',
        'bio': 'Tech Reviewer & Gadget Enthusiast | Breaking down the latest in technology 🔧',
        'location': 'San Francisco, CA',
        'followers': 89000,
        'engagement_rate': 3.8,
        'profile_image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://youtube.com/mikechen', 'https://instagram.com/mikechen'],
        'content_types': ['Technology', 'Reviews', 'Gaming'],
        'base_rate': 1800.0,
      },
      {
        'id': 3,
        'name': 'Emma Rodriguez',
        'bio': 'Fitness Coach & Wellness Advocate | Helping you achieve your health goals 💪',
        'location': 'Miami, FL',
        'followers': 210000,
        'engagement_rate': 5.1,
        'profile_image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/emmafitness', 'https://tiktok.com/@emmafitness'],
        'content_types': ['Fitness', 'Wellness', 'Nutrition'],
        'base_rate': 3200.0,
      },
      {
        'id': 4,
        'name': 'David Kim',
        'bio': 'Food Blogger & Culinary Expert | Sharing delicious recipes and food adventures 🍳',
        'location': 'New York, NY',
        'followers': 156000,
        'engagement_rate': 4.7,
        'profile_image': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/davidfoodie', 'https://youtube.com/davidfoodie'],
        'content_types': ['Food', 'Cooking', 'Restaurant Reviews'],
        'base_rate': 2800.0,
      },
      {
        'id': 5,
        'name': 'Lisa Thompson',
        'bio': 'Beauty & Makeup Artist | Professional makeup tips and product reviews 💄',
        'location': 'Chicago, IL',
        'followers': 178000,
        'engagement_rate': 4.9,
        'profile_image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/lisabeauty', 'https://tiktok.com/@lisabeauty'],
        'content_types': ['Beauty', 'Makeup', 'Skincare'],
        'base_rate': 2600.0,
      },
      {
        'id': 6,
        'name': 'Alex Rivera',
        'bio': 'Gaming Streamer & Esports Enthusiast | Live gaming content and community 🎮',
        'location': 'Austin, TX',
        'followers': 320000,
        'engagement_rate': 6.2,
        'profile_image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://twitch.tv/alexgaming', 'https://youtube.com/alexgaming'],
        'content_types': ['Gaming', 'Esports', 'Live Streaming'],
        'base_rate': 4200.0,
      },
      {
        'id': 7,
        'name': 'Maria Garcia',
        'bio': 'Fashion Stylist & Trend Setter | Latest fashion trends and style inspiration 👗',
        'location': 'Dallas, TX',
        'followers': 145000,
        'engagement_rate': 4.3,
        'profile_image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/mariafashion', 'https://tiktok.com/@mariafashion'],
        'content_types': ['Fashion', 'Style', 'Trends'],
        'base_rate': 2400.0,
      },
      {
        'id': 8,
        'name': 'James Wilson',
        'bio': 'Business Coach & Entrepreneur | Helping startups and businesses grow 📈',
        'location': 'Seattle, WA',
        'followers': 67000,
        'engagement_rate': 3.5,
        'profile_image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://linkedin.com/jameswilson', 'https://youtube.com/jameswilson'],
        'content_types': ['Business', 'Entrepreneurship', 'Leadership'],
        'base_rate': 1500.0,
      },
      {
        'id': 9,
        'name': 'Sophie Anderson',
        'bio': 'Pet Care Expert & Animal Lover | Tips for happy and healthy pets 🐾',
        'location': 'Portland, OR',
        'followers': 98000,
        'engagement_rate': 4.8,
        'profile_image': 'https://images.unsplash.com/photo-1548142813-c348350df52b?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/sophiepets', 'https://tiktok.com/@sophiepets'],
        'content_types': ['Pet Care', 'Animals', 'Lifestyle'],
        'base_rate': 1900.0,
      },
      {
        'id': 10,
        'name': 'Ryan Park',
        'bio': 'Music Producer & DJ | Creating beats and sharing music production tips 🎵',
        'location': 'Nashville, TN',
        'followers': 112000,
        'engagement_rate': 4.1,
        'profile_image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/ryanmusic', 'https://youtube.com/ryanmusic'],
        'content_types': ['Music', 'Production', 'DJ'],
        'base_rate': 2200.0,
      },
    ];
    
    emit(InfluencerSearchSuccess(dummyInfluencers));
  }

  Future<void> _onGetInfluencerByIdRequested(
    GetInfluencerByIdRequested event,
    Emitter<InfluencerState> emit,
  ) async {
    emit(InfluencerLoading());
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // TODO: Uncomment when API is ready
    // try {
    //   final influencer = await apiService.getInfluencerById(event.influencerId);
    //   emit(InfluencerDetailSuccess(influencer));
    // } catch (e) {
    //   emit(InfluencerError(e.toString()));
    // }
    
    // Return dummy influencer data based on ID
    final dummyInfluencers = {
      1: {
        'id': 1,
        'name': 'Sarah Johnson',
        'bio': 'Lifestyle & Travel Content Creator | Exploring the world one adventure at a time ✈️',
        'location': 'Los Angeles, CA',
        'followers': 125000,
        'engagement_rate': 4.2,
        'profile_image': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/sarahjohnson', 'https://tiktok.com/@sarahjohnson'],
        'content_types': ['Lifestyle', 'Travel', 'Fashion'],
        'base_rate': 2500.0,
      },
      2: {
        'id': 2,
        'name': 'Mike Chen',
        'bio': 'Tech Reviewer & Gadget Enthusiast | Breaking down the latest in technology 🔧',
        'location': 'San Francisco, CA',
        'followers': 89000,
        'engagement_rate': 3.8,
        'profile_image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://youtube.com/mikechen', 'https://instagram.com/mikechen'],
        'content_types': ['Technology', 'Reviews', 'Gaming'],
        'base_rate': 1800.0,
      },
      3: {
        'id': 3,
        'name': 'Emma Rodriguez',
        'bio': 'Fitness Coach & Wellness Advocate | Helping you achieve your health goals 💪',
        'location': 'Miami, FL',
        'followers': 210000,
        'engagement_rate': 5.1,
        'profile_image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/emmafitness', 'https://tiktok.com/@emmafitness'],
        'content_types': ['Fitness', 'Wellness', 'Nutrition'],
        'base_rate': 3200.0,
      },
      4: {
        'id': 4,
        'name': 'David Kim',
        'bio': 'Food Blogger & Culinary Expert | Sharing delicious recipes and food adventures 🍳',
        'location': 'New York, NY',
        'followers': 156000,
        'engagement_rate': 4.7,
        'profile_image': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/davidfoodie', 'https://youtube.com/davidfoodie'],
        'content_types': ['Food', 'Cooking', 'Restaurant Reviews'],
        'base_rate': 2800.0,
      },
      5: {
        'id': 5,
        'name': 'Lisa Thompson',
        'bio': 'Beauty & Makeup Artist | Professional makeup tips and product reviews 💄',
        'location': 'Chicago, IL',
        'followers': 178000,
        'engagement_rate': 4.9,
        'profile_image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/lisabeauty', 'https://tiktok.com/@lisabeauty'],
        'content_types': ['Beauty', 'Makeup', 'Skincare'],
        'base_rate': 2600.0,
      },
      6: {
        'id': 6,
        'name': 'Alex Rivera',
        'bio': 'Gaming Streamer & Esports Enthusiast | Live gaming content and community 🎮',
        'location': 'Austin, TX',
        'followers': 320000,
        'engagement_rate': 6.2,
        'profile_image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://twitch.tv/alexgaming', 'https://youtube.com/alexgaming'],
        'content_types': ['Gaming', 'Esports', 'Live Streaming'],
        'base_rate': 4200.0,
      },
      7: {
        'id': 7,
        'name': 'Maria Garcia',
        'bio': 'Fashion Stylist & Trend Setter | Latest fashion trends and style inspiration 👗',
        'location': 'Dallas, TX',
        'followers': 145000,
        'engagement_rate': 4.3,
        'profile_image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/mariafashion', 'https://tiktok.com/@mariafashion'],
        'content_types': ['Fashion', 'Style', 'Trends'],
        'base_rate': 2400.0,
      },
      8: {
        'id': 8,
        'name': 'James Wilson',
        'bio': 'Business Coach & Entrepreneur | Helping startups and businesses grow 📈',
        'location': 'Seattle, WA',
        'followers': 67000,
        'engagement_rate': 3.5,
        'profile_image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://linkedin.com/jameswilson', 'https://youtube.com/jameswilson'],
        'content_types': ['Business', 'Entrepreneurship', 'Leadership'],
        'base_rate': 1500.0,
      },
      9: {
        'id': 9,
        'name': 'Sophie Anderson',
        'bio': 'Pet Care Expert & Animal Lover | Tips for happy and healthy pets 🐾',
        'location': 'Portland, OR',
        'followers': 98000,
        'engagement_rate': 4.8,
        'profile_image': 'https://images.unsplash.com/photo-1548142813-c348350df52b?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/sophiepets', 'https://tiktok.com/@sophiepets'],
        'content_types': ['Pet Care', 'Animals', 'Lifestyle'],
        'base_rate': 1900.0,
      },
      10: {
        'id': 10,
        'name': 'Ryan Park',
        'bio': 'Music Producer & DJ | Creating beats and sharing music production tips 🎵',
        'location': 'Nashville, TN',
        'followers': 112000,
        'engagement_rate': 4.1,
        'profile_image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
        'social_media_links': ['https://instagram.com/ryanmusic', 'https://youtube.com/ryanmusic'],
        'content_types': ['Music', 'Production', 'DJ'],
        'base_rate': 2200.0,
      },
    };
    
    final influencer = dummyInfluencers[event.influencerId];
    if (influencer != null) {
      emit(InfluencerDetailSuccess(influencer));
    } else {
      emit(InfluencerError('Influencer not found'));
    }
  }
} 