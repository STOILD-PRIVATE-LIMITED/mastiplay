import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/screen/about.dart';
import 'package:spinner_try/screen/agency_center.dart';
import 'package:spinner_try/screen/agent_panel.dart';
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

import '../../screen/bd_center.dart';
import '../../screen/creator_center.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1DBDB),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/back/0.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          navigatorPush(context, const WalletScreen());
                        },
                        leading: Image.asset(
                          'assets/wallet 1.png',
                          width: 20,
                        ),
                        title: const Text('Wallet'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (currentUser.agentId != null)
                      FutureBuilder(
                          future: fetchAgentData(currentUser.id!),
                          builder: (context, snapshot) {
                            final loading = snapshot.connectionState ==
                                ConnectionState.waiting;
                            final userData = snapshot.data;
                            return ListTile(
                              onTap: loading || userData == null
                                  ? null
                                  : () {
                                      currentUser.agentData =
                                          userData.agentData;
                                      navigatorPush(context,
                                          AgentPanel(user: currentUser));
                                    },
                              leading: loading
                                  ? const CircularProgressIndicatorRainbow()
                                  : Image.asset(
                                      'assets/gem 1.png',
                                      width: 20,
                                    ),
                              title: Text(
                                userData == null && !loading
                                    ? "Can't reach the server right now"
                                    : 'Agent',
                                style: TextStyle(
                                    color: userData == null && !loading
                                        ? Colors.red
                                        : (loading
                                            ? Colors.black45
                                            : Colors.black)),
                              ),
                            );
                          }),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/back/1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NobelCenter()));
                        },
                        leading: Image.asset(
                          'assets/vip 1.png',
                          width: 20,
                        ),
                        title: const Text('VIP Center'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/back/2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          navigatorPush(context, const NobelCenter());
                        },
                        leading: Image.asset(
                          'assets/—Pngtree—knight s shield illustration with_12235284 1.png',
                          width: 20,
                        ),
                        title: const Text('Noble Center'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                        // SizedBox(height:10,),

                        if (agencyData == null) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: AssetImage('assets/back/3.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                navigatorPush(context, const BindAgency());
                              },
                              leading: Image.asset(
                                'assets/add-user 2.png',
                                width: 20,
                              ),
                              title: const Text('Bind Agency'),
                            ),
                          );
                        }
                        if (currentUser.ownedAgencyData != null) {
                          return ListTile(
                            onTap: () {
                              navigatorPush(
                                  context, AgencyCenter(user: currentUser));
                            },
                            leading: Image.asset(
                              'assets/agency_Center.png',
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
                            'assets/agency_Center.png',
                            width: 20,
                          ),
                          title: const Text(
                            'You Already Joined a Agency',
                            style: TextStyle(color: Colors.black45),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/back/4.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          navigatorPush(context, const CreatorCenter());
                        },
                        leading: Image.asset(
                          'assets/Group-2.png',
                          width: 20,
                        ),
                        title: const Text('Creator Center'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/back/5.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          navigatorPush(context, const Store());
                        },
                        leading: Image.asset(
                          'assets/shopping-bag 1.png',
                          width: 20,
                        ),
                        title: const Text('Privilege Bag'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/back/6.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          navigatorPush(context, const FamilyScreen());
                        },
                        leading: Image.asset(
                          'assets/Group 18114.png',
                          width: 20,
                        ),
                        title: const Text('Family'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/back/7.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          navigatorPush(context, const UserLevelPage());
                        },
                        leading: Image.asset(
                          'assets/level up.png',
                          width: 20,
                        ),
                        title: const Text('User level center'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/back/7.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          navigatorPush(context, const BDCenter());
                        },
                        leading: Image.asset(
                          'assets/level up.png',
                          width: 20,
                        ),
                        title: const Text('Bd Center'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: const Color(0xFFF1DBDB),
                child: GridView.extent(
                  maxCrossAxisExtent: 100,
                  padding: const EdgeInsets.all(2),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        navigatorPush(context, const InviteFriends());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/frame/Frame 1.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: MyColumn(
                          children: [
                            Image.asset(
                              "assets/Frame 32.png",
                              width: 30,
                              height: 35,
                            ),
                            const Text('Invite'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigatorPush(
                            context, UserPosts(userId: currentUser.id!));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/frame/Frame 2.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: MyColumn(
                          children: [
                            Image.asset(
                              "assets/heart.png",
                              width: 30,
                              height: 35,
                            ),
                            const Text('Moment'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // navigatorPush(context, const AccountInformation());
                        navigatorPush(context, const ProfileEdit());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/frame/Frame 3.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: MyColumn(
                          children: [
                            Image.asset(
                              "assets/Group-1.png",
                              width: 30,
                              height: 35,
                            ),
                            const Text('Account Info'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/frame/Frame 4.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: MyColumn(
                          children: [
                            Image.asset(
                              "assets/starGroup 18115.png",
                              width: 30,
                              height: 35,
                            ),
                            const Text('Events'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigatorPush(context, const Setting());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/frame/Frame 5.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: MyColumn(
                          children: [
                            Image.asset(
                              "assets/settings-01.png",
                              width: 30,
                              height: 35,
                            ),
                            const Text('Settings'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigatorPush(context, const HelpForm());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/frame/Frame 6.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: MyColumn(
                          children: [
                            Image.asset(
                              "assets/caller.png",
                              width: 30,
                              height: 35,
                            ),
                            const Text('Help'),
                          ],
                        ),
                      ),
                    ),
                    if (kDebugMode ||
                        (currentUser.role != null &&
                            currentUser.role!.contains('admin')))
                      InkWell(
                        onTap: () {
                          navigatorPush(context, const AdminPanel());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage('assets/frame/Frame 7.png'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: const MyColumn(
                            children: [
                              Icon(
                                Icons.admin_panel_settings_rounded,
                                size: 30,
                                color: Colors.green,
                              ),
                              Text('Admin Panel'),
                            ],
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: () {
                        navigatorPush(context, const About());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/frame/Frame 8.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: MyColumn(
                          children: [
                            Image.asset(
                              "assets/info 2.png",
                              width: 30,
                              height: 35,
                            ),
                            const Text('About'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
