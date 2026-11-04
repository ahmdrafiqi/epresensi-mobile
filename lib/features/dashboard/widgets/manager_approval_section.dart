import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/features/dashboard/models/dashboard_request.dart';
import 'package:e_presensimobile/features/dashboard/widgets/request_summary_card.dart';
import 'package:e_presensimobile/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

class ManagerApprovalSection extends StatelessWidget {
  const ManagerApprovalSection({super.key});

  static const _requests = [
    DashboardRequest(
      employeeName: 'Adi Saputra',
      subtitle: 'Analis Distribusi',
      type: 'Cuti Tahunan',
      date: '24 - 26 Okt 2023',
      badge: 'VERIFIED LEVEL 1',
    ),
    DashboardRequest(
      employeeName: 'Siti Aminah',
      subtitle: 'Admin Operasional',
      type: 'Izin Sakit',
      date: '25 Okt 2023',
      badge: 'VERIFIED LEVEL 1',
    ),
    DashboardRequest(
      employeeName: 'Budi Hartono',
      subtitle: 'Senior Technician',
      type: 'Dinas Luar',
      date: '27 - 30 Okt 2023',
      badge: 'VERIFIED LEVEL 1',
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
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Aksi Cepat',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
                _QuickActionButton(
                  label: 'Approve Cuti',
                  onTap: () => _showMessage(
                    context,
                    'Approval belum terhubung ke server; data contoh.',
                  ),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  label: 'Approve Izin',
                  onTap: () => _showMessage(
                    context,
                    'Approval belum terhubung ke server; data contoh.',
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionTitle(
            title: 'Daftar Menunggu Persetujuan',
            actionLabel: 'Lihat Semua',
            onActionTap: () => _showMessage(
              context,
              'Daftar pengajuan belum terhubung ke server.',
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'DATA CONTOH — bukan data server',
              style: TextStyle(fontSize: 11, color: AppColors.primaryNavy),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList.separated(
            itemCount: _requests.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) => RequestSummaryCard(
              request: _requests[index],
              showApprovalActions: true,
              onDetailTap: () => _showRequestDetails(context, _requests[index]),
              onApproveTap: () => _showMessage(
                context,
                'Pengajuan belum diubah. Approval belum terhubung ke server.',
              ),
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

class _QuickActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 54,
        child: FilledButton(
          onPressed: onTap,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryRed,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          child: Text(label, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
