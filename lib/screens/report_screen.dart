import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';

class ReportScreen extends StatefulWidget {
  final ItemType initialType;
  final VoidCallback onReportCompleted;

  const ReportScreen({
    super.key,
    this.initialType = ItemType.lost,
    required this.onReportCompleted,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late ItemType _reportType;
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _colorsController = TextEditingController();
  final _brandController = TextEditingController();
  final _markingsController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _contactController = TextEditingController(text: 'student.202210842@catsu.edu.ph');

  String _selectedCategory = 'Electronics (Calculators, USB, Devices)';
  String _selectedZone = 'Main Campus - CICT Building';
  String _selectedCustody = 'Surrendered to Security Post 1 (Main Gate)';
  DateTime _incidentDate = DateTime.now();
  TimeOfDay _incidentTime = const TimeOfDay(hour: 13, minute: 30);

  final List<String> _categories = [
    'Electronics (Calculators, USB, Devices)',
    'Student ID, Cards & Official Records',
    'Books & Academic Notebooks / Manuals',
    'Uniforms, Regalia & Apparel',
    'Personal Accessories, Keys & Tumblers',
    'Laboratory Tools & Medical Supplies',
    'Other Campus Articles',
  ];

  final List<String> _zones = [
    'Main Campus - CICT Building',
    'College of Engineering',
    'Central Library & Learning Commons',
    'University Oval & Bleachers',
    'Student Center & Food Park',
    'Administration Hall & Registrar',
    'Office of Student Affairs (OSA)',
    'University Gymnasium',
  ];

  final List<String> _custodyOptions = [
    'Surrendered to Security Post 1 (Main Gate)',
    'With OSA Custodian Desk',
    "In Reporter's Temporary Possession (Awaiting turn-in)",
    'Surrendered to Dean / Department Clerk',
  ];

  @override
  void initState() {
    super.initState();
    _reportType = widget.initialType;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _colorsController.dispose();
    _brandController.dispose();
    _markingsController.dispose();
    _landmarkController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLost = _reportType == ItemType.lost;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reassurance Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified_user,
                      color: AppColors.primaryContainer,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Official Campus Incident Form',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.primaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Catanduanes State University Lost & Found Registry',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Segmented Type Selector (Report Lost vs Report Found)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _reportType = ItemType.lost),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: isLost ? AppColors.primaryContainer : Colors.transparent,
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: isLost
                              ? const [
                                  BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                  )
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 16,
                              color: isLost ? Colors.white : AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Report Lost Property',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isLost ? FontWeight.w700 : FontWeight.w500,
                                color: isLost ? Colors.white : AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _reportType = ItemType.found),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: !isLost ? AppColors.primaryContainer : Colors.transparent,
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: !isLost
                              ? const [
                                  BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                  )
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2,
                              size: 16,
                              color: !isLost ? Colors.white : AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Report Found Article',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: !isLost ? FontWeight.w700 : FontWeight.w500,
                                color: !isLost ? Colors.white : AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            // Helper text & Case ID preview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isLost
                        ? 'Filing an incident log for your missing item'
                        : 'Registering an article discovered within campus',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: AppColors.secondary,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'Case #CATSU-2024-T89',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: AppColors.onSurfaceVariant,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // SECTION 1: Item Classification
            _buildSectionCard(
              context,
              number: '1',
              title: 'Item Classification',
              children: [
                _buildFieldLabel('Item Title / Designation *'),
                TextFormField(
                  controller: _titleController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  decoration: const InputDecoration(
                    hintText: 'e.g., Casio Scientific Calculator fx-991EX',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Be specific with make, model, or formal publication name.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                ),
                const SizedBox(height: 12),
                _buildFieldLabel('Primary Category *'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      items: _categories.map((c) {
                        return DropdownMenuItem(
                          value: c,
                          child: Text(
                            c,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _selectedCategory = v);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // SECTION 2: Detailed Textual Identification
            _buildSectionCard(
              context,
              number: '2',
              title: 'Detailed Textual Identification',
              children: [
                _buildFieldLabel('Primary & Secondary Colors *'),
                TextFormField(
                  controller: _colorsController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  decoration: const InputDecoration(
                    hintText: 'e.g., Matte Black with silver trim',
                  ),
                ),
                const SizedBox(height: 12),
                _buildFieldLabel('Brand / Manufacturer'),
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    hintText: 'e.g., Casio / Sharp / Apple / Miniso',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFieldLabel('Distinguishing Features / Inscriptions *'),
                    Text(
                      '${_markingsController.text.length} / 250',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _markingsController,
                  maxLength: 250,
                  maxLines: 3,
                  onChanged: (_) => setState(() {}),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  decoration: const InputDecoration(
                    hintText:
                        'e.g., Has a small scratch near the solar cell, white sticker on back with initial JLD, blue lanyard strap attached.',
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Include custom stickers, visible serial fragments, engravings, or wear marks.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // SECTION 3: Campus Location & Chronology
            _buildSectionCard(
              context,
              number: '3',
              title: 'Campus Location & Chronology',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Incident Date *'),
                          InkWell(
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _incidentDate,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2027),
                              );
                              if (d != null) setState(() => _incidentDate = d);
                            },
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_incidentDate.year}-${_incidentDate.month.toString().padLeft(2, '0')}-${_incidentDate.day.toString().padLeft(2, '0')}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const Icon(Icons.calendar_today, size: 16, color: AppColors.outline),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Approx. Time *'),
                          InkWell(
                            onTap: () async {
                              final t = await showTimePicker(
                                context: context,
                                initialTime: _incidentTime,
                              );
                              if (t != null) setState(() => _incidentTime = t);
                            },
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _incidentTime.format(context),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const Icon(Icons.schedule, size: 16, color: AppColors.outline),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildFieldLabel('Campus Zone / Facility *'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedZone,
                      isExpanded: true,
                      items: _zones.map((z) {
                        return DropdownMenuItem(
                          value: z,
                          child: Text(z, style: Theme.of(context).textTheme.bodyMedium),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _selectedZone = v);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildFieldLabel('Specific Room or Landmark *'),
                TextFormField(
                  controller: _landmarkController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  decoration: const InputDecoration(
                    hintText: 'e.g., Room 204 near the left window',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // SECTION 4: Custody & Verification Protocol
            _buildSectionCard(
              context,
              number: '4',
              title: 'Custody & Verification Protocol',
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFieldLabel('Custody Status'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: isLost ? AppColors.surfaceContainerHigh : AppColors.secondaryContainer,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        isLost ? 'Optional for Lost Claims' : 'Required Verification',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: isLost ? AppColors.onSurfaceVariant : AppColors.onSecondaryContainer,
                            ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCustody,
                      isExpanded: true,
                      items: _custodyOptions.map((opt) {
                        return DropdownMenuItem(
                          value: opt,
                          child: Text(
                            opt,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _selectedCustody = v);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildFieldLabel('Institutional Email / Mobile Number *'),
                TextFormField(
                  controller: _contactController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email, size: 18, color: AppColors.secondary),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Official notifications and recovery clearance pins will be dispatched here.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Student Code Compliance Notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.gavel, color: AppColors.secondary, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              height: 1.35,
                            ),
                        children: const [
                          TextSpan(
                            text: 'By submitting, you certify that all information provided is accurate and under the ',
                          ),
                          TextSpan(
                            text: 'CATSU Student Code of Conduct',
                            style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.onSurface),
                          ),
                          TextSpan(
                            text: '. False reports or fraudulent custody claims are subject to administrative disciplinary proceedings.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Submit Button
            ElevatedButton.icon(
              onPressed: _handleSubmit,
              icon: const Icon(Icons.assignment_turned_in, size: 20),
              label: Text(
                isLost
                    ? 'Submit Official Report to Registry'
                    : 'Register Found Article to Registry',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.onPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // Cancel Button
            Center(
              child: TextButton(
                onPressed: () {
                  _formKey.currentState?.reset();
                  widget.onReportCompleted();
                },
                child: Text(
                  'Cancel and Discard Draft',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.slateSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String number,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSecondaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.primaryContainer,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Report Registered',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        height: 1.4,
                      ),
                  children: const [
                    TextSpan(text: 'Your item has been cataloged under Case Log '),
                    TextSpan(
                      text: '#CATSU-2024-T89',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                    TextSpan(
                      text: '. An acknowledgement has been transmitted to your university portal.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  widget.onReportCompleted();
                },
                child: const Text('View in Active Registry'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
