import 'package:flutter/material.dart';
import '../../../../core/routes/app_router.dart';
import '../../domain/entities/influencer.dart';

class InfluencerCard extends StatelessWidget {
  final Influencer influencer;
  final VoidCallback? onTap;

  const InfluencerCard({
    super.key,
    required this.influencer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap ?? () {
          Navigator.pushNamed(
            context,
            AppRouter.influencerDetail,
            arguments: {'influencerId': influencer.id},
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: influencer.profileImage != null
                        ? NetworkImage(influencer.profileImage!)
                        : null,
                    child: influencer.profileImage == null
                        ? Text(
                            influencer.name.isNotEmpty
                                ? influencer.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          influencer.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          influencer.bio ?? 'No bio available',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatItem(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: influencer.location ?? 'Unknown',
                  ),
                  const SizedBox(width: 16),
                  _buildStatItem(
                    icon: Icons.people,
                    label: 'Followers',
                    value: _formatNumber(influencer.followers),
                  ),
                  const SizedBox(width: 16),
                  _buildStatItem(
                    icon: Icons.trending_up,
                    label: 'Engagement',
                    value: '${influencer.engagementRate?.toStringAsFixed(1) ?? '0'}%',
                  ),
                ],
              ),
              if (influencer.socialMediaLinks.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: influencer.socialMediaLinks
                      .take(3)
                      .map((platform) => Chip(
                            label: Text(platform),
                            backgroundColor: Colors.blue[50],
                            labelStyle: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 12,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
} 