import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';
import 'item_detail_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedZone = 'all';
  String _typeFilter = 'all'; // 'all', 'lost', 'found'
  ItemCategory _selectedCategory = ItemCategory.all;

  final List<Map<String, String>> _zones = [
    {'value': 'all', 'label': 'All Campuses (Main Campus & Satellite)'},
    {'value': 'main', 'label': 'Main Campus - Virac Central Quad'},
    {'value': 'engineering', 'label': 'Engineering & Architecture Precinct'},
    {'value': 'science', 'label': 'College of Science & Lab Compound'},
    {'value': 'cict', 'label': 'Main Campus - CICT Building'},
    {'value': 'library', 'label': 'Central Library & Learning Commons'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = MockData.items.where((item) {
      // Type filter
      if (_typeFilter == 'lost' && item.type != ItemType.lost) return false;
      if (_typeFilter == 'found' && item.type != ItemType.found) return false;

      // Category filter
      if (_selectedCategory != ItemCategory.all && item.category != _selectedCategory) {
        return false;
      }

      // Zone filter
      if (_selectedZone != 'all') {
        if (_selectedZone == 'cict' && !item.location.contains('CICT')) return false;
        if (_selectedZone == 'engineering' && !item.location.contains('Engineering')) return false;
        if (_selectedZone == 'science' && !item.location.contains('Science')) return false;
        if (_selectedZone == 'library' && !item.location.contains('Library')) return false;
      }

      // Query filter
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matches = item.title.toLowerCase().contains(q) ||
            item.description.toLowerCase().contains(q) ||
            item.refNumber.toLowerCase().contains(q) ||
            item.location.toLowerCase().contains(q);
        if (!matches) return false;
      }

      return true;
    }).toList();

    return Column(
      children: [
        // Top Sticky Search & Scope Section
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.surfaceContainerLow,
            border: Border(
              bottom: BorderSide(color: AppColors.borderSubtle, width: 0.8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scope header with live pulse
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.assured_workload,
                        size: 16,
                        color: AppColors.primaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'CAMPUS REGISTRY INDEX',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Real-time sync',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                color: AppColors.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Search Input with clear button
              Container(
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search serial, ref #, building, keyword...',
                    hintStyle: const TextStyle(fontSize: 13, color: AppColors.outline),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.secondary),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.cancel, size: 18, color: AppColors.outline),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Zone Dropdown Selector
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedZone,
                    isExpanded: true,
                    icon: const Icon(Icons.expand_more, size: 18, color: AppColors.outline),
                    items: _zones.map((zone) {
                      return DropdownMenuItem<String>(
                        value: zone['value'],
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, size: 15, color: AppColors.secondary),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                zone['label']!,
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontSize: 12,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedZone = val);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        // Segmented Control (All Records, Lost, Found)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildSegmentButton('all', 'All Records', MockData.items.length),
                _buildSegmentButton(
                  'lost',
                  'Lost',
                  MockData.items.where((i) => i.type == ItemType.lost).length,
                ),
                _buildSegmentButton(
                  'found',
                  'Found',
                  MockData.items.where((i) => i.type == ItemType.found).length,
                ),
              ],
            ),
          ),
        ),

        // Horizontal Category Chips
        SizedBox(
          height: 42,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            scrollDirection: Axis.horizontal,
            itemCount: ItemCategory.values.length,
            separatorBuilder: (_, _) => const SizedBox(width: 6),
            itemBuilder: (context, index) {
              final cat = ItemCategory.values[index];
              final isSelected = _selectedCategory == cat;

              return ChoiceChip(
                showCheckmark: false,
                avatar: Icon(
                  cat.icon,
                  size: 14,
                  color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                ),
                label: Text(
                  cat.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                  ),
                ),
                selected: isSelected,
                selectedColor: AppColors.primaryContainer,
                backgroundColor: AppColors.surfaceContainerHigh,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                  side: BorderSide.none,
                ),
                onSelected: (selected) {
                  setState(() => _selectedCategory = cat);
                },
              );
            },
          ),
        ),

        // Feed Header Info (Active Catalog count + sorting)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Active Catalog',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      '${filteredItems.length} Shown',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSecondaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.swap_vert, size: 16, color: AppColors.slateSecondary),
                  const SizedBox(width: 2),
                  Text(
                    'Latest First',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: AppColors.slateSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Scrollable Catalog List
        Expanded(
          child: filteredItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off, size: 40, color: AppColors.outline),
                      const SizedBox(height: 8),
                      Text(
                        'No registry records found',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Try adjusting your search terms or filters',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                  itemCount: filteredItems.length + 1, // +1 for the policy footer
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == filteredItems.length) {
                      return _buildPolicyFooter(context);
                    }
                    final item = filteredItems[index];
                    return _buildDirectoryCard(context, item);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSegmentButton(String type, String label, int count) {
    final isSelected = _typeFilter == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _typeFilter = type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x18000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDirectoryCard(BuildContext context, ItemRecord item) {
    final isFound = item.type == ItemType.found;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header: Category, Ref#, and Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isFound
                            ? AppColors.secondaryFixed
                            : AppColors.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        item.category.icon,
                        size: 16,
                        color: isFound
                            ? AppColors.onSecondaryContainer
                            : AppColors.onErrorContainer,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.category.label.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: isFound ? AppColors.secondary : AppColors.error,
                                letterSpacing: 0.5,
                              ),
                        ),
                        Text(
                          'Ref: ${item.refNumber}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: AppColors.slateSecondary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isFound
                        ? AppColors.secondaryContainer
                        : AppColors.errorContainer,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isFound ? Icons.verified_user : Icons.warning_amber_rounded,
                        size: 12,
                        color: isFound
                            ? AppColors.onSecondaryContainer
                            : AppColors.onErrorContainer,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        isFound ? 'Found - Safe Hands' : 'Active Lost Report',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: isFound
                                  ? AppColors.onSecondaryContainer
                                  : AppColors.onErrorContainer,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Item Title
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),

            // Description
            Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: 10),

            // Campus Building Box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.corporate_fare, size: 15, color: AppColors.secondary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.location,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 13, color: AppColors.outline),
                          const SizedBox(width: 4),
                          Text(
                            'Logged: ${item.date}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            isFound ? Icons.security : Icons.person,
                            size: 13,
                            color: isFound ? AppColors.secondary : AppColors.outline,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            isFound ? 'Security Post 2' : 'Claimant Verified',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isFound ? AppColors.secondary : AppColors.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Bottom CTA: Custody status & View Formal Record Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isFound ? 'Custodian custody confirmed' : 'Claimant validation required',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: AppColors.outline,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemDetailScreen(item: item),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward, size: 14),
                  label: const Text('View Formal Record'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFound
                        ? AppColors.primaryContainer
                        : AppColors.surfaceContainerHigh,
                    foregroundColor: isFound
                        ? AppColors.onPrimary
                        : AppColors.primaryContainer,
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.policy, size: 18, color: AppColors.secondary),
          ),
          const SizedBox(height: 6),
          Text(
            'Institutional Custody Policy',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Unclaimed items are retained under Catanduanes State University safety protocols for 60 calendar days before official registrar disposition.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }
}
