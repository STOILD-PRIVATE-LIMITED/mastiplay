import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class BeanAgentTransferScreen extends StatelessWidget {
  const BeanAgentTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 100,
        itemBuilder: (context, index) {
          final failed = Random().nextBool();
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${failed ? '+' : '-'}1000'),
                  if (!failed)
                    Card(
                      elevation: 0,
                      color: Colors.green.withOpacity(0.1),
                      child: const MyRow(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                            size: 15,
                          ),
                          Text(
                            'Success',
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  else
                    Card(
                      elevation: 0,
                      color: Colors.red.withOpacity(0.1),
                      child: MyRow(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          const Text(
                            'Refunded',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              subtitle: MyColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Total ${failed ? 1000 : 950} beans ${failed ? 'refunded' : 'transferred'}'),
                  if (!failed) const Text('50 beans service charge'),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
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
                              style: textTheme(context).bodySmall!.copyWith(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: const Text('Agent'),
                    subtitle: const Text('id 545456456'),
                  ),
                  Text(
                    DateTime.now()
                        .toIso8601String()
                        .replaceRange(19, null, '')
                        .replaceFirst('T', ' '),
                    style: const TextStyle(
                      color: Colors.black26,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
