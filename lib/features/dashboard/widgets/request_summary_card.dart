import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/features/dashboard/models/dashboard_request.dart';
import 'package:flutter/material.dart';

class RequestSummaryCard extends StatelessWidget {
  final DashboardRequest request;
  final bool showApprovalActions;
  final VoidCallback onDetailTap;
  final VoidCallback? onApproveTap;

  const RequestSummaryCard({
    super.key,
    required this.request,
    required this.showApprovalActions,
    required this.onDetailTap,
    this.onApproveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: const Color(0xFFE8C3C3)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: const Color(0xFFE8EDF5),
                child: Text(
                  _initials(request.employeeName),
                  style: const TextStyle(
                    color: AppColors.primaryNavy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.employeeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNavy,
                      ),
                    ),
                    Text(
                      request.subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF675555),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(child: _RequestBadge(label: request.badge)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFF1E1E1)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _RequestDetail(
                  label: 'Jenis Pengajuan',
                  value: request.type,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RequestDetail(label: 'Tanggal', value: request.date),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFF1E1E1)),
          ),
          if (showApprovalActions)
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: OutlinedButton(
                    onPressed: onDetailTap,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryRed,
                      side: const BorderSide(color: AppColors.primaryRed),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: const Text('Lihat Detail'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: onApproveTap,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: const Text('Approve'),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onDetailTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryRed,
                  side: const BorderSide(color: AppColors.primaryRed),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: const Text('Lihat Detail'),
              ),
            ),
        ],
      ),
    );
  }

  String _initials(String name) {
    return name.split(' ').take(2).map((part) => part[0]).join().toUpperCase();
  }
}

class _RequestBadge extends StatelessWidget {
  final String label;

  const _RequestBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final isPending = label.toLowerCase().contains('menunggu');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: isPending ? const Color(0xFFFFF4C2) : const Color(0xFFE8ECF5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: isPending ? const Color(0xFF8A5100) : const Color(0xFF264477),
        ),
      ),
    );
  }
}

class _RequestDetail extends StatelessWidget {
  final String label;
  final String value;

  const _RequestDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF675555)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
