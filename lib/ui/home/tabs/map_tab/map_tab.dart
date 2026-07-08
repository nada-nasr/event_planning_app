import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_styles.dart';


class MapTab extends StatefulWidget {

  static const String routeName = 'map_tab';

  const MapTab({super.key});


  @override
  State<MapTab> createState() => _MapTabState();

}


class _MapTabState extends State<MapTab> {

  GoogleMapController? googleMapController;

  final Set<Marker> markers = {};

  bool isLoading = true;

  String errorMessage = '';

  List<Event> events = [];

  LatLng initialCameraPosition = const LatLng(
      30.0444, 31.2357); // Initial map center (Suez)



  @override
  void initState() {
    super.initState();

    loadEvents();
  }


  @override

  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;

    var height = MediaQuery
        .of(context)
        .size
        .height;

    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(

      body: Stack(

        children: [

          Positioned.fill(

            child: GoogleMap(

              zoomControlsEnabled: false,

              markers: markers,

              onMapCreated: (controller) {
                googleMapController = controller;
              },

              initialCameraPosition: CameraPosition(

                target: initialCameraPosition,

                zoom: 14,

              ),

            ),

          ),

          Positioned(

            top: 16,

            right: 16,

            child: IconButton(

              style: ButtonStyle(

                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)))

              ),

              onPressed: () {},

              icon: themeProvider.currentTheme == ThemeMode.light

                  ? Image.asset(AppAssets.locationIcon)

                  : Image.asset(AppAssets.locationIconDark),

            ),

          ),

          if (isLoading)

            const Center(

              child: CircularProgressIndicator(),

            ),

          if (errorMessage.isNotEmpty)

            Center(

              child: Text(

                errorMessage,

                style: const TextStyle(color: Colors.red),

              ),

            ),

          Align(

            alignment: Alignment.bottomCenter,

            child: Padding(

              padding: EdgeInsets.only(bottom: height * 0.06),

              child: SizedBox(

                height: height * 0.15,

                child: ListView.builder(

                  scrollDirection: Axis.horizontal,

                  itemCount: events.length,

                  itemBuilder: (context, index) {
                    final event = events[index];

                    return Padding(

                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),

                      child: Container(

                        clipBehavior: Clip.antiAlias,

                        decoration: BoxDecoration(

                            color: AppColors.whiteColor,

                            borderRadius: BorderRadius.circular(16),

                            border: Border.all(color: AppColors.primaryLight)

                        ),

                        child: InkWell(

                          onTap: () {
// move to the event's location

                            googleMapController?.animateCamera(

                              CameraUpdate.newLatLng(

                                  LatLng(event.latitude!, event.longitude!)),

                            );

                            final marker = markers.firstWhere(

                                    (m) => m.markerId.value == event.id);

                            marker.infoWindow;
                          },

                          child: Container(

                              padding: EdgeInsets.symmetric(

                                  horizontal: width * 0.02,

                                  vertical: height * 0.02

                              ),

                              width: width * 0.85,

                              child: Row(

                                  children: [

                                    Container(

                                      clipBehavior: Clip.antiAlias,

                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(8),

                                      ),

                                      child: Image.asset(event.image,

                                        width: width * 0.40,

                                        height: height * 0.12,

                                        fit: BoxFit.fill,),

                                    ),

                                    SizedBox(width: width * 0.02),

                                    Expanded(

                                      child: Column(

                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,

                                          children: [

                                            Text(

                                              event.description,

                                              style: AppStyles.bold14Primary,

                                              maxLines: 2,

                                              softWrap: true,

                                              overflow: TextOverflow.ellipsis,

                                            ),

                                            Expanded(

                                              child: Row(

                                                children: [

                                                  Icon(Icons.location_on,

                                                      size: 20,

                                                      color: themeProvider
                                                          .currentTheme ==
                                                          ThemeMode.light

                                                          ? AppColors.blackColor

                                                          : AppColors
                                                          .whiteColor),

                                                  SizedBox(width: width * 0.01),

                                                  Flexible(

                                                    child: Text(

                                                      event.locationName ??
                                                          'Location Unknown',

                                                      style: themeProvider
                                                          .currentTheme ==
                                                          ThemeMode.light

                                                          ? AppStyles
                                                          .medium14black

                                                          : AppStyles
                                                          .medium14white,

                                                      maxLines: 1,

                                                      softWrap: true,

                                                    ),

                                                  ),

                                                ],

                                              ),

                                            ),


                                          ]),

                                    )

                                  ])

                          ),

                        ),

                      ),

                    );
                  },

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }


  Future<void> loadEvents() async {
    setState(() {
      isLoading = true;

      errorMessage = '';

      events.clear();

      markers.clear();
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final eventsCollection = FirebaseUtils.getEventsCollection(user.uid);

        final snapshot = await eventsCollection.get();


        if (snapshot.docs.isNotEmpty) {
          for (final doc in snapshot.docs) {
            final event = doc.data().copyWith(id: doc.id);

            if (event.latitude != null && event.longitude != null) {
              events.add(event);

              markers.add(

                Marker(

                  markerId: MarkerId(event.id),

                  position: LatLng(event.latitude!, event.longitude!),

                  infoWindow: InfoWindow(title: event.eventName),

                ),

              );
            }
          }

          if (events.isNotEmpty) {
            initialCameraPosition =
                LatLng(events.first.latitude!, events.first.longitude!);
          }
        }
      } else {
        setState(() {
          errorMessage = 'User not logged in.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load events: $e';
      });

      print('Error loading events: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

}