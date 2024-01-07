import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/screen/about.dart';
import 'package:spinner_try/screen/agency_center.dart';
import 'package:spinner_try/screen/agent_panel.dart';
import 'package:spinner_try/screen/creator_page.dart';
import 'package:spinner_try/screen/help_form.dart';
import 'package:spinner_try/screen/inv_friends.dart';
import 'package:spinner_try/screen/nobel_center.dart';
import 'package:spinner_try/screen/profile_edit.dart';
import 'package:spinner_try/screen/setting.dart';
import 'package:spinner_try/screen/store.dart';
import 'package:spinner_try/shivanshu/admin_panel/admin_panel.dart';
import 'package:spinner_try/shivanshu/models/agency/agency.dart';
import 'package:spinner_try/shivanshu/models/agent/agent.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/settings.dart';
import 'package:spinner_try/shivanshu/moments/followers_screen.dart';
import 'package:spinner_try/shivanshu/moments/following_screen.dart';
import 'package:spinner_try/shivanshu/moments/friends_screen.dart';
import 'package:spinner_try/shivanshu/profile_screens/family_screen.dart';
import 'package:spinner_try/shivanshu/screens/bind_agency.dart';
import 'package:spinner_try/shivanshu/screens/my_posts.dart';
import 'package:spinner_try/shivanshu/screens/wallet_screen.dart';
import 'package:spinner_try/shivanshu/user_level/user_level_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/user_model.dart';

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
                  FutureBuilder(
                      future: fetchUserWithId(currentUser.id!),
                      builder: (context, snapshot) {
                        currentUser = snapshot.data ?? currentUser;
                        return ListTile(
                          contentPadding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          leading: Container(
                            width: 50.sp,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: ProfileImage(user: currentUser),
                          ),
                          title: Text(
                            currentUser.name,
                            style: const TextStyle(
                              fontSize: 20,
                              // color: Colors.black26,
                            ),
                          ),
                          subtitle: MyRow(
                            children: [
                              Text(
                                'ID ${currentUser.id}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black26,
                                ),
                              ),
                              InkWell(
                                child:
                                    const Icon(Icons.share_rounded, size: 10),
                                onTap: () {
                                  shareLink(
                                      "mastiplay.com/users/${currentUser.id}");
                                },
                              ),
                            ],
                          ),
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          onTap: () {
                            navigatorPush(context, const ProfileEdit());
                          },
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: MyColumn(
                          children: [
                            Text(
                              currentUser.followers.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          navigatorPush(context, const FollowersScreen());
                        },
                      ),
                      InkWell(
                        child: MyColumn(
                          children: [
                            Text(
                              currentUser.following.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Following',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          navigatorPush(context, const FollowingScreen());
                        },
                      ),
                      InkWell(
                        child: MyColumn(
                          children: [
                            Text(
                              currentUser.friends.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Friends',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          navigatorPush(context, const FriendsScreen());
                        },
                      ),
                      // InkWell(
                      //   child: const MyColumn(
                      //     children: [
                      //       Text(
                      //         '9889',
                      //         style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       Text(
                      //         'Channel',
                      //         style: TextStyle(
                      //           fontSize: 12,
                      //           color: Colors.black26,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   onTap: () {
                      //     showMsg(context, "Hehe");
                      //   },
                      // ),
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
              if (currentUser.agentId != null)
                FutureBuilder(
                    future: fetchAgentData(currentUser.id!),
                    builder: (context, snapshot) {
                      final loading =
                          snapshot.connectionState == ConnectionState.waiting;
                      final userData = snapshot.data;
                      return ListTile(
                        onTap: loading || userData == null
                            ? null
                            : () {
                                currentUser.agentData = userData.agentData;
                                navigatorPush(
                                    context, AgentPanel(user: currentUser));
                              },
                        leading: loading
                            ? const CircularProgressIndicatorRainbow()
                            : Image.asset(
                                'assets/diamond.png',
                                width: 20,
                              ),
                        title: Text(
                          userData == null && !loading
                              ? "Can't reach the server right now"
                              : 'Agent',
                          style: TextStyle(
                              color: userData == null && !loading
                                  ? Colors.red
                                  : (loading ? Colors.black45 : Colors.black)),
                        ),
                      );
                    }),
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
              FutureBuilder(
                future: getAgencyData(userId: currentUser.id!),
                builder: (context, snapshot) {
                  final loading =
                      snapshot.connectionState == ConnectionState.waiting;
                  final agencyData = snapshot.data;
                  if (agencyData != null) {
                    if (agencyData.owner == currentUser.id) {
                      currentUser.ownedAgencyData = agencyData;
                    } else {
                      currentUser.joinedAgencyData = agencyData;
                    }
                    PrefStorage.hasAgency = true;
                  }
                  if (loading) {
                    return const ListTile(
                      onTap: null,
                      leading: CircularProgressIndicatorRainbow(),
                      title: Text(
                        'Loading...',
                        style: TextStyle(color: Colors.black45),
                      ),
                    );
                  }
                  // if (snapshot.hasError) {
                  //   return ListTile(
                  //     onTap: null,
                  //     leading: Image.asset(
                  //       'assets/diamond.png',
                  //       width: 20,
                  //     ),
                  //     title: const Text(
                  //       "Network Error",
                  //       style: TextStyle(color: Colors.red),
                  //     ),
                  //   );
                  // }
                  if (agencyData == null) {
                    return ListTile(
                      onTap: () {
                        navigatorPush(context, const BindAgency());
                      },
                      leading: Image.asset(
                        'assets/diamond.png',
                        width: 20,
                      ),
                      title: const Text('Bind Agency'),
                    );
                  }
                  if (currentUser.ownedAgencyData != null) {
                    return ListTile(
                      onTap: () {
                        navigatorPush(context, AgencyCenter(user: currentUser));
                      },
                      leading: Image.asset(
                        'assets/diamond.png',
                        width: 20,
                      ),
                      title: const Text(
                        'Agency Center',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  return ListTile(
                    onTap: null,
                    leading: Image.asset(
                      'assets/diamond.png',
                      width: 20,
                    ),
                    title: const Text(
                      'You Already Joined a Agency',
                      style: TextStyle(color: Colors.black45),
                    ),
                  );
                },
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
                      navigatorPush(
                          context, UserPosts(userId: currentUser.id!));
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
                      // navigatorPush(context, const AccountInformation());
                      navigatorPush(context, const ProfileEdit());
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
                    onTap: () {},
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
                  if (kDebugMode ||
                      (currentUser.role != null &&
                          currentUser.role!.contains('admin')))
                    InkWell(
                      onTap: () {
                        navigatorPush(context, const AdminPanel());
                      },
                      child: const MyColumn(
                        children: [
                          Icon(
                            Icons.admin_panel_settings_rounded,
                            color: Colors.green,
                          ),
                          Text('Admin Panel'),
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
