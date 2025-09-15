import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AdminSubscriptionsPage extends StatefulWidget {
  const AdminSubscriptionsPage({super.key});

  @override
  State<AdminSubscriptionsPage> createState() => _AdminSubscriptionsPageState();
}

class _AdminSubscriptionsPageState extends State<AdminSubscriptionsPage> {
  String _selectedPlan = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Subscription Management'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subscription Overview
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildOverviewCard('Active Subscriptions', '1,856', Colors.green),
                _buildOverviewCard('Canceled This Month', '47', Colors.red),
                _buildOverviewCard('Renewal Rate', '94.2%', Colors.blue),
                _buildOverviewCard('Churn Rate', '5.8%', Colors.orange),
              ],
            ),

            const SizedBox(height: 32),

            // Plan Distribution
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Plan Distribution', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPlanItem('Enterprise', 324, Colors.purple, 17.5),
                  _buildPlanItem('Professional', 867, Colors.blue, 46.7),
                  _buildPlanItem('Starter', 665, Colors.green, 35.8),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Recent Subscription Changes
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Changes', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ..._getMockSubscriptionChanges().map((change) => _buildChangeItem(change)).toList(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Upcoming Renewals
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Upcoming Renewals', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ..._getMockUpcomingRenewals().map((renewal) => _buildRenewalItem(renewal)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.analytics, color: color, size: 20),
          ),
          const Spacer(),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: color)),
          Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildPlanItem(String plan, int count, Color color, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(plan, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('$count subscriptions', style: TextStyle(color: AppTheme.textSecondary)),
                  ],
                ),
                Text('${percentage.toStringAsFixed(1)}% of total', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeItem(Map<String, dynamic> change) {
    final isUpgrade = change['type'] == 'upgrade';
    final color = isUpgrade ? Colors.green : Colors.red;
    final icon = isUpgrade ? Icons.arrow_upward : Icons.arrow_downward;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Icon(icon, color: color, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(change['company'], style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${change['from']} → ${change['to']}', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(change['date'], style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRenewalItem(Map<String, dynamic> renewal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            child: Text(
              renewal['company'].substring(0, 2).toUpperCase(),
              style: TextStyle(color: AppTheme.primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(renewal['company'], style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${renewal['plan']} - ${renewal['amount']}', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(renewal['date'], style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(renewal['daysLeft'], style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMockSubscriptionChanges() {
    return [
      {'company': 'TechCorp Solutions', 'type': 'upgrade', 'from': 'Professional', 'to': 'Enterprise', 'date': 'Today'},
      {'company': 'Fashion Forward', 'type': 'downgrade', 'from': 'Enterprise', 'to': 'Professional', 'date': 'Yesterday'},
      {'company': 'Foodie Delights', 'type': 'upgrade', 'from': 'Starter', 'to': 'Professional', 'date': '2 days ago'},
    ];
  }

  List<Map<String, dynamic>> _getMockUpcomingRenewals() {
    return [
      {'company': 'Health & Wellness Co', 'plan': 'Enterprise', 'amount': '\$199/month', 'date': 'Jan 30', 'daysLeft': '3 days'},
      {'company': 'Travel Explorer', 'plan': 'Professional', 'amount': '\$79/month', 'date': 'Feb 1', 'daysLeft': '5 days'},
      {'company': 'Gaming Universe', 'plan': 'Professional', 'amount': '\$79/month', 'date': 'Feb 3', 'daysLeft': '7 days'},
    ];
  }
}