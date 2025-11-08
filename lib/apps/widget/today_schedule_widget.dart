import 'package:flutter/material.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';

class TodayScheduleWidget extends StatelessWidget {
  final List<ScheduleModel> source;
  final int? color;
  const TodayScheduleWidget({super.key, required this.source, this.color});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 0,
      itemBuilder: (_, i) {
        return SizedBox();
      },
    );
  }
}
