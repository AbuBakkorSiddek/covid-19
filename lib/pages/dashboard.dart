import 'package:coid19tacker/Model/WorldStatesModel.dart';
import 'package:coid19tacker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'countries_list.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  final colorList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde52465),
  ];

  @override
  Widget build(BuildContext context) {

    StatesServices statesServices=StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),

              FutureBuilder(
                  future:statesServices.fcethWorldRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){

                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                      controller: _animationController,

                    ),);
                }else{
                  return  Column(
                    children: [

                      PieChart(
                          dataMap: {
                            "Total ": double.parse(snapshot.data!.cases.toString()),
                            "Recovery": double.parse(snapshot.data!.recovered.toString()),
                            "Death": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ) ,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions:
                          const LegendOptions(legendPosition: LegendPosition.left)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * .06,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                              ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReuseableRow(title: 'To Day Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReuseableRow(title: 'To Day Recovered', value: snapshot.data!.todayRecovered.toString()),

                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesList()));
                     },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(child: Text('Track Countires')),
                        ),
                      )

                    ],
                  );

                }


              }),

            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;

  ReuseableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
           SizedBox(
             height: 5,
           ),
          Divider(
          )

        ],
      ),
    );
  }
}
