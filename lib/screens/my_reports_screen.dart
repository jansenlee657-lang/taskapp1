import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';

class MyReportsScreen extends StatefulWidget {
  final VoidCallback onNewIncident;

  const MyReportsScreen({
    super.key,
    required this.onNewIncident,
  });

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  String _activeFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final reports = MockData.myReports.where((r) {
      if (_activeFilter == 'pending') return r.status == ReportStatus.pendingMatch;
      if (_activeFilter == 'verification') return r.status == ReportStatus.inVerification;
      if (_activeFilter == 'resolved') return r.status == ReportStatus.resolved;
      return true;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subheader & Live Counters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STUDENT REGISTRY RECORDS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'My Campus Registry Reports',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.fact_check,
                  color: AppColors.primaryContainer,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Quick Status Metric Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatusChip(
                  context,
                  dotColor: AppColors.primaryContainer,
                  text: '4 Active Cases',
                  bgColor: AppColors.secondaryContainer,
                  textColor: AppColors.onSecondaryContainer,
                ),
                const SizedBox(width: 6),
                _buildStatusChip(
                  context,
                  icon: Icons.archive,
                  text: '8 Total Logged',
                  bgColor: AppColors.surfaceContainerHigh,
                  textColor: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                _buildStatusChip(
                  context,
                  icon: Icons.verified_user,
                  text: 'Official University Record',
                  bgColor: AppColors.surfaceContainerLow,
                  textColor: AppColors.outline,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Filter Segmented Tabs
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterTab('all', 'All Reports (4)'),
                  const SizedBox(width: 4),
                  _buildFilterTab('pending', 'Pending Match (2)'),
                  const SizedBox(width: 4),
                  _buildFilterTab('verification', 'In Verification (1)'),
                  const SizedBox(width: 4),
                  _buildFilterTab('resolved', 'Resolved (5)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Reports List
          if (reports.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: Text(
                'No reports found under this category filter.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.slateSecondary,
                    ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reports.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final report = reports[index];
                return _buildReportItemCard(context, report);
              },
            ),
          const SizedBox(height: 16),

          // Campus Custody Guidelines Banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.policy,
                  size: 20,
                  color: AppColors.primaryContainer,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Campus Custody Guidelines',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Valuables are safely stored at the Office of Student Affairs Security Vault for 60 academic days prior to university asset reclamation.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              height: 1.35,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Register New Incident Button
          ElevatedButton.icon(
            onPressed: widget.onNewIncident,
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Register New Incident'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.onPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              'Lost an item outside campus grounds? Inquire with Student Affairs.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10.5,
                    color: AppColors.outline,
                  ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatusChip(
    BuildContext context, {
    Color? dotColor,
    IconData? icon,
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          if (icon != null) ...[
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String key, String title) {
    final isSelected = _activeFilter == key;

    return GestureDetector(
      onTap: () => setState(() => _activeFilter = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  )
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.primaryContainer : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildReportItemCard(BuildContext context, ItemRecord report) {
    Color stripeColor;
    Color badgeBg;
    Color badgeText;
    String badgeTitle;

    switch (report.status) {
      case ReportStatus.pendingMatch:
        stripeColor = AppColors.primaryContainer;
        badgeBg = AppColors.errorContainer;
        badgeText = AppColors.onErrorContainer;
        badgeTitle = 'Reported Lost';
        break;
      case ReportStatus.inVerification:
        stripeColor = AppColors.secondaryContainer;
        badgeBg = AppColors.secondaryContainer;
        badgeText = AppColors.onSecondaryContainer;
        badgeTitle = 'Secured Article (Found)';
        break;
      case ReportStatus.resolved:
        stripeColor = AppColors.outlineVariant;
        badgeBg = AppColors.surfaceContainer;
        badgeText = AppColors.secondary;
        badgeTitle = 'Closed & Archived';
        break;
      default:
        stripeColor = AppColors.primaryContainer;
        badgeBg = AppColors.secondaryContainer;
        badgeText = AppColors.onSecondaryContainer;
        badgeTitle = report.status.label;
    }

    final isResolved = report.status == ReportStatus.resolved;

    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top institutional colored stripe
            Container(height: 4, color: stripeColor),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top badge & date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          badgeTitle,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: badgeText,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 12, color: AppColors.outline),
                          const SizedBox(width: 3),
                          Text(
                            report.date,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    report.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          decoration: isResolved ? TextDecoration.lineThrough : null,
                          color: isResolved ? AppColors.onSurfaceVariant : AppColors.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: AppColors.secondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          report.subLocation,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    report.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          height: 1.35,
                          color: AppColors.onSurfaceVariant,
                        ),
                  ),

                  // Match Banner (for pending match)
                  if (report.hasPotentialMatch) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.celebration,
                              size: 14,
                              color: AppColors.onPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '1 Potential Match Found',
                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryContainer,
                                          ),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryContainer,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Logged by Campus Security Office (Admin Ground Floor). Distinct label matched your identifier.',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 10.5,
                                        color: AppColors.onSecondaryContainer,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => _openMatchDrawer(context, report),
                      icon: const Icon(Icons.verified, size: 16),
                      label: const Text('Review Potential Match'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimary,
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],

                  // In Verification Progress Box
                  if (report.status == ReportStatus.inVerification) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.hourglass_top, size: 16, color: AppColors.tertiary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Claim in Verification Stage',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  'Student ID verification scheduled for claimant. Awaiting custodian endorsement.',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 10.5,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _openReceiptModal(context),
                            icon: const Icon(Icons.receipt_long, size: 16, color: AppColors.primaryContainer),
                            label: const Text(
                              'Handover Receipt',
                              style: TextStyle(fontSize: 11, color: AppColors.primaryContainer),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 38),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              side: const BorderSide(color: AppColors.borderSubtle),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Case confirmed with OSA Security.')),
                              );
                            },
                            icon: const Icon(Icons.task_alt, size: 16),
                            label: const Text('Confirm Case', style: TextStyle(fontSize: 11)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: AppColors.onPrimary,
                              minimumSize: const Size(0, 38),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Resolved stamped item
                  if (isResolved) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.verified, size: 16, color: AppColors.primaryContainer),
                              const SizedBox(width: 6),
                              Text(
                                'Archived in CATSU Registry Ref #CR-4412',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      fontSize: 10.5,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            'Details',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryContainer,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openMatchDrawer(BuildContext context, ItemRecord report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.find_in_page, color: AppColors.primaryContainer, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Campus Match Report',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.inventory, color: AppColors.primaryContainer, size: 26),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MATCHED ASSET CODE',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary,
                            ),
                      ),
                      Text(
                        report.matchedAssetCode ?? 'CALC-CICT-2024-102',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'CUSTODIAN NOTES',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.outline,
                  ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                report.custodianNotes ??
                    '"Casio scientific calculator recovered from CICT bench podium after 3rd period lecture. Battery casing matches report marking #ENG-4891. Stored in Security Locker B-4."',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      height: 1.35,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To Claim This Item:',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '1. Present your Valid CATSU Student ID (SY 2024–2025).\n2. Sign Official Handover Release Form at OSA Main Office.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Claim request endorsed to OSA Security. Present your ID during office hours (8AM-5PM).',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text('Endorse & Claim Item'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Not My Item'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openReceiptModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Handover Receipt', style: TextStyle(fontWeight: FontWeight.w700)),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Column(
                children: [
                  _receiptRow('RECEIPT NO:', 'CSD-884-24', isBold: true),
                  _receiptRow('DATE:', '20-OCT-2024'),
                  _receiptRow('ARTICLE:', '3x Keys + Red Lanyard'),
                  _receiptRow('CUSTODIAN:', 'Officer R. Vargas'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Official digital stamp verified by the Catanduanes State University Security Department.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: AppColors.outline,
                  ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _receiptRow(String k, String v, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          Text(
            v,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
