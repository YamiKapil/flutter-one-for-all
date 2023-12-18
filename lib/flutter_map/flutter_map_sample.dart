import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '/widgets/custom_appbar.dart';

// import '/models/client_branch.dart';

/* 
This screen shows the branch location in map
 */
class ClientBranchMapScreen extends StatefulWidget {
  const ClientBranchMapScreen({super.key});

  // final Data branch;

  @override
  State<ClientBranchMapScreen> createState() => _ClientBranchMapScreenState();
}

class _ClientBranchMapScreenState extends State<ClientBranchMapScreen> {
  late GoogleMapController _googleMapController;

  final Completer<GoogleMapController> _completer = Completer();

  @override
  void initState() {
    _addMarker();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  final Set<Marker> _marker = {};

  _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    _completer.complete(controller);
  }

  // ignore: unused_element
  _onCameraUpdate(LatLng pos) async {
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: pos,
          zoom: 18,
        ),
      ),
    );
  }

  _addMarker() {
    // _onCameraUpdate(LatLng(37.42796133580664, -122.085749655962));
    // _marker.add(
    //   Marker(
    //     markerId: MarkerId(
    //       widget.branch.id.toString(),
    //     ),
    //     infoWindow: InfoWindow(
    //       title: widget.branch.branchName,
    //     ),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(
    //       BitmapDescriptor.hueRed,
    //     ),
    //     position: LatLng(
    //       widget.branch.latitude!,
    //       widget.branch.longitude!,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: widget.branch.branchName!,
      // ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 17,
        ),
        markers: _marker,
      ),
    );
  }
}
