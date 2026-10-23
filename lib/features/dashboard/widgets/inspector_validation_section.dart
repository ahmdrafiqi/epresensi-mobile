import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/features/dashboard/models/dashboard_request.dart';
import 'package:e_presensimobile/features/dashboard/widgets/request_summary_card.dart';
import 'package:e_presensimobile/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

class InspectorValidationSection extends StatelessWidget {
  const InspectorValidationSection({super.key});

  static const _requests = [
    DashboardRequest(
      employeeName: 'Siti Aminah',
      subtitle: 'ID: 882041 • Sales & Marketing',
      type: 'Lembur (Overtime)',
      date: '24 Okt 2023',
      badge: 'Menunggu Validasi',
    ),
    DashboardRequest(
      employeeName: 'Budi Santoso',
      subtitle: 'ID: 742095 • Distribution Unit',
      type: 'Kunjungan Dinas',
      date: '25 Okt 2023',
      badge: 'Menunggu Validasi',
    ),
  ];

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Menu Validasi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.2,
              children: [
                _ValidationMenuButton(
                  icon: Icons.pending_actions,
                  label: 'Validasi Lembur',
                  onTap: () => _showMessage(context, 'Validasi lembur'),
                ),
                _ValidationMenuButton(
                  icon: Icons.flight_takeoff_outlined,
                  label: 'Validasi Dinas',
                  onTap: () => _showMessage(context, 'Validasi dinas'),
                ),
                _ValidationMenuButton(
                  icon: Icons.calendar_month_outlined,
                  label: 'Approval Cuti',
                  onTap: () => _showMessage(context, 'Approval cuti'),
                ),
                _ValidationMenuButton(
                  icon: Icons.verified_outlined,
                  label: 'Approval Izin',
                  onTap: () => _showMessage(context, 'Approval izin'),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionTitle(
            title: 'Pengajuan Terbaru',
            actionLabel: 'Lihat Semua',
            onActionTap: () => _showMessage(context, 'Semua pengajuan terbaru'),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList.separated(
            itemCount: _requests.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) => RequestSummaryCard(
              request: _requests[index],
              showApprovalActions: false,
              onDetailTap: () => _showRequestDetails(context, _requests[index]),
            ),
          ),
        ),
      ],
    );
  }

  void _showRequestDetails(BuildContext context, DashboardRequest request) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(request.employeeName),
        content: Text('${request.type}\n${request.date}\n${request.subtitle}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

class _ValidationMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ValidationMenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryNavy,
        backgroundColor: AppColors.card,
        alignment: Alignment.centerLeft,
        side: const BorderSide(color: Color(0xFFEED6D6)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19,
            backgroundColor: const Color(0xFFE5EAF8),
            child: Icon(icon, size: 20, color: AppColors.primaryRed),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1.15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
