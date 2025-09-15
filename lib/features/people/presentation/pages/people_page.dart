import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Our People'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.1),
                    AppTheme.secondaryColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.groups,
                    size: 64,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Meet Our Team',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'The passionate team behind Viral Together, working to connect brands with authentic influencers worldwide.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Leadership Team
            Text(
              'Leadership Team',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3.5,
              children: [
                _buildTeamMemberCard(
                  context: context,
                  name: 'Sarah Johnson',
                  position: 'Chief Executive Officer',
                  bio: 'Former Marketing Director at TechCorp with 10+ years in digital marketing and influencer partnerships.',
                  expertise: ['Strategic Planning', 'Business Development', 'Team Leadership'],
                  avatarColor: Colors.blue,
                ),
                _buildTeamMemberCard(
                  context: context,
                  name: 'Michael Chen',
                  position: 'Chief Technology Officer',
                  bio: 'Full-stack developer and architect with expertise in scalable platforms and AI-driven solutions.',
                  expertise: ['Platform Architecture', 'AI & ML', 'Data Analytics'],
                  avatarColor: Colors.green,
                ),
                _buildTeamMemberCard(
                  context: context,
                  name: 'Emily Rodriguez',
                  position: 'Chief Marketing Officer',
                  bio: 'Digital marketing expert specializing in creator economy and social media strategy.',
                  expertise: ['Digital Marketing', 'Creator Relations', 'Brand Strategy'],
                  avatarColor: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Team Departments
            Text(
              'Our Departments',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildDepartmentCard(
              context: context,
              icon: Icons.code,
              title: 'Engineering',
              description: 'Building robust, scalable technology that powers our platform.',
              teamSize: 8,
              skills: ['Flutter', 'Node.js', 'Python', 'AI/ML'],
            ),

            const SizedBox(height: 16),

            _buildDepartmentCard(
              context: context,
              icon: Icons.design_services,
              title: 'Product & Design',
              description: 'Creating intuitive user experiences and defining product strategy.',
              teamSize: 5,
              skills: ['UI/UX Design', 'Product Strategy', 'User Research', 'Prototyping'],
            ),

            const SizedBox(height: 16),

            _buildDepartmentCard(
              context: context,
              icon: Icons.campaign,
              title: 'Marketing',
              description: 'Growing our community and building brand awareness.',
              teamSize: 6,
              skills: ['Content Marketing', 'SEO/SEM', 'Social Media', 'Analytics'],
            ),

            const SizedBox(height: 16),

            _buildDepartmentCard(
              context: context,
              icon: Icons.support_agent,
              title: 'Customer Success',
              description: 'Ensuring our users have the best possible experience.',
              teamSize: 4,
              skills: ['Customer Support', 'Account Management', 'Training', 'Feedback Analysis'],
            ),

            const SizedBox(height: 32),

            // Company Values
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Values',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildValueItem(
                    context: context,
                    icon: Icons.favorite,
                    title: 'Authenticity',
                    description: 'We believe in genuine connections and transparent relationships.',
                  ),
                  
                  _buildValueItem(
                    context: context,
                    icon: Icons.groups,
                    title: 'Community',
                    description: 'Building a supportive ecosystem for creators and brands alike.',
                  ),
                  
                  _buildValueItem(
                    context: context,
                    icon: Icons.trending_up,
                    title: 'Innovation',
                    description: 'Continuously improving our platform with cutting-edge technology.',
                  ),
                  
                  _buildValueItem(
                    context: context,
                    icon: Icons.balance,
                    title: 'Fairness',
                    description: 'Creating equal opportunities and fair compensation for all.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Join Our Team CTA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.1),
                    AppTheme.secondaryColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_outline,
                    size: 48,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join Our Team',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We\'re always looking for talented individuals who share our passion for connecting creators and brands.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/contact');
                    },
                    icon: const Icon(Icons.email),
                    label: const Text('View Open Positions'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard({
    required BuildContext context,
    required String name,
    required String position,
    required String bio,
    required List<String> expertise,
    required Color avatarColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: avatarColor.withOpacity(0.2),
            child: Text(
              name.split(' ').map((n) => n[0]).take(2).join(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: avatarColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  position,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  bio,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: expertise.map((skill) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      skill,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required int teamSize,
    required List<String> skills,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$teamSize team members',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                skill,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}