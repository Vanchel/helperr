import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:meta/meta.dart';

import '../../../data_layer/model/address.dart';

class AddressInputCubit extends Cubit<Address> {
  AddressInputCubit({@required Address initialValue})
      : assert(initialValue != null),
        super(initialValue);

  Timer _cooldown;

  Future<void> updateAddress(String locationName) async {
    _cooldown?.cancel();
    _cooldown = Timer(
      const Duration(milliseconds: 700),
      () async => await _updateAddress(locationName),
    );
  }

  Future<void> _updateAddress(String locationName) async {
    if (locationName?.isEmpty ?? true) {
      emit(Address.empty);
    }

    try {
      final locations =
          await geo.Geocoder.local.findAddressesFromQuery(locationName);
      final matchingLocation = locations.first;
      final address = Address(
        name: matchingLocation.addressLine,
        lat: matchingLocation.coordinates.latitude,
        lng: matchingLocation.coordinates.longitude,
      );
      emit(address);
    } on SocketException catch (_) {
      emit(state);
    } catch (_) {
      emit(Address.empty);
    }
  }
}
