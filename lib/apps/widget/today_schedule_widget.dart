import 'package:flutter/material.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/widget/card_schedule_widget.dart';

class TodayScheduleWidget extends StatelessWidget {
  final List<ScheduleModel> source;
  const TodayScheduleWidget({super.key, required this.source});

  /// filter hari ini saja
  List<ScheduleModel> get _today {
    final n = DateTime.now();
    return source
        .where(
          (e) =>
              e.start.year == n.year &&
              e.start.month == n.month &&
              e.start.day == n.day,
        )
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));
  }

  @override
  Widget build(BuildContext context) {
    final list = _today;
    if (list.isEmpty) {
      return const Center(child: Text('Tidak ada jadwal hari ini'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length > 3 ? 3 : list.length,
      itemBuilder: (_, i) => CardScheduleWidget(model: list[i]),
    );
  }
}
