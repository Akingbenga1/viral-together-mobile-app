import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_router.dart';
import '../../bloc/location_bloc.dart';
import '../../../influencer/bloc/influencer_bloc.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final _searchController = TextEditingController();
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  double _selectedRadius = 10.0;
  bool _isMapView = true;

  // Default location (New York City)
  static const LatLng _defaultLocation = LatLng(40.7128, -74.0060);

  @override
  void initState() {
    super.initState();
    // Get current location on init
    context.read<LocationBloc>().add(GetCurrentLocationRequested());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    // Update search radius based on zoom level
    // This is a simplified implementation
  }

  void _searchByLocation() {
    // Get the center of the map
    _mapController?.getVisibleRegion().then((bounds) {
      if (bounds != null) {
        final center = LatLng(
          (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
          (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
        );
        
        context.read<InfluencerBloc>().add(
          SearchInfluencersRequested(
            latitude: center.latitude,
            longitude: center.longitude,
            radius: _selectedRadius,
          ),
        );
      }
    });
  }

  void _searchByAddress() {
    if (_searchController.text.trim().isNotEmpty) {
      context.read<LocationBloc>().add(
        GetLocationFromAddressRequested(_searchController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Location Search'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(_isMapView ? Icons.list : Icons.map),
            onPressed: () {
              setState(() {
                _isMapView = !_isMapView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter address or location...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.my_location),
                        onPressed: () {
                          context.read<LocationBloc>().add(GetCurrentLocationRequested());
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (value) => _searchByAddress(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchByAddress,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          
          // Radius Slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Radius: ${_selectedRadius.toInt()} km',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
              ],
            ),
          ),
          
          // Map or List View
          Expanded(
            child: _isMapView ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationSuccess) {
          _updateMapLocation(state.latitude, state.longitude);
          _searchByLocation();
        } else if (state is LocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        onCameraMove: _onCameraMove,
        initialCameraPosition: const CameraPosition(
          target: _defaultLocation,
          zoom: 12,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
      ),
    );
  }

  Widget _buildListView() {
    return BlocBuilder<InfluencerBloc, InfluencerState>(
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
                    Icons.location_off,
                    size: 64,
                    color: AppTheme.textSecondary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No influencers found in this area',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Try adjusting the search radius or location',
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
              final influencer = state.influencers[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Text(
                      _getInitials(
                        influencer['user']['first_name'],
                        influencer['user']['last_name'],
                      ),
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    '${influencer['user']['first_name']} ${influencer['user']['last_name']}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('@${influencer['user']['username']}'),
                      Text(
                        '${_formatNumber(influencer['follower_count'])} followers • ${influencer['engagement_rate']}% engagement',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRouter.influencerDetail,
                      arguments: {'influencerId': influencer['id']},
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
                  onPressed: _searchByLocation,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        return const Center(
          child: Text('Search for influencers by location'),
        );
      },
    );
  }

  void _updateMapLocation(double latitude, double longitude) {
    final newLocation = LatLng(latitude, longitude);
    
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(newLocation, 12),
    );
    
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: newLocation,
          infoWindow: const InfoWindow(title: 'Current Location'),
        ),
      };
    });
  }

  String _getInitials(String firstName, String lastName) {
    return '${firstName[0]}${lastName[0]}'.toUpperCase();
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