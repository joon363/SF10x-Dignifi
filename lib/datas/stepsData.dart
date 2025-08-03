import '../models/stepsModel.dart';

final StepCategory idsAndBenefits = StepCategory(
  title: 'IDs & Benefits',
  subtitle: 'Essential Documentation',
  steps: [
    StepItem(title: 'Gather required documents', subtitle: 'Birth certificate, Social Security card, proof of address', done: false),
    StepItem(title: 'Visit DMV for state ID', subtitle: 'Bring all documents and application fee', done :false),
    StepItem(title: 'Apply for SNAP benefits', subtitle: 'Visit local SNAP office or apply online', done: false),
    StepItem(title: 'Apply for Medicaid', subtitle: 'Health insurance through state program', done: false),
  ],
);

final StepCategory transitionalHousing = StepCategory(
  title: 'Transitional Housing',
  subtitle: 'Temporary shelter planning',
  steps: [
    StepItem(title: 'Find local transitional housing', subtitle: 'Use housing locator or contact shelters'),
    StepItem(title: 'Schedule intake interview', subtitle: 'Provide necessary documents and ID'),
    StepItem(title: 'Move-in preparation', subtitle: 'Pack essentials and coordinate transport'),
  ],
);

final StepCategory permanentHousing = StepCategory(
  title: 'Permanent Housing',
  subtitle: 'Long-term stable living',
  steps: [
    StepItem(title: 'Apply for housing voucher', subtitle: 'Through local housing authority'),
    StepItem(title: 'Find affordable units', subtitle: 'Search listings and contact landlords'),
    StepItem(title: 'Sign lease and move-in', subtitle: 'Review terms and move-in checklist'),
  ],
);

final List<StepCategory> categories = [idsAndBenefits, transitionalHousing, permanentHousing];
