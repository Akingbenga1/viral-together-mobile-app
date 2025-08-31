import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../bloc/influencer_bloc.dart';

class InfluencerDetailPage extends StatefulWidget {
  final int influencerId;

  const InfluencerDetailPage({
    super.key,
    required this.influencerId,
  });

  @override
  State<InfluencerDetailPage> createState() => _InfluencerDetailPageState();
}

class _InfluencerDetailPageState extends State<InfluencerDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<InfluencerBloc>().add(
      GetInfluencerByIdRequested(widget.influencerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<InfluencerBloc, InfluencerState>(
        builder: (context, state) {
          if (state is InfluencerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InfluencerDetailSuccess) {
            return _buildDetailContent(state.influencer);
          } else if (state is InfluencerError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading influencer',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<InfluencerBloc>().add(
                        GetInfluencerByIdRequested(widget.influencerId),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailContent(Map<String, dynamic> influencer) {
    final user = influencer['user'] as Map<String, dynamic>;
    final baseCountry = influencer['base_country'] as Map<String, dynamic>;
    final collaborationCountries = influencer['collaboration_countries'] as List<dynamic>;
    final socialMediaLinks = influencer['social_media_links'] as Map<String, dynamic>?;
    final rates = influencer['rates'] as Map<String, dynamic>?;
    final pastCollaborations = influencer['past_collaborations'] as List<dynamic>?;

    return CustomScrollView(
      slivers: [
        // App Bar with back button
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: AppTheme.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {
                // TODO: Add to favorites
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to favorites')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {
                // TODO: Share influencer profile
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.primaryVariant,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        _getInitials(user['first_name'], user['last_name']),
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${user['first_name']} ${user['last_name']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@${user['username']}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bio
                if (influencer['bio'] != null) ...[
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    influencer['bio'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Stats
                _buildStatsSection(influencer),
                
                const SizedBox(height: 24),
                
                // Location
                _buildLocationSection(baseCountry, collaborationCountries),
                
                const SizedBox(height: 24),
                
                // Social Media Links
                if (socialMediaLinks != null && socialMediaLinks.isNotEmpty)
                  _buildSocialMediaSection(socialMediaLinks),
                
                const SizedBox(height: 24),
                
                // Rates
                if (rates != null && rates.isNotEmpty)
                  _buildRatesSection(rates),
                
                const SizedBox(height: 24),
                
                // Past Collaborations
                if (pastCollaborations != null && pastCollaborations.isNotEmpty)
                  _buildCollaborationsSection(pastCollaborations),
                
                const SizedBox(height: 32),
                
                // Contact Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showContactDialog(influencer);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Contact Influencer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(Map<String, dynamic> influencer) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: _buildStat(
                icon: Icons.people,
                value: _formatNumber(influencer['follower_count']),
                label: 'Followers',
              ),
            ),
            Expanded(
              child: _buildStat(
                icon: Icons.trending_up,
                value: '${influencer['engagement_rate']}%',
                label: 'Engagement',
              ),
            ),
            Expanded(
              child: _buildStat(
                icon: Icons.location_on,
                value: influencer['base_country']['name'],
                label: 'Location',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection(Map<String, dynamic> baseCountry, List<dynamic> collaborationCountries) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location & Availability',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.home, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text('Base: ${baseCountry['name']}'),
              ],
            ),
            if (collaborationCountries.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.public, color: AppTheme.secondaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Available in: ${collaborationCountries.map((c) => c['name']).join(', ')}',
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection(Map<String, dynamic> socialMediaLinks) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Social Media',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: socialMediaLinks.entries.map((entry) {
                return ElevatedButton.icon(
                  onPressed: () => _launchUrl(entry.value),
                  icon: _getSocialMediaIcon(entry.key),
                  label: Text(entry.key),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getSocialMediaColor(entry.key),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatesSection(Map<String, dynamic> rates) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rates',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...rates.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key.replaceAll('_', ' ').toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '\$${entry.value}',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCollaborationsSection(List<dynamic> collaborations) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Past Collaborations',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...collaborations.map((collab) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppTheme.secondaryColor, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(collab)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _getInitials(String firstName, String lastName) {
    return '${firstName[0]}${lastName[0]}'.toUpperCase();
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Icon _getSocialMediaIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return const Icon(Icons.camera_alt);
      case 'tiktok':
        return const Icon(Icons.music_note);
      case 'youtube':
        return const Icon(Icons.play_circle);
      case 'twitter':
        return const Icon(Icons.chat);
      default:
        return const Icon(Icons.link);
    }
  }

  Color _getSocialMediaColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return const Color(0xFFE4405F);
      case 'tiktok':
        return const Color(0xFF000000);
      case 'youtube':
        return const Color(0xFFFF0000);
      case 'twitter':
        return const Color(0xFF1DA1F2);
      default:
        return AppTheme.primaryColor;
    }
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }

  void _showContactDialog(Map<String, dynamic> influencer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Influencer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Send Email'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: Implement email functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email feature coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Send Message'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: Implement messaging functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Messaging feature coming soon')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
} 