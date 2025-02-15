import 'package:eyx3/components/app_bar.dart';
import 'package:eyx3/constants/font_styles.dart';
import 'package:eyx3/constants/size.dart';
import 'package:flutter/material.dart';

import '../services/db_controller.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  List<String> activities = [];
  int totalReward = 0;

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    DbHelper dbhelper = DbHelper();
    Map data = await dbhelper.fetch();
    setState(() {
      activities = data.values.map((item) => item['category'] as String).toList();
      totalReward = activities.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Reward'),
      body: Padding(
        padding: const EdgeInsets.all(medium),
        child: Column(
          children: [
            const SizedBox(height: large),
            Row(
              children: [
                Text('Total Reward', style: h1),
                const Spacer(),
                Text("$totalReward", style: h1),
              ],
            ),
            const SizedBox(height: large),
            Row(
              children: [
                Text('Activity', style: h2),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: xsmall, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(activities[index], style: reward)),
                        Text('+1', style: reward),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}