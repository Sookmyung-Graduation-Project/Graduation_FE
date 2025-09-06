import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final Set<DateTime> attendedDates;

  const CalendarWidget({
    super.key,
    required this.attendedDates,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar<dynamic>(
      focusedDay: DateTime.now(),
      firstDay: DateTime(2025, 1, 1),
      lastDay: DateTime(2050, 12, 31),
      locale: 'ko_KR',
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        outsideDaysVisible: false,
        weekendTextStyle: const TextStyle(
          color: Colors.red,
        ),
        holidayTextStyle: const TextStyle(
          color: Colors.red,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        leftChevronVisible: true,
        rightChevronVisible: true,
      ),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${day.year}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${day.month}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
        markerBuilder: (context, day, events) {
          // 출석체크 표시
          if (widget.attendedDates
              .contains(DateTime(day.year, day.month, day.day))) {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB74D),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
