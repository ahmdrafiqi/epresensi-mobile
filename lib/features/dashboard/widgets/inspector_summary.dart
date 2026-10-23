import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InspectorSummary extends StatelessWidget {
  const InspectorSummary({super.key});

  static const _metrics = [
    _InspectorMetric(
      icon: Icons.assignment_outlined,
      value: '12',
      label: 'Menunggu Validasi',
      color: Color(0xFFB4232B),
      background: Color(0xFFFFEFF0),
    ),
    _InspectorMetric(
      icon: Icons.pending_actions,
      value: '5',
      label: 'Lembur',
      color: Color(0xFFF27516),
      background: Color(0xFFFFF3E8),
    ),
    _InspectorMetric(
      icon: Icons.work_outline,
      value: '3',
      label: 'Kunjungan Dinas',
      color: Color(0xFF2875E5),
      background: Color(0xFFEDF4FF),
    ),
    _InspectorMetric(
      icon: Icons.event_available_outlined,
      value: '4',
      label: 'Cuti & Izin',
      color: Color(0xFF16A36A),
      background: Color(0xFFEBFAF2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 64,
            child: Container(color: AppColors.primaryRed),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _metrics.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.28,
              ),
              itemBuilder: (context, index) =>
                  _InspectorMetricCard(metric: _metrics[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _InspectorMetric {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color background;

  const _InspectorMetric({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.background,
  });
}

class _InspectorMetricCard extends StatelessWidget {
  final _InspectorMetric metric;

  const _InspectorMetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: metric.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(metric.icon, size: 19, color: metric.color),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric.value,
                style: const TextStyle(
                  fontSize: 26,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                metric.label,
                style: const TextStyle(fontSize: 12, color: Color(0xFF493B3B)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
