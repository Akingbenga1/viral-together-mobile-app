import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Partners'),
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
                    Icons.handshake_outlined,
                    size: 64,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Our Partners',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Working together with leading brands and platforms to create the best influencer marketing experience.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Partnership Types
            Text(
              'Partnership Types',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildPartnershipTypeCard(
              context: context,
              icon: Icons.business,
              title: 'Brand Partners',
              description: 'Leading companies across various industries that trust our platform for their influencer marketing campaigns.',
              examples: ['Fashion & Beauty', 'Technology', 'Food & Beverage', 'Travel & Lifestyle'],
            ),

            const SizedBox(height: 20),

            _buildPartnershipTypeCard(
              context: context,
              icon: Icons.integration_instructions,
              title: 'Technology Partners',
              description: 'Strategic partnerships with platforms and tools that enhance our service capabilities.',
              examples: ['Analytics Platforms', 'Social Media APIs', 'Payment Processors', 'CRM Systems'],
            ),

            const SizedBox(height: 20),

            _buildPartnershipTypeCard(
              context: context,
              icon: Icons.school,
              title: 'Educational Partners',
              description: 'Collaborations with institutions and organizations that help educate the creator community.',
              examples: ['Marketing Schools', 'Creator Academies', 'Industry Associations', 'Training Programs'],
            ),

            const SizedBox(height: 32),

            // Featured Partners
            Text(
              'Featured Partners',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildPartnerCard(
                  context: context,
                  name: 'TechCorp',
                  description: 'Leading technology solutions provider',
                  logoIcon: Icons.computer,
                ),
                _buildPartnerCard(
                  context: context,
                  name: 'FashionHub',
                  description: 'Global fashion retail network',
                  logoIcon: Icons.shopping_bag,
                ),
                _buildPartnerCard(
                  context: context,
                  name: 'FoodieWorld',
                  description: 'Restaurant and food delivery platform',
                  logoIcon: Icons.restaurant,
                ),
                _buildPartnerCard(
                  context: context,
                  name: 'TravelMax',
                  description: 'International travel and tourism',
                  logoIcon: Icons.flight,
                ),
                _buildPartnerCard(
                  context: context,
                  name: 'HealthPlus',
                  description: 'Wellness and fitness brand',
                  logoIcon: Icons.fitness_center,
                ),
                _buildPartnerCard(
                  context: context,
                  name: 'EduTech',
                  description: 'Online education platform',
                  logoIcon: Icons.school,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Partnership Benefits
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
                    'Partnership Benefits',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildBenefitItem(
                    context: context,
                    icon: Icons.trending_up,
                    title: 'Expanded Reach',
                    description: 'Access to our growing network of influencers and brands',
                  ),
                  
                  _buildBenefitItem(
                    context: context,
                    icon: Icons.analytics,
                    title: 'Advanced Analytics',
                    description: 'Comprehensive insights and performance tracking',
                  ),
                  
                  _buildBenefitItem(
                    context: context,
                    icon: Icons.support_agent,
                    title: 'Dedicated Support',
                    description: 'Priority support and account management',
                  ),
                  
                  _buildBenefitItem(
                    context: context,
                    icon: Icons.security,
                    title: 'Secure Platform',
                    description: 'Enterprise-grade security and data protection',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Become a Partner CTA
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
                    Icons.add_business,
                    size: 48,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Become a Partner',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Join our partner ecosystem and help shape the future of influencer marketing.',
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
                    label: const Text('Get in Touch'),
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

  Widget _buildPartnershipTypeCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required List<String> examples,
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
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
            children: examples.map((example) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                example,
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

  Widget _buildPartnerCard({
    required BuildContext context,
    required String name,
    required String description,
    required IconData logoIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              logoIcon,
              color: AppTheme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem({
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