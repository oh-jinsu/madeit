import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/events/sign_out_requested.dart';
import 'package:madeit/application/stores/my_reaction_counts.dart';
import 'package:madeit/application/stores/sign_out_form.dart';
import 'package:madeit/application/stores/user.dart';
import 'package:madeit/composition/common/constants/strings.dart';
import 'package:madeit/composition/common/properties/domain_image.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';
import 'package:madeit/composition/common/widgets/navigation_bar.dart';
import 'package:madeit/composition/common/widgets/record_group.dart';
import 'package:madeit/composition/common/widgets/record_item.dart';
import 'package:madeit/composition/profile/widget/group.dart';
import 'package:madeit/composition/profile/widget/menu.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AntennaManager {
  @override
  void initState() {
    sync(userStore);

    sync(signOutFormStore);

    sync(myReactionCountsStore);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.profile),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            if (userStore.state == null) ...[
              ProfileGroup(
                children: [
                  ProfileMenu(
                    onTap: () {
                      Navigator.of(context).pushNamed("/signin");
                    },
                    showIcon: false,
                    label: Text(
                      "?????????",
                      style: BodyTextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ] else ...[
              const SizedBox(height: 8.0),
              Center(
                  child: Avatar(
                radius: 40.0,
                image: userStore.state!.avatarId.value != null
                    ? DomainImage.fromNetwork(userStore.state!.avatarId.value!)
                    : null,
              )),
              const SizedBox(height: 12.0),
              const Text(
                "?????????",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 16.0),
              if (myReactionCountsStore.state != null)
                RecordGroup(
                  items: [
                    RecordItem(
                      icon: Icons.verified_outlined,
                      label: "????????????",
                      content:
                          myReactionCountsStore.state!.goodCount.toString(),
                    ),
                    RecordItem(
                      icon: Icons.favorite_outline,
                      label: "?????????",
                      content:
                          myReactionCountsStore.state!.loveCount.toString(),
                    ),
                    RecordItem(
                      icon: Icons.waving_hand_outlined,
                      label: "?????????",
                      content:
                          myReactionCountsStore.state!.comeOnCount.toString(),
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              const ProfileGroup(
                children: [
                  ProfileMenu(
                    label: Text(
                      "??????, ????????? ??????",
                      style: BodyTextStyle(),
                    ),
                  ),
                  ProfileMenu(
                    label: Text(
                      "??????",
                      style: BodyTextStyle(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
            ProfileGroup(
              children: [
                ProfileMenu(
                  onTap: () {
                    final url = Uri.parse(
                      "https://madeit.develife.kr/service",
                    );

                    launchUrl(url);
                  },
                  label: const Text(
                    "?????????????????????",
                    style: BodyTextStyle(),
                  ),
                ),
                ProfileMenu(
                  onTap: () {
                    final url = Uri.parse(
                      "https://madeit.develife.kr/privacy",
                    );

                    launchUrl(url);
                  },
                  label: const Text(
                    "????????????????????????",
                    style: BodyTextStyle(),
                  ),
                ),
                ProfileMenu(
                  onTap: () {},
                  label: const Text(
                    "?????? ??? ??????",
                    style: BodyTextStyle(),
                  ),
                ),
              ],
            ),
            if (userStore.state != null) ...[
              const SizedBox(height: 16.0),
              ProfileGroup(
                children: [
                  ProfileMenu(
                    onTap: () {
                      if (!signOutFormStore.state) {
                        return;
                      }

                      dispatch(const SignOutRequested());
                    },
                    showIcon: !signOutFormStore.state,
                    label: Text(
                      "????????????",
                      style: BodyTextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    icon: !signOutFormStore.state
                        ? const SizedBox(
                            width: 12.0,
                            height: 12.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 2),
    );
  }
}
