import 'package:courtclick_movie_app/customWidgets/customBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    // ==========================================
                    // PROFILES SECTION
                    // ==========================================

                    _ProfilesSection(),

                    // ==========================================
                    // TELL FRIENDS
                    // ==========================================
                    _TellFriendsSection(),

                    // ==========================================
                    // MY LIST
                    // ==========================================
                    _MyListSection(),

                    // ==========================================
                    // SETTINGS
                    // ==========================================
                    _SettingsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNavigation(selectedIndex: 4),
    );
  }
}

class _ProfilesSection extends StatelessWidget {
  const _ProfilesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 209,
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 23),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              // height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProfileItem(
                    asset: 'assets/images/blue_profile_card.svg',
                    name: 'Emanalo',
                    width: 73,
                    height: 68,
                  ),

                  _ProfileItem(
                    asset: 'assets/images/yellow_profile_card.svg',
                    name: 'Onyeka',
                    width: 65.29,
                    height: 60,
                  ),

                  _ProfileItem(
                    asset: 'assets/images/red_profile_card.svg',
                    name: 'Thelma',
                    width: 62,
                    height: 62,
                  ),

                  _ProfileItem(
                    asset: 'assets/images/kids_profile_card.svg',
                    name: 'Kids',
                    width: 64.48,
                    height: 59,
                  ),

                  const _AddProfileButton(),
                ],
              ),
            ),
          ),

          // const SizedBox(height: 2),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.edit, color: Colors.white, size: 15),

                const SizedBox(width: 7),

                const Text(
                  'Manage Profiles',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.72,
                    height: 30 / 14.72,
                    letterSpacing: -0.25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String asset;
  final String name;
  final double width;
  final double height;

  const _ProfileItem({
    required this.asset,
    required this.name,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(asset, fit: BoxFit.fill),
          ),

          const SizedBox(height: 5),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddProfileButton extends StatelessWidget {
  const _AddProfileButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 63,
        height: 58,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF8C8787), width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Center(
            child: Icon(Icons.add, color: Colors.white, size: 40),
          ),
        ),
      ),
    );
  }
}

class _TellFriendsSection extends StatelessWidget {
  const _TellFriendsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      // height: 247,
      color: const Color(0xFF1F1F1F),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 23),

          // TITLE
          Row(
            children: [
              const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 29,
              ),

              const SizedBox(width: 8),

              const Text(
                'Tell friends about Netflix.',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w700,
                  fontSize: 19.63,
                  height: 14.68 / 19.63,
                  letterSpacing: -0.05,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          // DESCRIPTION
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut '
            'felis non accumsan quis. Massa, id ut ipsum aliquam enim '
            'non posuere pulvinar diam.',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
              fontSize: 10.78,
              height: 18 / 10.78,
              letterSpacing: -0.18,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          // TERMS
          const Text(
            'Terms & Conditions',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
              fontSize: 10.78,
              height: 18 / 10.78,
              letterSpacing: -0.18,
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),

          const SizedBox(height: 13),

          // INPUT + COPY LINK
          Row(
            children: [
              Expanded(child: Container(height: 37, color: Colors.black)),

              const SizedBox(width: 7),

              SizedBox(
                width: 96,
                height: 37,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text(
                    'Copy Link',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                      fontSize: 17.06,
                      height: 34.76 / 17.06,
                      letterSpacing: -0.29,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // SOCIAL ICONS
          const _SocialRow(),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: _SocialIcon(asset: 'assets/images/whatsapp_icon.svg'),
            ),
          ),

          const _SocialDivider(),

          Expanded(
            child: Center(
              child: _SocialIcon(asset: 'assets/images/fb_icon.svg'),
            ),
          ),

          const _SocialDivider(),

          Expanded(
            child: Center(
              child: _SocialIcon(asset: 'assets/images/mail_icon.svg'),
            ),
          ),

          const _SocialDivider(),

          Expanded(child: _MoreSocialButton()),
        ],
      ),
    );
  }
}

class _MoreSocialButton extends StatelessWidget {
  const _MoreSocialButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.more_horiz, color: Colors.white, size: 30),
            const SizedBox(height: 1),
            const Text(
              'More',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String asset;

  const _SocialIcon({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 33,
        height: 33,
        child: SvgPicture.asset(asset, fit: BoxFit.contain),
      ),
    );
  }
}

class _SocialItem extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const _SocialItem({
    required this.icon,
    required this.backgroundColor,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 34,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 25),
      ),
    );
  }
}

class _SocialDivider extends StatelessWidget {
  const _SocialDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 53, color: const Color(0xFF777777));
  }
}

class _MyListSection extends StatelessWidget {
  const _MyListSection();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 375,
        height: 49,
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/tick_icon.svg',
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 5),

            const Text(
              'My List',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      color: Colors.black,
      padding: const EdgeInsets.only(left: 32, top: 21, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SettingsItem(title: 'App Settings', onTap: () {}),

          _SettingsItem(title: 'Account', onTap: () {}),

          _SettingsItem(title: 'Help', onTap: () {}),

          _SettingsItem(title: 'Sign Out', onTap: () {}),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SettingsItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 44,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
              fontSize: 14.72,
              height: 30 / 14.72,
              letterSpacing: 0.25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
