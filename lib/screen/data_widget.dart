import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/agent/agent.dart';
import 'package:spinner_try/shivanshu/screens/in_dev_screen.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/user_model.dart';

class DataWidget extends StatefulWidget {
  final UserModel user;
  final double height;
  final double width;
  const DataWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.user});

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    double width = widget.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: width / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 56,
                      width: 56,
                      child: ProfileImage(user: widget.user)),
                  SizedBox(
                    width: width / 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "ID: ${widget.user.id}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/diamond.png',
                      height: height / 40, width: height / 40),
                  Text(
                    "${widget.user.agentData!.diamonds}",
                    style: TextStyle(
                        fontSize: height / 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: height / 20),
          Text(
            "Monthly credited volume",
            style:
                TextStyle(fontSize: height / 50, fontWeight: FontWeight.bold),
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
                child: LinearProgressIndicator(
                  // value: 0.5,
                  value: widget.user.agentData!.monthlyDiamonds / 100000000,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xffdc38f3)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.user.agentData!.monthlyDiamonds}/100000000",
                style: TextStyle(fontSize: height / 50),
              ),
              Image.asset('assets/diamond.png',
                  height: height / 40, width: height / 40),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment methods",
                style: TextStyle(fontSize: height / 40),
              ),
              InkWell(
                onTap: () {
                  navigatorPush(context, const InDevScreen());
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.indeterminate_check_box,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                    )
                  ],
                ),
              )
            ],
          ),
          const Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              if (widget.user.agentData!.paymentMethods.isEmpty)
                const Text('No Payment methods set yet')
              else
                for (int i = 0;
                    i < widget.user.agentData!.paymentMethods.length;
                    i++)
                  Container(
                    margin: EdgeInsets.only(right: width / 30),
                    child: Text(
                      widget.user.agentData!.paymentMethods[i],
                      style: TextStyle(fontSize: height / 50),
                    ),
                  ),
            ]),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Resellers",
                style: TextStyle(fontSize: height / 40),
              ),
              InkWell(
                onTap: () {
                  navigatorPush(context, const InDevScreen());
                },
                child: Text("Edit Reseller",
                    style:
                        TextStyle(fontSize: height / 50, color: Colors.green)),
              )
            ],
          ),
          const Divider(),
          FutureBuilder(
              future: fetchResellersOf(widget.user.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicatorRainbow(),
                  );
                }
                if (snapshot.hasError) {
                  return Text("Error fetching resellers: ${snapshot.error}");
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Text("You have no resellers yet");
                }
                return Expanded(
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
                );
              })
        ],
      ),
    );
  }
}
