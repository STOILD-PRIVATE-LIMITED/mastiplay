import 'package:flutter/material.dart';

class DataWidget extends StatefulWidget {
  final double height;
  final double width;
  const DataWidget({super.key, required this.height, required this.width});

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    double width = widget.width;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: height / 20, horizontal: width / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.abc),
                  SizedBox(
                    width: width / 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "SR",
                        style: TextStyle(
                            fontSize: height / 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "data",
                        style: TextStyle(
                          fontSize: height / 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.diamond,
                    color: Colors.pink,
                  ),
                  Text(
                    "CoinSeller",
                    style: TextStyle(
                        fontSize: height / 50, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.question_mark,
                    size: height / 40,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: height / 20,
          ),
          Text(
            "Monthly credited volume",
            style:
                TextStyle(fontSize: height / 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height / 20,
          ),
          Row(
            children: [
              const Icon(Icons.biotech),
              Container(
                width: width / 1.4,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey),
                ),
                child: const LinearProgressIndicator(
                  value: .75,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const Icon(Icons.abc)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "93789379/100000000",
                style: TextStyle(fontSize: height / 50),
              ),
              const Icon(
                Icons.diamond_rounded,
                color: Colors.pink,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment method",
                style: TextStyle(fontSize: height / 50),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.indeterminate_check_box,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Reseller",
                style: TextStyle(fontSize: height / 40),
              ),
              Text("Edit Reseller",
                  style: TextStyle(fontSize: height / 50, color: Colors.green))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Person Name"),
                      subtitle: Text(
                        "ID: 123456789",
                        style: TextStyle(
                            fontSize: height / 50, color: Colors.grey),
                      ),
                      trailing: const Icon(Icons.chat),
                    ),
                    Text(
                      "Sales volume (this month): 0",
                      style: TextStyle(fontSize: height / 50),
                    ),
                    const Divider()
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
