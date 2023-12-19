import 'package:flutter/material.dart';
import 'package:spinner_try/screen/about.dart';
import 'package:spinner_try/screen/acc_info.dart';
import 'package:spinner_try/screen/agency_center.dart';
import 'package:spinner_try/screen/agent.dart';
import 'package:spinner_try/screen/creator_page.dart';
import 'package:spinner_try/screen/help_form.dart';
import 'package:spinner_try/screen/inv_friends.dart';
import 'package:spinner_try/screen/moments.dart';
import 'package:spinner_try/screen/nobel_center.dart';
import 'package:spinner_try/screen/setting.dart';
import 'package:spinner_try/screen/store.dart';
import 'package:spinner_try/shivanshu/profile_screens/family_screen.dart';
import 'package:spinner_try/shivanshu/screens/wallet_screen.dart';
import 'package:spinner_try/shivanshu/user_level/user_level_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              MyColumn(
                children: [
                  ListTile(
                    leading: Container(
                      width: 50.sp,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset('assets/dummy_person.png'),
                    ),
                    title: const Text(
                      '🔥nikku jaaf...',
                      style: TextStyle(
                        fontSize: 20,
                        // color: Colors.black26,
                      ),
                    ),
                    subtitle: MyRow(
                      children: [
                        const Text(
                          'ID 1222333454345',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black26,
                          ),
                        ),
                        InkWell(
                          child: const Icon(Icons.share_rounded, size: 10),
                          onTap: () {
                            showMsg(context, 'Share');
                          },
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      showMsg(context, "Hehe");
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: const MyColumn(
                          children: [
                            Text(
                              '9889',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          showMsg(context, "Hehe");
                        },
                      ),
                      InkWell(
                        child: const MyColumn(
                          children: [
                            Text(
                              '9889',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          showMsg(context, "Hehe");
                        },
                      ),
                      InkWell(
                        child: const MyColumn(
                          children: [
                            Text(
                              '7',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Friends',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          showMsg(context, "Hehe");
                        },
                      ),
                      InkWell(
                        child: const MyColumn(
                          children: [
                            Text(
                              '9889',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Channel',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          showMsg(context, "Hehe");
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  navigatorPush(context, const WalletScreen());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Wallet'),
              ),
              ListTile(
                onTap: () {
                  navigatorPush(context, const Agent());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Agent'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NobelCenter()));
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('VIP Center'),
              ),
              ListTile(
                onTap: () {
                  navigatorPush(context, const NobelCenter());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Noble Center'),
              ),
              ListTile(
                onTap: () {
                  navigatorPush(context, const AgencyCenter());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Agency Center'),
              ),
              ListTile(
                onTap: () {
                  navigatorPush(context, const CreatorPage());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Creator Center'),
              ),
              ListTile(
                onTap: () {
                  navigatorPush(context, const Store());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Privilege Bag'),
              ),
              ListTile(
                onTap: () {
                  navigatorPush(context, const FamilyScreen());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Family'),
              ),
              ListTile(
                onTap: () {
                  navigatorPush(context, const UserLevelPage());
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('User level center'),
              ),
              ListTile(
                onTap: () {
                  showMsg(context, 'Show some screen here');
                },
                leading: Image.asset(
                  'assets/diamond.png',
                  width: 20,
                ),
                title: const Text('Bind Agency'),
              ),
              const Divider(),
              GridView.extent(
                maxCrossAxisExtent: 100,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      navigatorPush(context, const InviteFriends());
                    },
                    child: const MyColumn(
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          color: Colors.amber,
                        ),
                        Text('Invite'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigatorPush(context, const Moments());
                    },
                    child: MyColumn(
                      children: [
                        Image.asset("assets/heart.png"),
                        const Text('Moment'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigatorPush(context, const AccountInformation());
                    },
                    child: const MyColumn(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        Text('Account Info'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // navigatorPush(context, );
                    },
                    child: MyColumn(
                      children: [
                        Image.asset("assets/star.png"),
                        const Text('Events'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigatorPush(context, const Setting());
                    },
                    child: const MyColumn(
                      children: [
                        Icon(
                          Icons.settings_rounded,
                          color: Colors.green,
                        ),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigatorPush(context, const HelpForm());
                    },
                    child: const MyColumn(
                      children: [
                        Icon(
                          Icons.help,
                          color: Colors.amber,
                        ),
                        Text('Help'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigatorPush(context, const About());
                    },
                    child: const MyColumn(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.green,
                        ),
                        Text('About'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
