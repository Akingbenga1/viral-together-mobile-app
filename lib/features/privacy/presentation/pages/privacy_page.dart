import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
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
                    Icons.privacy_tip_outlined,
                    size: 64,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Privacy Policy',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Last updated: January 2024',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your privacy is important to us. This policy explains how we collect, use, and protect your information.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Table of Contents
            Container(
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
                  Text(
                    'Table of Contents',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildTOCItem(context, '1. Information We Collect'),
                  _buildTOCItem(context, '2. How We Use Your Information'),
                  _buildTOCItem(context, '3. Information Sharing'),
                  _buildTOCItem(context, '4. Data Security'),
                  _buildTOCItem(context, '5. Your Rights'),
                  _buildTOCItem(context, '6. Cookies and Tracking'),
                  _buildTOCItem(context, '7. Changes to This Policy'),
                  _buildTOCItem(context, '8. Contact Us'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Privacy Sections
            _buildPrivacySection(
              context: context,
              title: '1. Information We Collect',
              content: [
                _buildSubSection(
                  context: context,
                  subtitle: 'Information you provide:',
                  items: [
                    'Account information (name, email, password)',
                    'Profile details and preferences',
                    'Payment information for subscriptions',
                    'Communications with our support team',
                  ],
                ),
                _buildSubSection(
                  context: context,
                  subtitle: 'Information we collect automatically:',
                  items: [
                    'Device information and identifiers',
                    'Usage analytics and app interactions',
                    'Location data (with your permission)',
                    'Log files and technical information',
                  ],
                ),
              ],
            ),

            _buildPrivacySection(
              context: context,
              title: '2. How We Use Your Information',
              content: [
                _buildSubSection(
                  context: context,
                  subtitle: 'We use your information to:',
                  items: [
                    'Provide and improve our services',
                    'Personalize your experience',
                    'Process payments and transactions',
                    'Send important updates and notifications',
                    'Provide customer support',
                    'Analyze usage patterns and optimize performance',
                  ],
                ),
              ],
            ),

            _buildPrivacySection(
              context: context,
              title: '3. Information Sharing',
              content: [
                _buildParagraph(
                  context: context,
                  text: 'We do not sell your personal information. We may share your information only in these circumstances:',
                ),
                _buildSubSection(
                  context: context,
                  subtitle: 'Sharing scenarios:',
                  items: [
                    'With your explicit consent',
                    'To comply with legal obligations',
                    'With trusted service providers (under strict agreements)',
                    'In case of business transfers or mergers',
                    'To protect rights, property, or safety',
                  ],
                ),
              ],
            ),

            _buildPrivacySection(
              context: context,
              title: '4. Data Security',
              content: [
                _buildParagraph(
                  context: context,
                  text: 'We implement industry-standard security measures to protect your information:',
                ),
                _buildSubSection(
                  context: context,
                  subtitle: 'Security measures:',
                  items: [
                    'Encryption of data in transit and at rest',
                    'Regular security audits and updates',
                    'Access controls and authentication',
                    'Secure hosting infrastructure',
                    'Employee training on data protection',
                  ],
                ),
              ],
            ),

            _buildPrivacySection(
              context: context,
              title: '5. Your Rights',
              content: [
                _buildParagraph(
                  context: context,
                  text: 'You have the following rights regarding your personal information:',
                ),
                _buildSubSection(
                  context: context,
                  subtitle: 'Your rights include:',
                  items: [
                    'Access your personal data',
                    'Correct inaccurate information',
                    'Delete your account and data',
                    'Export your data',
                    'Opt-out of marketing communications',
                    'Withdraw consent (where applicable)',
                  ],
                ),
              ],
            ),

            _buildPrivacySection(
              context: context,
              title: '6. Cookies and Tracking',
              content: [
                _buildParagraph(
                  context: context,
                  text: 'We use cookies and similar technologies to enhance your experience. You can control cookie preferences in your browser settings.',
                ),
                _buildSubSection(
                  context: context,
                  subtitle: 'Types of cookies we use:',
                  items: [
                    'Essential cookies for app functionality',
                    'Analytics cookies for usage insights',
                    'Preference cookies for personalization',
                    'Marketing cookies (with your consent)',
                  ],
                ),
              ],
            ),

            _buildPrivacySection(
              context: context,
              title: '7. Changes to This Policy',
              content: [
                _buildParagraph(
                  context: context,
                  text: 'We may update this privacy policy from time to time. We will notify you of any significant changes through the app or via email. Your continued use of our services after changes indicates your acceptance of the updated policy.',
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Contact Section
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
                    '8. Contact Us',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'If you have questions about this privacy policy or our data practices, please contact us:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildContactInfo(
                    context: context,
                    icon: Icons.email,
                    label: 'Email',
                    value: 'privacy@viraltogether.com',
                  ),
                  
                  _buildContactInfo(
                    context: context,
                    icon: Icons.location_on,
                    label: 'Address',
                    value: '123 Privacy Street, Data City, DC 12345',
                  ),
                  
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/contact');
                    },
                    icon: const Icon(Icons.support_agent),
                    label: const Text('Contact Support'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
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

  Widget _buildTOCItem(BuildContext context, String item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        item,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildPrivacySection({
    required BuildContext context,
    required String title,
    required List<Widget> content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...content,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSubSection({
    required BuildContext context,
    required String subtitle,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, right: 8),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildParagraph({
    required BuildContext context,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.textSecondary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildContactInfo({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}