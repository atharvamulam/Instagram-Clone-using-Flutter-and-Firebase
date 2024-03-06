import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ig/core/constants/app_colors.dart';
import 'package:ig/core/constants/constants.dart';
import 'package:ig/core/widgets/round_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: _buildFacebookText(),
        actions: [
          _buildSearchWidget(),
          _buildMessengerWidget(),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: Constants.screens,
      ),
      bottomNavigationBar: Material(
        color: AppColors.whiteColor,
        child: TabBar(
          tabs: Constants.getHomeScreenTabs(_tabController.index),
          controller: _tabController,
          onTap: (index) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildFacebookText() => const Text(
        'Instagram',
        style: TextStyle(
          color: AppColors.blackColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _buildSearchWidget() => const RoundIconButton(
        icon: FontAwesomeIcons.heart,
      );

  Widget _buildMessengerWidget() => InkWell(
        onTap: () {},
        child: const RoundIconButton(
          icon: FontAwesomeIcons.facebookMessenger,
        ),
      );
}
