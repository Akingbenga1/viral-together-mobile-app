import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFAQs = _getFilteredFAQs();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Help & Support'),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help_center,
                    size: 64,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'How can we help?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Find answers to common questions or get in touch with our support team.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Search Bar
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for help topics...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value.toLowerCase());
              },
            ),

            const SizedBox(height: 32),

            // Quick Help Categories
            if (_searchQuery.isEmpty) ...[
              Text(
                'Popular Topics',
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
                childAspectRatio: 1.2,
                children: [
                  _buildHelpCategoryCard(
                    context: context,
                    icon: Icons.account_circle,
                    title: 'Account & Profile',
                    description: 'Manage your account settings',
                    onTap: () => _filterByCategory('account'),
                  ),
                  _buildHelpCategoryCard(
                    context: context,
                    icon: Icons.search,
                    title: 'Finding Influencers',
                    description: 'Search and discovery tips',
                    onTap: () => _filterByCategory('search'),
                  ),
                  _buildHelpCategoryCard(
                    context: context,
                    icon: Icons.payment,
                    title: 'Billing & Plans',
                    description: 'Subscription and payment',
                    onTap: () => _filterByCategory('billing'),
                  ),
                  _buildHelpCategoryCard(
                    context: context,
                    icon: Icons.security,
                    title: 'Privacy & Security',
                    description: 'Data protection & safety',
                    onTap: () => _filterByCategory('privacy'),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],

            // FAQ Section
            Text(
              _searchQuery.isEmpty ? 'Frequently Asked Questions' : 'Search Results',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            if (filteredFAQs.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No results found',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try different keywords or browse our categories above.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...filteredFAQs.map((faq) => _buildFAQCard(
                context: context,
                question: faq['question'] ?? '',
                answer: faq['answer'] ?? '',
              )).toList(),

            const SizedBox(height: 32),

            // Contact Support Section
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 48,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Still need help?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Can\'t find what you\'re looking for? Our support team is here to help.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/contact');
                          },
                          icon: const Icon(Icons.email),
                          label: const Text('Contact Us'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Open chat or live support
                          },
                          icon: const Icon(Icons.chat),
                          label: const Text('Live Chat'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCategoryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
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
      ),
    );
  }

  Widget _buildFAQCard({
    required BuildContext context,
    required String question,
    required String answer,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        title: Text(
          question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Text(
            answer,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _filterByCategory(String category) {
    setState(() {
      _searchQuery = category;
      _searchController.text = category;
    });
  }

  List<Map<String, String>> _getFilteredFAQs() {
    final allFAQs = [
      {
        'question': 'How do I create an account?',
        'answer': 'To create an account, tap the "Sign Up" button on the login screen, enter your email and password, and verify your email address.',
        'category': 'account',
      },
      {
        'question': 'How can I search for influencers?',
        'answer': 'Use the search tab to find influencers by location, category, follower count, and engagement rate. You can also use our advanced filters for more specific results.',
        'category': 'search',
      },
      {
        'question': 'What are the subscription plans?',
        'answer': 'We offer three plans: Starter (\$29/month), Professional (\$79/month), and Enterprise (\$199/month). Each plan includes different features and limits.',
        'category': 'billing',
      },
      {
        'question': 'How is my data protected?',
        'answer': 'We use industry-standard encryption and security measures to protect your data. Read our privacy policy for detailed information about data handling.',
        'category': 'privacy',
      },
      {
        'question': 'Can I change my subscription plan?',
        'answer': 'Yes, you can upgrade or downgrade your plan at any time from the settings page. Changes take effect immediately.',
        'category': 'billing',
      },
      {
        'question': 'How do I reset my password?',
        'answer': 'On the login screen, tap "Forgot Password" and enter your email address. You\'ll receive instructions to reset your password.',
        'category': 'account',
      },
      {
        'question': 'What payment methods do you accept?',
        'answer': 'We accept all major credit cards, PayPal, and bank transfers for annual subscriptions.',
        'category': 'billing',
      },
      {
        'question': 'How do I delete my account?',
        'answer': 'You can delete your account from the settings page. This action is permanent and will remove all your data.',
        'category': 'account',
      },
      {
        'question': 'Can I export my data?',
        'answer': 'Yes, you can export your data from the settings page. We provide data in standard formats like CSV and JSON.',
        'category': 'privacy',
      },
      {
        'question': 'How do I contact support?',
        'answer': 'You can contact our support team through the contact form, email us at support@viraltogether.com, or use the live chat feature.',
        'category': 'general',
      },
    ];

    if (_searchQuery.isEmpty) {
      return allFAQs;
    }

    return allFAQs.where((faq) {
      final searchLower = _searchQuery.toLowerCase();
      return faq['question']!.toLowerCase().contains(searchLower) ||
             faq['answer']!.toLowerCase().contains(searchLower) ||
             faq['category']!.toLowerCase().contains(searchLower);
    }).toList();
  }
}