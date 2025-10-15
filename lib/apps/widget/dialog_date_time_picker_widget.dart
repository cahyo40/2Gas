import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yo_ui/yo_ui.dart';

Future<DateTimeRange?> showDateTimeRangePicker(BuildContext ctx) async {
  DateTime? _sDate, _eDate;
  TimeOfDay? _sTime, _eTime;

  await showDialog<DateTimeRange?>(
    context: ctx,
    builder: (_) => _NativeRangeDialog(
      onConfirm: (sd, st, ed, et) {
        _sDate = sd;
        _sTime = st;
        _eDate = ed;
        _eTime = et;
      },
    ),
  );

  if (_sDate == null || _sTime == null || _eDate == null || _eTime == null) {
    return null;
  }
  final start = DateTime(
    _sDate!.year,
    _sDate!.month,
    _sDate!.day,
    _sTime!.hour,
    _sTime!.minute,
  );
  final end = DateTime(
    _eDate!.year,
    _eDate!.month,
    _eDate!.day,
    _eTime!.hour,
    _eTime!.minute,
  );
  return end.isAfter(start) ? DateTimeRange(start: start, end: end) : null;
}

class _NativeRangeDialog extends StatefulWidget {
  final Function(
    DateTime sDate,
    TimeOfDay sTime,
    DateTime eDate,
    TimeOfDay eTime,
  )
  onConfirm;
  const _NativeRangeDialog({required this.onConfirm});

  @override
  __NativeRangeDialogState createState() => __NativeRangeDialogState();
}

class __NativeRangeDialogState extends State<_NativeRangeDialog> {
  DateTime? _sDate, _eDate;
  TimeOfDay? _sTime, _eTime;

  Future<void> _pickDate(bool start) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: start
          ? (_sDate ?? DateTime.now())
          : (_eDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (start) {
          _sDate = picked;
        } else {
          _eDate = picked;
        }
      });
    }
  }

  Future<void> _pickTime(bool start) async {
    final picked = await showTimePicker(
      context: context,

      initialTime: start
          ? (_sTime ?? const TimeOfDay(hour: 8, minute: 0))
          : (_eTime ?? const TimeOfDay(hour: 17, minute: 0)),
    );
    if (picked != null) {
      setState(() {
        if (start) {
          _sTime = picked;
        } else {
          _eTime = picked;
        }
      });
    }
  }

  bool get _ready =>
      _sDate != null && _sTime != null && _eDate != null && _eTime != null;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd MMM yyyy');
    return AlertDialog(
      title: YoText('Pilih rentang tanggal & jam'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Dari', style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                _sDate == null ? 'Pilih tanggal' : fmt.format(_sDate!),
              ),
              trailing: const Icon(Icons.edit),
              onTap: () => _pickDate(true),
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                _sTime == null ? 'Pilih jam' : _sTime!.format(context),
              ),
              trailing: const Icon(Icons.edit),
              onTap: () => _pickTime(true),
            ),
            const Divider(height: 24),
            const Text('Sampai', style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                _eDate == null ? 'Pilih tanggal' : fmt.format(_eDate!),
              ),
              trailing: const Icon(Icons.edit),
              onTap: () => _pickDate(false),
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                _eTime == null ? 'Pilih jam' : _eTime!.format(context),
              ),
              trailing: const Icon(Icons.edit),
              onTap: () => _pickTime(false),
            ),
          ],
        ),
      ),
      actions: [
        YoButton.ghost(onPressed: () => Navigator.pop(context), text: "Batal"),
        YoButton.primary(
          onPressed: _ready
              ? () {
                  widget.onConfirm(_sDate!, _sTime!, _eDate!, _eTime!);
                  Navigator.pop(context);
                }
              : null,
          text: "OK",
        ),
      ],
    );
  }
}
