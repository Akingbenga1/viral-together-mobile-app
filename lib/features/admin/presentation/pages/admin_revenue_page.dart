import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AdminRevenuePage extends StatefulWidget {
  const AdminRevenuePage({super.key});

  @override
  State<AdminRevenuePage> createState() => _AdminRevenuePageState();
}

class _AdminRevenuePageState extends State<AdminRevenuePage> {
  String _selectedPeriod = '30 days';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Revenue Analytics'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Revenue Overview
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildRevenueCard('Total Revenue', '\$127,450', '+15.7%', true, Icons.monetization_on),
                _buildRevenueCard('Monthly Revenue', '\$42,150', '+8.2%', true, Icons.calendar_month),
                _buildRevenueCard('Avg. Transaction', '\$68.50', '+3.1%', true, Icons.receipt),
                _buildRevenueCard('Active Subscribers', '1,856', '+12.5%', true, Icons.people),
              ],
            ),
            
            const SizedBox(height: 32),

            // Revenue by Plan
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
                  Text('Revenue by Plan', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPlanRevenueItem('Enterprise', '\$78,450', 62, Colors.purple),
                  _buildPlanRevenueItem('Professional', '\$35,200', 28, Colors.blue),
                  _buildPlanRevenueItem('Starter', '\$13,800', 10, Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Recent Transactions
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Transactions', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () {}, child: const Text('View All')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ..._getMockTransactions().map((transaction) => _buildTransactionItem(transaction)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueCard(String title, String value, String change, bool isPositive, IconData icon) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppTheme.primaryColor),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (isPositive ? Colors.green : Colors.red).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(change, style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const Spacer(),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildPlanRevenueItem(String plan, String revenue, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(plan, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(revenue, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.payment, color: AppTheme.primaryColor, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction['company'], style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(transaction['plan'], style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(transaction['amount'], style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(transaction['date'], style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMockTransactions() {
    return [
      {'company': 'TechCorp Solutions', 'plan': 'Enterprise Plan', 'amount': '\$199.00', 'date': 'Today'},
      {'company': 'Fashion Forward', 'plan': 'Professional Plan', 'amount': '\$79.00', 'date': 'Yesterday'},
      {'company': 'Foodie Delights', 'plan': 'Starter Plan', 'amount': '\$29.00', 'date': '2 days ago'},
      {'company': 'Travel Explorer', 'plan': 'Professional Plan', 'amount': '\$79.00', 'date': '3 days ago'},
    ];
  }
}