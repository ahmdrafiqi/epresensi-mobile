import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String name;
  final String role;
  final VoidCallback onLogout;

  const ProfilePage({
    super.key,
    required this.email,
    required this.name,
    required this.role,
    required this.onLogout,
  });

  String get _displayName => name.trim().isEmpty ? 'Pengguna' : name.trim();

  String get _displayRole {
    final normalizedRole = role.trim().toLowerCase();
    if (normalizedRole.isEmpty) return 'Pengguna';
    return normalizedRole[0].toUpperCase() + normalizedRole.substring(1);
  }

  void _showUnavailableMessage(BuildContext context, String feature) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: Text('$feature belum tersedia di aplikasi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _ProfileAppBar(
            onNotificationsTap: () =>
                _showUnavailableMessage(context, 'Notifikasi'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProfileIdentity(
                    name: _displayName,
                    role: _displayRole,
                    onEditPhoto: () =>
                        _showUnavailableMessage(context, 'Ubah foto profil'),
                  ),
                  const SizedBox(height: 24),
                  _ProfileDetails(email: email, role: _displayRole),
                  const SizedBox(height: 24),
                  Text(
                    'AKUN & APLIKASI',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF725F5D),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ProfileActionTile(
                    icon: Icons.lock_reset_outlined,
                    label: 'Ubah Password',
                    onTap: () =>
                        _showUnavailableMessage(context, 'Ubah Password'),
                  ),
                  _ProfileActionTile(
                    icon: Icons.history,
                    label: 'Riwayat Login',
                    onTap: () =>
                        _showUnavailableMessage(context, 'Riwayat Login'),
                  ),
                  _ProfileActionTile(
                    icon: Icons.support_agent_outlined,
                    label: 'Pusat Bantuan',
                    onTap: () =>
                        _showUnavailableMessage(context, 'Pusat Bantuan'),
                  ),
                  _ProfileActionTile(
                    icon: Icons.info_outline,
                    label: 'Tentang Aplikasi',
                    onTap: () =>
                        _showUnavailableMessage(context, 'Tentang Aplikasi'),
                  ),
                  _ProfileActionTile(
                    icon: Icons.policy_outlined,
                    label: 'Kebijakan Privasi',
                    onTap: () =>
                        _showUnavailableMessage(context, 'Kebijakan Privasi'),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: onLogout,
                    icon: const Icon(Icons.logout),
                    label: const Text('Keluar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryRed,
                      side: const BorderSide(
                        color: AppColors.primaryRed,
                        width: 1.5,
                      ),
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  final VoidCallback onNotificationsTap;

  const _ProfileAppBar({required this.onNotificationsTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: AppColors.whitePrimary,
        border: Border(bottom: BorderSide(color: Color(0xFFF0C9C6))),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(
            'Profile',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onNotificationsTap,
            tooltip: 'Notifikasi',
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF725F5D),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileIdentity extends StatelessWidget {
  final String name;
  final String role;
  final VoidCallback onEditPhoto;

  const _ProfileIdentity({
    required this.name,
    required this.role,
    required this.onEditPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.whitePrimary,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 54,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Material(
                color: AppColors.primaryRed,
                shape: const CircleBorder(),
                child: IconButton(
                  onPressed: onEditPhoto,
                  tooltip: 'Ubah foto profil',
                  constraints: const BoxConstraints.tightFor(
                    width: 34,
                    height: 34,
                  ),
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.whitePrimary,
                    size: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primaryRed,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final String email;
  final String role;

  const _ProfileDetails({required this.email, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whitePrimary,
        border: Border.all(color: const Color(0xFFF0C9C6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _ProfileDetailRow(
            icon: Icons.mail_outline,
            label: 'Email',
            value: email,
          ),
          _ProfileDetailRow(
            icon: Icons.phone_android_outlined,
            label: 'Nomor HP',
            value: 'Belum tersedia',
          ),
          _ProfileDetailRow(
            icon: Icons.badge_outlined,
            label: 'Peran Akun',
            value: role,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _ProfileDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EEFF),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: AppColors.primaryRed, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: const Color(0xFF725F5D), fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryNavy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: AppColors.whitePrimary,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minLeadingWidth: 24,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          leading: Icon(icon, color: const Color(0xFF725F5D), size: 22),
          title: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.primaryNavy),
          ),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFFB0A6A4)),
        ),
      ),
    );
  }
}
