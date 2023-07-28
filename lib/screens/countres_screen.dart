import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_zone/data/cubits/countries_cubit/countires_cubit.dart';

class MySports extends StatefulWidget {
  const MySports({super.key});

  @override
  State<MySports> createState() => _MySportsState();
}

class _MySportsState extends State<MySports> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CountiresCubit>().getCountiers();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 78, 84, 200),
                      Color.fromARGB(255, 67, 72, 169),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Countires',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 4 / 5,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(246, 241, 248, 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * .08),
                              child:
                                  BlocBuilder<CountiresCubit, CountiresState>(
                                builder: (context, state) {
                                  // if (state is CountiresInitial) {
                                  //   context
                                  //       .read<CountiresCubit>()
                                  //       .getCountiers();
                                  // } else
                                  if (state is CountiresLoadind) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is CountiresSussess)
                                    // ignore: curly_braces_in_flow_control_structures
                                    return GridView.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 50,
                                      crossAxisSpacing: 50,
                                      children: <Widget>[
                                        for (int i = 0;
                                            i <
                                                state
                                                    .ourresponse.result!.length;
                                            i++)
                                          if (state.ourresponse.result![i]
                                                  .countryLogo !=
                                              null)
                                            Container(
                                              height: 60,
                                              width: 60,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Column(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: state
                                                            .ourresponse
                                                            .result![i]
                                                            .countryLogo ??
                                                        'https://th.bing.com/th?id=OIP.SxfHLBiDEPcSBV-ncmz7gQHaJR&w=223&h=279&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    state.ourresponse.result![i]
                                                            .countryName ??
                                                        '555555555555555',
                                                    style: const TextStyle(
                                                        color: Colors.orange),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      ],
                                    );
                                  else {
                                    return const Center(
                                      child: Text('error'),
                                    );
                                  }
                                },
                              ),
                            ))),
                  ],
                ))));
  }
}
