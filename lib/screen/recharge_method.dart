import 'package:flutter/material.dart';

class RechargeMethod extends StatefulWidget {
  final double height;
  final double width;
  const RechargeMethod({super.key, required this.height, required this.width});

  @override
  State<RechargeMethod> createState() => _RechargeMethodState();
}

class _RechargeMethodState extends State<RechargeMethod> {
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
                  "Transfer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.height / 20,
          ),
          DataTable(
            columnSpacing: 10,
            border: TableBorder.symmetric(
              inside: BorderSide(
                width: 1,
                color: Colors.grey[200]!,
              ),
            ),
            columns: [
              DataColumn(
                label: Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    child: const Text(
                      'Purchasing Amount',
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    child: const Text(
                      'Offline gem Price',
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('x <= ₹10000')),
                  DataCell(
                    Text(
                      '₹100 = 9600 gem',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('₹10000 < x <= ₹20000')),
                  DataCell(Text(
                    '₹100 = 9800 gem',
                    style: TextStyle(color: Colors.yellow),
                  )),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('x > ₹20000')),
                  DataCell(Text(
                    '₹100 = 10000 gem',
                    style: TextStyle(color: Colors.yellow),
                  )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
