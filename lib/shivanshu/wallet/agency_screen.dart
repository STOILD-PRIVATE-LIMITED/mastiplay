import 'package:flutter/material.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/wallet/exchange_screen.dart';
import 'package:spinner_try/user_model.dart';

class AgencyScreen extends StatefulWidget {
  final int maxBeans;
  const AgencyScreen({super.key, required this.maxBeans});

  @override
  State<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  int? agentId;
  int? beanCount;
  final _agentIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final int bean5Count = (beanCount ?? 0) * 5 ~/ 100;
    final int totalBeans = (beanCount ?? 0) - bean5Count;
    return SingleChildScrollView(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (beanCount == null || agentId == null)
                  TextField(
                    controller: _agentIdController,
                    style: textTheme(context).titleLarge!.copyWith(
                          color: colorScheme(context).onPrimary,
                        ),
                    decoration: InputDecoration(
                      hintText: "Enter Agency id",
                      hintStyle: textTheme(context).titleLarge!.copyWith(
                            color: colorScheme(context).onPrimary,
                          ),
                      suffixIcon: Image.asset('assets/search.png'),
                      fillColor: Colors.grey,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                Text(
                  ' *when you transfer in agent id they deducted 5 %',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
                ),
                if (agentId != null)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 3.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          trailing: IconButton.filled(
                            onPressed: () {
                              showMsg(context, 'Chat');
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.white,
                              iconSize: 15,
                            ),
                            icon: const Icon(Icons.chat_rounded),
                          ),
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 22,
                              ),
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/dummy_person.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green,
                                  ),
                                  child: Text(
                                    'Online',
                                    style:
                                        textTheme(context).bodySmall!.copyWith(
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title:
                              const Expanded(child: Text('🐉Mr Maverick...')),
                          isThreeLine: true,
                          subtitle: const Expanded(
                            child: Wrap(
                              children: [
                                Text('Deal of last 30 days'),
                                Icon(
                                  Icons.attach_money_outlined,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                Text('618.52M'),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Text('Payment method:'),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  showMsg(context, "gpay");
                                },
                                child: Image.asset(
                                  'assets/gpay.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  showMsg(context, "paytm");
                                },
                                child: Image.asset(
                                  'assets/paytm.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  showMsg(context, "phonepe");
                                },
                                child: Image.asset(
                                  'assets/phonepe.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const Wrap(
                          children: [
                            Text('Available'),
                            DiamondText(txt: 'Recharge 769,821'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (beanCount != null)
                          Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  onChanged: (val) {
                                    setState(() {
                                      beanCount = int.tryParse(val) ?? 0;
                                    });
                                  },
                                  style: textTheme(context)
                                      .titleLarge!
                                      .copyWith(
                                        color: colorScheme(context).onPrimary,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: "Enter beans",
                                    hintStyle: textTheme(context)
                                        .titleLarge!
                                        .copyWith(
                                          color: colorScheme(context).onPrimary,
                                        ),
                                    suffixIcon:
                                        Image.asset('assets/search.png'),
                                    fillColor: Colors.grey,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Beans to Transfer"),
                                        Text("5% beans deducted"),
                                        Text("Total received beans"),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(beanCount.toString()),
                                        Text(bean5Count.toString()),
                                        Text(totalBeans.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 224, 93, 211),
                                  foregroundColor:
                                      colorScheme(context).onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              onPressed: () {
                                if (beanCount != null) {
                                  if ((beanCount ?? 0) > widget.maxBeans) {
                                    showMsg(context,
                                        'You don\'t have enough beans!');
                                  }
                                  showMsg(context, "Transfered!!!");
                                } else {
                                  setState(() {
                                    beanCount = 0;
                                  });
                                }
                              },
                              child: Text(
                                'Transfer Points',
                                style: textTheme(context).titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme(context).onPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
            if (agentId == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 224, 93, 211),
                      foregroundColor: colorScheme(context).onPrimary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    print(_agentIdController.text);
                    setState(() {
                      agentId =
                          int.tryParse(_agentIdController.text.toString());
                    });
                  },
                  child: Text(
                    'WITHDRAW',
                    style: textTheme(context).titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).onPrimary,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AgentTile extends StatelessWidget {
  final bool showPaymentMethod;
  final UserModel user;
  const AgentTile({
    super.key,
    this.showPaymentMethod = true,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            trailing: IconButton.filled(
              onPressed: () {
                showChatWithUserId(user.id!, context);
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                iconSize: 15,
              ),
              icon: const Icon(Icons.chat_rounded),
            ),
            leading: SizedBox(
              width: 56,
              height: 56,
              child: ProfileImage(user: user),
            ),
            title: Text(user.name),
            isThreeLine: true,
            subtitle: Wrap(
              children: [
                const Text('Deal of last 30 days'),
                const Icon(
                  Icons.attach_money_outlined,
                  size: 14,
                  color: Colors.amber,
                ),
                if (user.agentData != null)
                  Text('${user.agentData!.monthlyDiamonds}'),
              ],
            ),
          ),
          if (showPaymentMethod && user.agentData != null) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text('Payment method:'),
                  for (int i = 0;
                      i < user.agentData!.paymentMethods.length;
                      ++i) ...[
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        showMsg(context, user.agentData!.paymentMethods[i]);
                      },
                      child: Image.asset(
                        'assets/${user.agentData!.paymentMethods[i]}.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Divider(),
            const Wrap(
              children: [
                Text('Available'),
                DiamondText(txt: 'Recharge 769,821'),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
