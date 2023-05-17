import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobideliv/core/router/router.gr.dart';

import '../../../carte/data/cubit/service/service_bloc.dart';
import '../../../carte/data/cubit/service/service_event.dart';
import '../../../carte/data/cubit/service/service_state.dart';
import '../../data/repository/service_repo.dart';

class AmbulantInformation extends StatelessWidget {
  AmbulantInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ServiceBloc(
            serviceRepository: ServiceRepository()
          )..add(GetAmbulant()),
        child: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ServiceLoaded) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.mydata.length,
                itemBuilder: (context, index) {
                  final service = state.mydata[index];
                  return InkWell(
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              children: [
                                Image.asset(
                                  '${service.img}',
                                  height: MediaQuery.of(context).size.height * 0.10,
                                ),
                                Text(
                                  service.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: "Spartan"
                                  ),
                                ),

                                Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        const Icon(
                                            Icons.star,
                                            color: Colors.yellow
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            "${service.rate!.toInt() / 10}/5",
                                            style: const TextStyle(
                                                fontFamily: "Spartan"
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]



                          ),
                        ),
                      ),
                      onTap: () {
                        AutoRouter.of(context).push(AmbulantDetailRoute(commercant: service));
                      }
                  );
                });
          } else {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
        })
    );
  }
}
