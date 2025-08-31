import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Events
abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentLocationRequested extends LocationEvent {}

class GetLocationFromAddressRequested extends LocationEvent {
  final String address;

  const GetLocationFromAddressRequested(this.address);

  @override
  List<Object?> get props => [address];
}

class GetAddressFromLocationRequested extends LocationEvent {
  final double latitude;
  final double longitude;

  const GetAddressFromLocationRequested({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

// States
abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationSuccess({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, address];
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetCurrentLocationRequested>(_onGetCurrentLocationRequested);
    on<GetLocationFromAddressRequested>(_onGetLocationFromAddressRequested);
    on<GetAddressFromLocationRequested>(_onGetAddressFromLocationRequested);
  }

  Future<void> _onGetCurrentLocationRequested(
    GetCurrentLocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(const LocationError('Location services are disabled.'));
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const LocationError('Location permissions are denied.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(const LocationError('Location permissions are permanently denied.'));
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition();
      
      emit(LocationSuccess(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _onGetLocationFromAddressRequested(
    GetLocationFromAddressRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    
    try {
      List<Location> locations = await locationFromAddress(event.address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        emit(LocationSuccess(
          latitude: location.latitude,
          longitude: location.longitude,
          address: event.address,
        ));
      } else {
        emit(const LocationError('Could not find location for the given address.'));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _onGetAddressFromLocationRequested(
    GetAddressFromLocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        event.latitude,
        event.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = [
          placemark.street,
          placemark.locality,
          placemark.administrativeArea,
          placemark.country,
        ].where((element) => element != null && element.isNotEmpty).join(', ');
        
        emit(LocationSuccess(
          latitude: event.latitude,
          longitude: event.longitude,
          address: address,
        ));
      } else {
        emit(LocationSuccess(
          latitude: event.latitude,
          longitude: event.longitude,
        ));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
} 