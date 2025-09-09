import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/calendar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/api_service.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  Set<DateTime> _attendedDates = <DateTime>{};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAttendanceStatus();
  }

  Future<void> _loadAttendanceStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('access_token');
    final userId = prefs.getString('user_id');
    if (jwt == null || userId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final resp =
          await ApiService.getAttendanceStatus(jwt: jwt, userId: userId);

      final List<dynamic> allAttendedDays =
          (resp['attended_days'] ?? []) as List<dynamic>;
      final Set<DateTime> attendedDates = <DateTime>{};

      // 전체 출석 날짜를 DateTime으로 변환
      for (String dateStr in allAttendedDays) {
        try {
          final date = DateTime.parse(dateStr);
          attendedDates.add(DateTime(date.year, date.month, date.day));
        } catch (e) {
          print('날짜 파싱 오류: $dateStr, $e');
        }
      }

      setState(() {
        _attendedDates = attendedDates;
        _isLoading = false;
      });
    } catch (e) {
      print('출석현황 로드 오류: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 25),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CalendarWidget(attendedDates: _attendedDates),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
