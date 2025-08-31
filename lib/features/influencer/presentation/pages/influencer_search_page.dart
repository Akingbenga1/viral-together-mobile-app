import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_router.dart';
import '../../bloc/influencer_bloc.dart';
import '../widgets/influencer_card.dart';
import '../../domain/entities/influencer.dart';

class InfluencerSearchPage extends StatefulWidget {
  const InfluencerSearchPage({super.key});

  @override
  State<InfluencerSearchPage> createState() => _InfluencerSearchPageState();
}

class _InfluencerSearchPageState extends State<InfluencerSearchPage> {
  final _searchController = TextEditingController();
  String _selectedIndustry = 'All';
  String _selectedPlatform = 'All';
  double _selectedRadius = 10.0;

  final List<String> _industries = [
    'All',
    'Technology',
    'Fashion',
    'Food',
    'Travel',
    'Fitness',
    'Beauty',
    'Gaming',
    'Education',
  ];

  final List<String> _platforms = [
    'All',
    'Instagram',
    'TikTok',
    'YouTube',
    'Twitter',
    'LinkedIn',
  ];

  @override
  void initState() {
    super.initState();
    // Load initial search
    _performSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    context.read<InfluencerBloc>().add(
      SearchInfluencersRequested(
        industry: _selectedIndustry == 'All' ? null : _selectedIndustry,
        platform: _selectedPlatform == 'All' ? null : _selectedPlatform,
        radius: _selectedRadius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Search Influencers'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, location, or niche...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                _performSearch();
              },
            ),
          ),
          
          // Active Filters
          if (_selectedIndustry != 'All' || _selectedPlatform != 'All')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: [
                  if (_selectedIndustry != 'All')
                    Chip(
                      label: Text(_selectedIndustry),
                      onDeleted: () {
                        setState(() {
                          _selectedIndustry = 'All';
                        });
                        _performSearch();
                      },
                    ),
                  if (_selectedPlatform != 'All')
                    Chip(
                      label: Text(_selectedPlatform),
                      onDeleted: () {
                        setState(() {
                          _selectedPlatform = 'All';
                        });
                        _performSearch();
                      },
                    ),
                ],
              ),
            ),
          
          // Results
          Expanded(
            child: BlocBuilder<InfluencerBloc, InfluencerState>(
              builder: (context, state) {
                if (state is InfluencerLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is InfluencerSearchSuccess) {
                  if (state.influencers.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: AppTheme.textSecondary,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No influencers found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your search criteria',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: state.influencers.length,
                    itemBuilder: (context, index) {
                      final influencerData = state.influencers[index];
                      final influencer = Influencer.fromJson(influencerData);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: InfluencerCard(
                          influencer: influencer,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRouter.influencerDetail,
                              arguments: {'influencerId': influencer.id},
                            );
                          },
                        ),
                      );
                    },
                  );
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
                          'Error loading influencers',
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
                          onPressed: _performSearch,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndustry = 'All';
                        _selectedPlatform = 'All';
                        _selectedRadius = 10.0;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Industry Filter
              Text(
                'Industry',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedIndustry,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: _industries.map((industry) {
                  return DropdownMenuItem(
                    value: industry,
                    child: Text(industry),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIndustry = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Platform Filter
              Text(
                'Platform',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedPlatform,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: _platforms.map((platform) {
                  return DropdownMenuItem(
                    value: platform,
                    child: Text(platform),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPlatform = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Radius Filter
              Text(
                'Search Radius: ${_selectedRadius.toInt()} km',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Slider(
                value: _selectedRadius,
                min: 1.0,
                max: 100.0,
                divisions: 99,
                label: '${_selectedRadius.toInt()} km',
                onChanged: (value) {
                  setState(() {
                    _selectedRadius = value;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              
              // Apply Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    this.setState(() {});
                    _performSearch();
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 