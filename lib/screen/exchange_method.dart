import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/agent/agent.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_widget.dart';
import 'package:spinner_try/user_model.dart';

class ExchangeMethod extends StatefulWidget {
  final double height;
  final double width;
  final UserModel user;
  const ExchangeMethod(
      {super.key,
      required this.height,
      required this.width,
      required this.user});

  @override
  State<ExchangeMethod> createState() => _ExchangeMethodState();
}

class _ExchangeMethodState extends State<ExchangeMethod> {
  int? selectedIndex;
  final options = [
    {'diamonds': 96000, 'beans': 100000},
    {'diamonds': 9600, 'beans': 10000},
    {'diamonds': 960, 'beans': 1000},
    {'diamonds': 96, 'beans': 100},
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.extent(
            physics: const NeverScrollableScrollPhysics(),
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            shrinkWrap: true,
            children: List.generate(
              options.length,
              (index) {
                return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      color: selectedIndex == index
                          ? Colors.blue
                          : Colors.grey[100],
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/diamond.png',
                                  height: 20, width: 20),
                              Text(
                                options[index]['diamonds'].toString(),
                                style: TextStyle(
                                    fontSize: widget.height / 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/bean.png',
                                  height: 20, width: 20),
                              Text(
                                options[index]['beans'].toString(),
                                style: TextStyle(
                                    fontSize: widget.height / 50,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
          SizedBox(
            height: widget.height / 20,
          ),
          const Align(
              alignment: Alignment.center,
              child: Text("Daily exchange time: 10")),
          SizedBox(
            height: widget.height / 20,
          ),
          Align(
            alignment: Alignment.center,
            child: LoadingWidget(
              onPressed: _submit,
              loadingWidget: Container(
                height: widget.height / 15,
                width: widget.width / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.pink.withOpacity(0.3),
                ),
                child: const Center(
                  child: CircularProgressIndicatorRainbow(),
                ),
              ),
              child: Container(
                height: widget.height / 15,
                width: widget.width / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.pink,
                ),
                child: const Center(
                  child: Text(
                    "Exchange",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (selectedIndex == null) {
      showMsg(context, "Please select a package");
      return;
    }
    await agentBeansToDiamonds(
        widget.user.agentData!.id, options[selectedIndex!]['beans']!);
  }
}
