import 'package:flutter/material.dart';

class ExchangeMethod extends StatefulWidget {
  final double height;
  final double width;
  const ExchangeMethod({super.key, required this.height, required this.width});

  @override
  State<ExchangeMethod> createState() => _ExchangeMethodState();
}

class _ExchangeMethodState extends State<ExchangeMethod> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 50.0,
            mainAxisSpacing: 100.0,
            shrinkWrap: true,
            children: List.generate(
              2,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: Colors.grey[100]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.diamond,
                                color: Colors.pink,
                              ),
                              Text(
                                "96000",
                                style: TextStyle(
                                    fontSize: widget.height / 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            "₹10000",
                            style: TextStyle(
                                fontSize: widget.height / 50,
                                color: Colors.grey),
                          )
                        ],
                      )),
                );
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
        ],
      ),
    );
  }
}
