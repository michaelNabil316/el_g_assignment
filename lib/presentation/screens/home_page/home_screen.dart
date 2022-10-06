import 'package:assignment/bussiness_logic/app_bloc/bloc.dart';
import 'package:assignment/bussiness_logic/app_bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/CustomDropdownButton.dart';
import '../../components/custom_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static late double w, h;
  String from = "USD";
  String to = "PHP";

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final appBloc = BlocProvider.of<AppBloc>(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: const CustomAppBar(title: "Global currency"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("value:${appBloc.convertedValue}"),
                  SizedBox(
                    width: w - w / 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w / 40),
                          child: Text('From'),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: w - w / 20,
                          child: CustomDropdownButton(
                            items: appBloc.countries
                                .map((element) => DropdownMenuItem(
                                      child: Text(
                                        element.name,
                                      ),
                                      value: element.code,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                from = value;
                              });
                            },
                            selectedValue: from,
                            enabled: true,
                            iconSize: h / 35,
                            text: appBloc.availlableCountriesState == null
                                ? "Loading.."
                                : "choose",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [SizedBox(height: 10)],
                  ),
                  SizedBox(
                    width: w - w / 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w / 40),
                          child: Text('To'),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: w - w / 20,
                          child: CustomDropdownButton(
                            items: appBloc.countries
                                .map((element) => DropdownMenuItem(
                                      child: Text(
                                        element.name,
                                      ),
                                      value: element.code,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                from = value;
                              });
                            },
                            selectedValue: to,
                            enabled: true,
                            iconSize: h / 35,
                            text: appBloc.availlableCountriesState == null
                                ? "Loading.."
                                : "choose",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
