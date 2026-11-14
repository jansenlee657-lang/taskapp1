import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CatsuHeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final Widget? leading;
  final String title;
  final String subtitle;
  final bool showBadge;

  const CatsuHeaderAppBar({
    super.key,
    this.onNotificationTap,
    this.onProfileTap,
    this.leading,
    this.title = 'CATSU Lost & Found',
    this.subtitle = 'Catanduanes State University',
    this.showBadge = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.92),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderSubtle, width: 0.8),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 8),
              ],
              // University Seal Logo
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainerLow,
                  border: Border.all(color: AppColors.borderSubtle, width: 1),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA3fpPBKP8QSy0ovpLHD0Ja2s4D7HlPwuNBznePIgcokN7pBIk8LlygocVVZvoEQP2dKn4lWdqKMdgXX5a2S5SQ7VEY2nvosMm8TDHsOaeIKf4pZI5AYptqLhU34eSvSRVwtta3AP72Z4fJ12ie47AlfeY8Y6vig5MTMIMrE71klVWoXxHhhhZ60vR-3IdgTeBlQUpYVhxqxecwpM8Oqk8N95eGqPV8pTufaYAwwcY',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.account_balance,
                        size: 20,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // University Nomenclature & Title
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.secondary,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w700,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (showBadge) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            color: AppColors.primaryContainer,
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // Action Buttons
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.slateSecondary,
                  size: 22,
                ),
                tooltip: 'Notifications',
                onPressed: onNotificationTap ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All campus notifications are up to date.'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
              ),
              // User Avatar
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondaryContainer,
                      width: 1.5,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCda3yenMNuUYYKFXs3cXQuoy_g78MBDWsiub6yb6sZqkX6HfKYTTR7q_xkwmAcR46EBWDvxuMmkC3zqsEnLfpJCLcs1Qe2hGs5k43XXL31cySXvoD9Uoe5eEzS4Ou3NIjX70XF2NR5CEKMht1HCPOtHnkLf1hzLDVYHMTmma7p9qWr-Ixzn7BQO-FYEWBc2UCdj4svL8UZegbLlopqVi8IoxJQXqHlFdHsJxKQ1Q8',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

