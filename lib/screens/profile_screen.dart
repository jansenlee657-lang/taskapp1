import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onSignOut;

  const ProfileScreen({
    super.key,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Official Student Pass Card
          _buildStudentIDCard(context),
          const SizedBox(height: 16),

          // Campus Activity Ledger
          _buildActivityLedger(context),
          const SizedBox(height: 16),

          // Developer Credential Card
          _buildDeveloperCredentialCard(context),
          const SizedBox(height: 16),

          // System Credentials & Policy List
          _buildSystemSettingsCard(context),
          const SizedBox(height: 16),

          // Sign Out Action Button
          ElevatedButton.icon(
            onPressed: () => _confirmSignOut(context),
            icon: const Icon(Icons.logout, size: 20),
            label: const Text('Sign Out of Campus Terminal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorContainer,
              foregroundColor: AppColors.onErrorContainer,
            ),
          ),
          const SizedBox(height: 20),

          // Institutional Footer
          _buildInstitutionalFooter(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStudentIDCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gradient Accent Strip
          Container(
            height: 6,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryContainer,
                  AppColors.gold,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Top Tag & Chip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.badge, size: 18, color: AppColors.primaryContainer),
                        const SizedBox(width: 4),
                        Text(
                          'OFFICIAL STUDENT PASS',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryFixed,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified_user, size: 13, color: AppColors.onTertiaryFixed),
                          const SizedBox(width: 4),
                          Text(
                            'CATSU Bio-Verified',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onTertiaryFixed,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Main Profile Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Student Photo with Green & Gold Double Rim
                    Stack(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          padding: const EdgeInsets.all(2.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryContainer,
                                AppColors.gold,
                                AppColors.secondaryContainer,
                              ],
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCda3yenMNuUYYKFXs3cXQuoy_g78MBDWsiub6yb6sZqkX6HfKYTTR7q_xkwmAcR46EBWDvxuMmkC3zqsEnLfpJCLcs1Qe2hGs5k43XXL31cySXvoD9Uoe5eEzS4Ou3NIjX70XF2NR5CEKMht1HCPOtHnkLf1hzLDVYHMTmma7p9qWr-Ixzn7BQO-FYEWBc2UCdj4svL8UZegbLlopqVi8IoxJQXqHlFdHsJxKQ1Q8',
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(
                                color: AppColors.surfaceContainerLow,
                                child: const Icon(Icons.person, size: 36, color: AppColors.primaryContainer),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -1,
                          bottom: -1,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shield,
                              size: 12,
                              color: AppColors.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    // Student Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jansen Lee D. Matienzo',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Student (BSIT 3 – BLOCK D)',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            'Catanduanes State University (CATSU)',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                  color: AppColors.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.pin, size: 13, color: AppColors.outline),
                              const SizedBox(width: 3),
                              Text(
                                '2022-10842-VR',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.alternate_email, size: 13, color: AppColors.outline),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  'jm.matienzo@catsu.edu.ph',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 11,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Matriculation Status Ribbon
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Active Matriculation Status',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                  color: AppColors.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        'AY 2024–2025',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryContainer,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLedger(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Campus Activity Ledger',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              'Semester Record',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildStatCard(
              context,
              icon: Icons.find_in_page,
              iconBg: AppColors.surfaceContainer,
              iconColor: AppColors.onSurface,
              value: '3',
              valueColor: AppColors.onSurface,
              label: 'Reported',
            ),
            const SizedBox(width: 8),
            _buildStatCard(
              context,
              icon: Icons.task_alt,
              iconBg: AppColors.secondaryContainer,
              iconColor: AppColors.primaryContainer,
              value: '2',
              valueColor: AppColors.primaryContainer,
              label: 'Recovered',
            ),
            const SizedBox(width: 8),
            _buildStatCard(
              context,
              icon: Icons.workspace_premium,
              iconBg: AppColors.tertiaryFixed,
              iconColor: AppColors.tertiary,
              value: '100%',
              valueColor: AppColors.tertiary,
              label: 'Trust Score',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required Color valueColor,
    required String label,
  }) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: valueColor,
                      height: 1.1,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperCredentialCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.terminal,
                      size: 20,
                      color: AppColors.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Development & Engineering',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        'Catanduanes State University',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 10.5,
                              color: AppColors.secondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'v2.4.0',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Lead Developer Bio Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LEAD DEVELOPER & ARCHITECT',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slateSecondary,
                        letterSpacing: 0.6,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Matienzo, Jansen Lee D.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.school, size: 15, color: AppColors.secondary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'BSIT 3 – BLOCK D, Catanduanes State University',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Institutional Endorsement Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.account_balance, size: 18, color: AppColors.primaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Institutional Endorsement',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'College of Information and Communications Technology (CICT) in coordination with Office of Student Affairs (OSA)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10.5,
                              height: 1.35,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Build tag & security badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Build Tag: 2025.CICT-CORP-REL',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 9.5,
                      fontFamily: 'monospace',
                    ),
              ),
              Row(
                children: [
                  const Icon(Icons.security, size: 13, color: AppColors.primaryContainer),
                  const SizedBox(width: 3),
                  Text(
                    'Official Release',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryContainer,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSystemSettingsCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Credentials & Policy',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              _buildSettingTile(
                context,
                icon: Icons.lock,
                title: 'Security & Firebase Authentication',
                subtitle: 'Connected CATSU Google Workspace',
                trailing: const Icon(Icons.check_circle, size: 18, color: AppColors.primaryContainer),
              ),
              const Divider(height: 1, indent: 56),
              _buildSettingTile(
                context,
                icon: Icons.sync,
                title: 'Cloud Firestore Sync Status',
                subtitle: 'Real-time Synchronized',
                trailing: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ),
              const Divider(height: 1, indent: 56),
              _buildSettingTile(
                context,
                icon: Icons.notifications_active,
                title: 'Notification Preferences',
                subtitle: 'SMS & WebMail alerts for matched items',
                trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.outline),
              ),
              const Divider(height: 1, indent: 56),
              _buildSettingTile(
                context,
                icon: Icons.policy,
                title: 'Campus Privacy & Compliance',
                subtitle: 'Data Privacy Act of 2012 (RA 10173)',
                trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.outline),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.primaryContainer),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10.5,
              color: AppColors.onSurfaceVariant,
            ),
      ),
      trailing: trailing,
    );
  }

  Widget _buildInstitutionalFooter(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: ClipOval(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA3fpPBKP8QSy0ovpLHD0Ja2s4D7HlPwuNBznePIgcokN7pBIk8LlygocVVZvoEQP2dKn4lWdqKMdgXX5a2S5SQ7VEY2nvosMm8TDHsOaeIKf4pZI5AYptqLhU34eSvSRVwtta3AP72Z4fJ12ie47AlfeY8Y6vig5MTMIMrE71klVWoXxHhhhZ60vR-3IdgTeBlQUpYVhxqxecwpM8Oqk8N95eGqPV8pTufaYAwwcY',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(Icons.account_balance, color: AppColors.primaryContainer),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'CATANDUANES STATE UNIVERSITY',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: AppColors.secondary,
              ),
        ),
        Text(
          'Virac, Catanduanes, Philippines • Institutional Portal',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
        ),
        const SizedBox(height: 2),
        Text(
          '© 2025 CICT Academic Informatics. All rights reserved.',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: AppColors.outline,
                fontFamily: 'monospace',
              ),
        ),
      ],
    );
  }

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to disconnect from this CATSU campus terminal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              onSignOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
