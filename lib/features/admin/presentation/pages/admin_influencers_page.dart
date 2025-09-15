import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AdminInfluencersPage extends StatefulWidget {
  const AdminInfluencersPage({super.key});

  @override
  State<AdminInfluencersPage> createState() => _AdminInfluencersPageState();
}

class _AdminInfluencersPageState extends State<AdminInfluencersPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedStatus = 'All';
  String _selectedTier = 'All';

  final List<String> _statusOptions = ['All', 'Verified', 'Pending', 'Rejected'];
  final List<String> _tierOptions = ['All', 'Nano', 'Micro', 'Macro', 'Mega'];

  @override
  Widget build(BuildContext context) {
    final filteredInfluencers = _getFilteredInfluencers();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Influencer Management'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search influencers...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        decoration: InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        items: _statusOptions.map((status) => 
                          DropdownMenuItem(value: status, child: Text(status))
                        ).toList(),
                        onChanged: (value) => setState(() => _selectedStatus = value ?? 'All'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedTier,
                        decoration: InputDecoration(
                          labelText: 'Tier',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        items: _tierOptions.map((tier) => 
                          DropdownMenuItem(value: tier, child: Text(tier))
                        ).toList(),
                        onChanged: (value) => setState(() => _selectedTier = value ?? 'All'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              itemCount: filteredInfluencers.length,
              itemBuilder: (context, index) => _buildInfluencerCard(context, filteredInfluencers[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencerCard(BuildContext context, Map<String, dynamic> influencer) {
    final statusColor = _getStatusColor(influencer['status']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                child: Text(
                  influencer['name'].split(' ').map((n) => n[0]).join().toUpperCase(),
                  style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
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
                            influencer['name'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            influencer['status'],
                            style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Text('@${influencer['username']}', style: TextStyle(color: AppTheme.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem('${_formatNumber(influencer['followers'])}', 'Followers'),
              _buildStatItem('${influencer['engagementRate']}%', 'Engagement'),
              _buildStatItem(influencer['tier'], 'Tier'),
              _buildStatItem('${influencer['campaigns']}', 'Campaigns'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _viewInfluencerDetails(influencer),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _manageInfluencer(influencer),
                  child: const Text('Manage'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) return '${(number / 1000000).toStringAsFixed(1)}M';
    if (number >= 1000) return '${(number / 1000).toStringAsFixed(1)}K';
    return number.toString();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Verified': return Colors.green;
      case 'Pending': return Colors.orange;
      case 'Rejected': return Colors.red;
      default: return AppTheme.textSecondary;
    }
  }

  List<Map<String, dynamic>> _getFilteredInfluencers() {
    List<Map<String, dynamic>> influencers = _getMockInfluencers();
    
    if (_selectedStatus != 'All') {
      influencers = influencers.where((i) => i['status'] == _selectedStatus).toList();
    }
    if (_selectedTier != 'All') {
      influencers = influencers.where((i) => i['tier'] == _selectedTier).toList();
    }
    if (_searchQuery.isNotEmpty) {
      influencers = influencers.where((i) =>
        i['name'].toLowerCase().contains(_searchQuery) ||
        i['username'].toLowerCase().contains(_searchQuery)
      ).toList();
    }
    
    return influencers;
  }

  List<Map<String, dynamic>> _getMockInfluencers() {
    return [
      {'name': 'Sarah Johnson', 'username': 'tech_sarah', 'followers': 250000, 'engagementRate': 4.2, 'tier': 'Macro', 'campaigns': 12, 'status': 'Verified'},
      {'name': 'Mike Chen', 'username': 'foodie_mike', 'followers': 85000, 'engagementRate': 6.1, 'tier': 'Micro', 'campaigns': 8, 'status': 'Verified'},
      {'name': 'Emma Wilson', 'username': 'fashion_emma', 'followers': 15000, 'engagementRate': 8.5, 'tier': 'Nano', 'campaigns': 5, 'status': 'Pending'},
      {'name': 'David Park', 'username': 'travel_david', 'followers': 120000, 'engagementRate': 5.3, 'tier': 'Micro', 'campaigns': 15, 'status': 'Verified'},
    ];
  }

  void _viewInfluencerDetails(Map<String, dynamic> influencer) {
    Navigator.of(context).pushNamed('/influencer-detail', arguments: {'influencerId': 1});
  }

  void _manageInfluencer(Map<String, dynamic> influencer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage ${influencer['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Approve'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Reject'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.pause_circle, color: Colors.orange),
              title: const Text('Suspend'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}