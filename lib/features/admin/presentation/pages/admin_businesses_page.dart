import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AdminBusinessesPage extends StatefulWidget {
  const AdminBusinessesPage({super.key});

  @override
  State<AdminBusinessesPage> createState() => _AdminBusinessesPageState();
}

class _AdminBusinessesPageState extends State<AdminBusinessesPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedStatus = 'All';
  String _selectedPlan = 'All';

  final List<String> _statusOptions = ['All', 'Active', 'Pending', 'Suspended'];
  final List<String> _planOptions = ['All', 'Starter', 'Professional', 'Enterprise'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBusinesses = _getFilteredBusinesses();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Business Management'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business),
            onPressed: () => _showAddBusinessDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _exportBusinessData(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Search Bar
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search businesses...',
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

                const SizedBox(height: 16),

                // Filter Chips
                Row(
                  children: [
                    Expanded(
                      child: PopupMenuButton<String>(
                        onSelected: (value) => setState(() => _selectedStatus = value),
                        itemBuilder: (context) => _statusOptions.map((status) => 
                          PopupMenuItem(value: status, child: Text(status))
                        ).toList(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status: $_selectedStatus'),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PopupMenuButton<String>(
                        onSelected: (value) => setState(() => _selectedPlan = value),
                        itemBuilder: (context) => _planOptions.map((plan) => 
                          PopupMenuItem(value: plan, child: Text(plan))
                        ).toList(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Plan: $_selectedPlan'),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Business List
          Expanded(
            child: filteredBusinesses.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.business_center,
                        size: 64,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No businesses found',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try adjusting your search or filters',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: filteredBusinesses.length,
                  itemBuilder: (context, index) {
                    final business = filteredBusinesses[index];
                    return _buildBusinessCard(context, business);
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(BuildContext context, Map<String, dynamic> business) {
    final statusColor = _getStatusColor(business['status']);
    final planColor = _getPlanColor(business['plan']);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                child: Text(
                  business['name'].substring(0, 2).toUpperCase(),
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            business['name'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            business['status'],
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      business['email'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Business Details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  context: context,
                  icon: Icons.category,
                  label: 'Industry',
                  value: business['industry'],
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  context: context,
                  icon: Icons.campaign,
                  label: 'Campaigns',
                  value: business['campaigns'].toString(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  context: context,
                  icon: Icons.calendar_today,
                  label: 'Joined',
                  value: business['joinedDate'],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.workspace_premium,
                      size: 16,
                      color: planColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      business['plan'],
                      style: TextStyle(
                        color: planColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _viewBusinessDetails(business),
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text('View Details'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _editBusiness(business),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.textSecondary,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Suspended':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getPlanColor(String plan) {
    switch (plan) {
      case 'Enterprise':
        return Colors.purple;
      case 'Professional':
        return Colors.blue;
      case 'Starter':
        return Colors.green;
      default:
        return AppTheme.textSecondary;
    }
  }

  List<Map<String, dynamic>> _getFilteredBusinesses() {
    List<Map<String, dynamic>> businesses = _getMockBusinesses();

    // Filter by status
    if (_selectedStatus != 'All') {
      businesses = businesses.where((b) => b['status'] == _selectedStatus).toList();
    }

    // Filter by plan
    if (_selectedPlan != 'All') {
      businesses = businesses.where((b) => b['plan'] == _selectedPlan).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      businesses = businesses.where((b) {
        return b['name'].toLowerCase().contains(_searchQuery) ||
               b['email'].toLowerCase().contains(_searchQuery) ||
               b['industry'].toLowerCase().contains(_searchQuery);
      }).toList();
    }

    return businesses;
  }

  List<Map<String, dynamic>> _getMockBusinesses() {
    return [
      {
        'id': '1',
        'name': 'TechCorp Solutions',
        'email': 'contact@techcorp.com',
        'industry': 'Technology',
        'plan': 'Enterprise',
        'status': 'Active',
        'campaigns': 24,
        'joinedDate': 'Jan 2023',
      },
      {
        'id': '2',
        'name': 'Fashion Forward',
        'email': 'hello@fashionforward.com',
        'industry': 'Fashion',
        'plan': 'Professional',
        'status': 'Active',
        'campaigns': 18,
        'joinedDate': 'Mar 2023',
      },
      {
        'id': '3',
        'name': 'Foodie Delights',
        'email': 'info@foodiedelights.com',
        'industry': 'Food & Beverage',
        'plan': 'Starter',
        'status': 'Active',
        'campaigns': 7,
        'joinedDate': 'Jun 2023',
      },
      {
        'id': '4',
        'name': 'Travel Explorer',
        'email': 'support@travelexplorer.com',
        'industry': 'Travel',
        'plan': 'Professional',
        'status': 'Pending',
        'campaigns': 3,
        'joinedDate': 'Dec 2023',
      },
      {
        'id': '5',
        'name': 'Health & Wellness Co',
        'email': 'team@healthwellness.com',
        'industry': 'Health',
        'plan': 'Enterprise',
        'status': 'Active',
        'campaigns': 31,
        'joinedDate': 'Feb 2023',
      },
      {
        'id': '6',
        'name': 'Gaming Universe',
        'email': 'contact@gaminguniverse.com',
        'industry': 'Gaming',
        'plan': 'Professional',
        'status': 'Suspended',
        'campaigns': 12,
        'joinedDate': 'Aug 2023',
      },
    ];
  }

  void _viewBusinessDetails(Map<String, dynamic> business) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Business Details: ${business['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${business['email']}'),
            Text('Industry: ${business['industry']}'),
            Text('Plan: ${business['plan']}'),
            Text('Status: ${business['status']}'),
            Text('Campaigns: ${business['campaigns']}'),
            Text('Joined: ${business['joinedDate']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _editBusiness(Map<String, dynamic> business) {
    // TODO: Navigate to edit business page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit business: ${business['name']}'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _showAddBusinessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Business'),
        content: const Text('This would open a form to add a new business account.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Add Business'),
          ),
        ],
      ),
    );
  }

  void _exportBusinessData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Business data exported successfully'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}