import 'package:flutter/material.dart';

enum ItemType { lost, found }

enum ItemCategory {
  all('All Categories', Icons.grid_view),
  electronics('Electronics', Icons.devices),
  ids('IDs & Cards', Icons.badge),
  docs('Documents & Books', Icons.menu_book),
  bags('Bags & Wallets', Icons.backpack),
  personal('Personal Items', Icons.watch),
  keys('Keys', Icons.key);

  final String label;
  final IconData icon;
  const ItemCategory(this.label, this.icon);
}

enum ReportStatus {
  activeLost('Active Lost Report'),
  safekeptFound('Safekept & Verified'),
  inVerification('In Verification Stage'),
  pendingMatch('Potential Match Found'),
  resolved('Closed & Archived');

  final String label;
  const ReportStatus(this.label);
}

class ItemRecord {
  final String id;
  final String refNumber;
  final String title;
  final String description;
  final ItemType type;
  final ItemCategory category;
  final ReportStatus status;
  final String location;
  final String subLocation;
  final String date;
  final String time;
  final String custodian;
  final String colorAndBuild;
  final String distinguishingMarks;
  final String contact;
  final bool hasPotentialMatch;
  final String? matchedAssetCode;
  final String? custodianNotes;

  const ItemRecord({
    required this.id,
    required this.refNumber,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.status,
    required this.location,
    required this.subLocation,
    required this.date,
    required this.time,
    required this.custodian,
    required this.colorAndBuild,
    required this.distinguishingMarks,
    required this.contact,
    this.hasPotentialMatch = false,
    this.matchedAssetCode,
    this.custodianNotes,
  });
}

class MockData {
  static final List<ItemRecord> items = [
    const ItemRecord(
      id: '1',
      refNumber: 'CATSU-LF-2024-0412',
      title: 'Casio Scientific Calculator fx-991CW',
      description:
          'Black standard casing with subtle stencil mark "BSIT 3-D" on inside cover and battery compartment. Left on desk 4 during Calculus period.',
      type: ItemType.found,
      category: ItemCategory.electronics,
      status: ReportStatus.safekeptFound,
      location: 'Main Campus - CICT Building',
      subLocation: 'Computer Laboratory 3 • Terminal 14',
      date: 'Oct 24, 2024',
      time: '10:15 AM',
      custodian: 'CICT Department Secretary Office (Prof. R. Fernandez)',
      colorAndBuild: 'Matte Black, ClassWiz Series Casing with Natural-V.P.A.M.',
      distinguishingMarks:
          'White name label inside cover reading "BSIT 3-D", light sticker residue near power key, minor wear on shift button.',
      contact: 'prof.fernandez@catsu.edu.ph',
    ),
    const ItemRecord(
      id: '2',
      refNumber: 'CATSU-LF-2024-0408',
      title: 'CATSU Official Student ID (Card #22-01492)',
      description:
          'Undergraduate ID belonging to BS Biology student Mark Santos. Transparent plastic sleeve with green university lanyard clip attached.',
      type: ItemType.lost,
      category: ItemCategory.ids,
      status: ReportStatus.activeLost,
      location: 'College of Science & Lab Compound',
      subLocation: 'Near Old Science Hall Walkway',
      date: 'Oct 23, 2024',
      time: '01:30 PM',
      custodian: 'Pending Turn-in / Campus Security Desk',
      colorAndBuild: 'Plastic Laminated PVC ID with Green CATSU Lanyard',
      distinguishingMarks:
          'Student Number #22-01492 clearly legible, biology department holographic validation seal for AY 2024-2025.',
      contact: 'student.santos@catsu.edu.ph',
    ),
    const ItemRecord(
      id: '3',
      refNumber: 'CATSU-LF-2024-0399',
      title: 'Blue Corduroy Backpack with Math Modules',
      description:
          'Contains bound syllabus notes for Advanced Calculus, branded pencil pouch, and stainless tumbler. No wallet discovered inside.',
      type: ItemType.found,
      category: ItemCategory.bags,
      status: ReportStatus.safekeptFound,
      location: 'University Oval & Bleachers',
      subLocation: 'West Bleachers • Upper Tier 2',
      date: 'Oct 21, 2024',
      time: '04:45 PM',
      custodian: 'Office of Student Affairs (OSA) Custodian Desk',
      colorAndBuild: 'Navy Blue Corduroy Fabric with Brass Zippers',
      distinguishingMarks:
          'CATSU College of Education pin on front pocket; handwritten name "J. Cruz" on calculus module binder.',
      contact: 'osa.custody@catsu.edu.ph',
    ),
    const ItemRecord(
      id: '4',
      refNumber: 'CATSU-LF-2024-0395',
      title: 'Wireless Earbuds Charging Case (Gloss White)',
      description:
          'Small oval wireless case with custom engraved initials "J.M.V." along lower hinge. Earbuds were missing from case when discovered.',
      type: ItemType.lost,
      category: ItemCategory.electronics,
      status: ReportStatus.activeLost,
      location: 'Administration Hall & Registrar',
      subLocation: 'Lobby Visitor Benches',
      date: 'Oct 20, 2024',
      time: '11:20 AM',
      custodian: 'Reported by Student Claimant',
      colorAndBuild: 'Glossy White Polycarbonate Capsule Case',
      distinguishingMarks:
          'Micro laser engraving "J.M.V." near USB-C port, tiny dent on left corner.',
      contact: 'jmv.student@catsu.edu.ph',
    ),
    const ItemRecord(
      id: '5',
      refNumber: 'CATSU-LF-2024-0388',
      title: 'Brown Leather Bi-fold Wallet',
      description:
          'Contains CatSU Student ID and Landbank ATM card. Owner actively coordinating with Campus Security post.',
      type: ItemType.lost,
      category: ItemCategory.bags,
      status: ReportStatus.activeLost,
      location: 'University Gymnasium',
      subLocation: 'Bleachers South Gate',
      date: 'Oct 23, 2024',
      time: '03:10 PM',
      custodian: 'Reported Active Lost Log',
      colorAndBuild: 'Genuine Dark Brown Leather with contrast stitching',
      distinguishingMarks:
          'Contains Landbank ATM, CatSU Library Pass with name Jansen Lee Matienzo.',
      contact: 'jm.matienzo@catsu.edu.ph',
    ),
    const ItemRecord(
      id: '6',
      refNumber: 'CATSU-LF-2024-0371',
      title: 'Hydro Flask Tumbler (32oz)',
      description:
          'Olive Green matte finish with Computer Science & Git stickers. Retrieved at General Reference study carrel.',
      type: ItemType.found,
      category: ItemCategory.personal,
      status: ReportStatus.safekeptFound,
      location: 'Central Library & Learning Commons',
      subLocation: '2nd Floor Reference Section • Carrel 12',
      date: 'Oct 24, 2024',
      time: '02:40 PM',
      custodian: 'Central Library Circulation Desk',
      colorAndBuild: 'Olive Green Powder Coated Stainless Steel with Flex Cap',
      distinguishingMarks:
          'Hexagonal GitHub Octocat and Arch Linux vinyl stickers on front.',
      contact: 'library@catsu.edu.ph',
    ),
  ];

  static final List<ItemRecord> myReports = [
    const ItemRecord(
      id: 'my-1',
      refNumber: 'CATSU-LF-2024-0419',
      title: 'Scientific Calculator fx-570ES Plus',
      description:
          'Dark gray casing with university sticker barcode #ENG-4891 etched slightly on sliding rear battery cover.',
      type: ItemType.lost,
      category: ItemCategory.electronics,
      status: ReportStatus.pendingMatch,
      location: 'Engineering & Architecture Precinct',
      subLocation: 'CICT Rm 201 • Engineering & Technology Building',
      date: 'Oct 22, 2024',
      time: '09:00 AM',
      custodian: 'Campus Security Office (Admin Ground Floor)',
      colorAndBuild: 'Dark Gray Plastic Shell with Slide-on Hard Case',
      distinguishingMarks:
          'Rear cover has etched sticker mark #ENG-4891 and owner initials JLM.',
      contact: 'jm.matienzo@catsu.edu.ph',
      hasPotentialMatch: true,
      matchedAssetCode: 'CALC-CICT-2024-102',
      custodianNotes:
          'Casio scientific calculator recovered from CICT bench podium after 3rd period lecture. Battery casing matches report marking #ENG-4891. Stored in Security Locker B-4.',
    ),
    const ItemRecord(
      id: 'my-2',
      refNumber: 'CATSU-LF-2024-0382',
      title: 'Set of 3 Yale Keys with Red CATSU Lanyard',
      description:
          'Found hanging near the North Amphitheater bench. Secured with official custodian log reference #CSD-2024-884.',
      type: ItemType.found,
      category: ItemCategory.keys,
      status: ReportStatus.inVerification,
      location: 'Main Campus - Virac Central Quad',
      subLocation: 'North Amphitheater Walkway',
      date: 'Oct 20, 2024',
      time: '01:15 PM',
      custodian: 'OSA Security Central Desk (Officer R. Vargas)',
      colorAndBuild: '3 Brass Keys on Silver Split Ring with Red Woven Ribbon',
      distinguishingMarks:
          'Red CATSU Lanyard with gold foil university crest.',
      contact: 'jm.matienzo@catsu.edu.ph',
    ),
    const ItemRecord(
      id: 'my-3',
      refNumber: 'CATSU-LF-2024-0320',
      title: 'CATSU Student Handbook & ID Holder',
      description:
          'Claimed by registered owner: Maria C. (BSED 2-A) on Oct 15, 2024.',
      type: ItemType.found,
      category: ItemCategory.docs,
      status: ReportStatus.resolved,
      location: 'Central Library & Learning Commons',
      subLocation: 'Ground Floor Lobby',
      date: 'Oct 15, 2024',
      time: '11:00 AM',
      custodian: 'Office of Student Affairs (Closed Record #CR-4412)',
      colorAndBuild: 'Maroon Handbook with Clear Plastic Badge Holder',
      distinguishingMarks: 'Official University Handbook 2024 Edition.',
      contact: 'jm.matienzo@catsu.edu.ph',
    ),
  ];
}

