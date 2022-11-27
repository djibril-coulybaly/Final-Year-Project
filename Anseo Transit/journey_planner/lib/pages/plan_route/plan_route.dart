/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: plan_route.dart
  Description: This file allows the user to plan a route between two locations using multiple modes of transportation.
               Due to time contraints, I wasnt able to implement OpenTripPlanner API on my onw. Instead I made use of 
               Trufi Core - an open-source NGO organisation who specialise in providing Journey Planning and real 
               time information application in developing countries worldwide.

               After completing this project I've learned a lot about server-side data retrieval and with the wealth of 
               knowledge that I've gained, I feel more confident in designing my own layout and style for the 
               journey planner in the near future, as opposed to relying on an external codebase.

               Note: While the application works on it's own as a standalone application/class, when I've merged it with the 
               rest of the application, the searching of locations doesnt seem to work. I've gotten an error stating that 
               theres a conflict of providers being used by Trufi and by my application. Therefore I've included the 
               plan_route.dart as a single application in the submission so that it can still be assessed.

               The link to the code used is available from the following GitHub page: https://github.com/trufi-association/trufi-core
*/
// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';
import 'package:trufi_core/base/widgets/drawer/menu/social_media_item.dart';
import 'package:trufi_core/default_values.dart';
import 'package:trufi_core/trufi_core.dart';
import 'package:trufi_core/trufi_router.dart';

class PlanRoute extends StatefulWidget {
  const PlanRoute({Key? key}) : super(key: key);

  @override
  State<PlanRoute> createState() => _PlanRouteState();
}

class _PlanRouteState extends State<PlanRoute> {
  @override
  Widget build(BuildContext context) {
    return TrufiApp(
      appNameTitle: 'ExampleApp',
      blocProviders: [
        ...DefaultValues.blocProviders(
          otpEndpoint: "http://172.19.0.1:8080/otp/routers/default",
          otpGraphqlEndpoint:
              "http://172.19.0.1:8080/otp/routers/default/index/graphql",
          mapConfiguration: MapConfiguration(
            // defaultZoom: 200.0,
            center: LatLng(53.348288, -6.259634),
          ),
          photonUrl: "http://172.19.0.1:8080/photon",
          searchAssetPath: '',
        ),
      ],
      trufiRouter: TrufiRouter(
        routerDelegate: DefaultValues.routerDelegate(
          appName: 'ExampleApp',
          cityName: 'City',
          countryName: 'Country',
          backgroundImageBuilder: (_) {
            return Image.asset(
              'assets/images/drawer-bg.jpg',
              fit: BoxFit.cover,
            );
          },
          urlFeedback: 'https://example/feedback',
          emailContact: 'example@example.com',
          urlShareApp: 'https://example/share',
          urlSocialMedia: const UrlSocialMedia(
            urlFacebook: 'https://www.facebook.com/Example',
          ),
        ),
      ),
    );
  }
}
