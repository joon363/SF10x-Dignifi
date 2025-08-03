import '../models/taskModel.dart';

final TaskGroup idsAndBenefits = TaskGroup(
  groupId: 0,
  groupName: 'IDs & Benefits',
  groupExplanation: 'Essential Documentation',
  tasks: [
    Task(taskIdx: 0, title: "Gather required documents", explanation: "SSN, proof of identity, 2 proofs of CA residency"),
    Task(taskIdx: 1, title: "Fill out DL-44", explanation: "https://www.dmv.ca.gov/portal/driver-licenses-identification-cards/dl-id-online-app-edl-44/"),
    Task(taskIdx: 2, title: "Fill out fee waiver", explanation: "Homeless: affidavit of homeless status: https://www.cdph.ca.gov/Programs/CHSI/CDPH%20Document%20Library/Affidavit%20for%20Free%20Certified%20Copy%20of%20Birth%20Certificate%20-%208-15.pdf\\n\\nIf you receive public benefits fill Form DL 937 (request from shelter/reentry/caseworker staff and have them sign it)"),
    Task(taskIdx: 3, title: "Schedule a DMV appointment", explanation: "https://www.dmv.ca.gov/portal/appointments/select-appointment-type"),
    Task(taskIdx: 4, title: "Upload a picture of your ID", explanation: "Wait 2-4 weeks"),
    Task(taskIdx: 5, title: "Get an email address", explanation: "https://support.google.com/mail/answer/56256?hl=en"),
    Task(taskIdx: 6, title: "Apply for Cal Fresh and MediCal", explanation: "https://benefitscal.com/ApplyForBenefits/begin/ABOVR?lang=en"),
    Task(taskIdx: 7, title: "Upload a picture of your CalFresh card", explanation: ""),
    Task(taskIdx: 8, title: "Upload a picture of your MediCal card", explanation: ""),
  ],
);

final TaskGroup transitionalHousing = TaskGroup(
  groupId: 1,
  groupName: 'Transitional Housing',
  groupExplanation: 'Temporary shelter planning',
  tasks: [
    Task(taskIdx: 0, title: "Get skills training", explanation: "ask the chatbot for places for skills training"),
    Task(taskIdx: 1, title: "Create a resume", explanation: "ask the chatbot for serices to help with resume creation"),
    Task(taskIdx: 2, title: "Prepare for an interview", explanation: "ask the chatbot for services to assist with interview preparation"),
    Task(taskIdx: 3, title: "Find professional interview clothes", explanation: "ask the chatbot for services that provide free professional clothes"),
    Task(taskIdx: 4, title: "Apply for a job", explanation: "ask the chatbot for job application sites"),
    Task(taskIdx: 5, title: "Upload a picture of start date, pay stub, or other verification of employment", explanation: ""),
  ],
);

final TaskGroup permanentHousing = TaskGroup(
  groupId: 2,
  groupName: 'Permanent Housing',
  groupExplanation: 'Long-term stable living',
  tasks: [
    Task(taskIdx: 0, title: "Go to an access point", explanation: "Access points are picky and may refer you to other places. They'll help you find rental assistance and find permanet below-market rate housing"),
    Task(taskIdx: 1, title: "Find rental assistance", explanation: "Find help from an access point or ask the chatbot to provide you with rental assistance services"),
    Task(taskIdx: 2, title: "Find permanent housing", explanation: "Find help from an access point or ask the chatbot to provide you with below market rate housing services"),
  ],
);

final List<TaskGroup> categoriesData = [idsAndBenefits, transitionalHousing, permanentHousing];

String dummyStepsResponseJson = '''
[
  {
    "groupID": 0,
    "groupName": "ID & Benefits",
    "groupExplanation": "Essential Documentation",
    "tasks": [
      {
        "taskidx": 0,
        "title": "Gather required documents",
        "explanation": "SSN, proof of identity, 2 proofs of CA residency",
        "isDone": 0
      },
      {
        "taskidx": 1,
        "title": "Fill out DL-44",
        "explanation": "https://www.dmv.ca.gov/portal/driver-licenses-identification-cards/dl-id-online-app-edl-44/",
        "isDone": 0
      },
      {
        "taskidx": 2,
        "title": "Fill out fee waiver",
        "explanation": "Homeless: affidavit of homeless status: https://www.cdph.ca.gov/Programs/CHSI/CDPH%20Document%20Library/Affidavit%20for%20Free%20Certified%20Copy%20of%20Birth%20Certificate%20-%208-15.pdf\\n\\nIf you receive public benefits fill Form DL 937 (request from shelter/reentry/caseworker staff and have them sign it)",
        "isDone": 0
      },
      {
        "taskidx": 3,
        "title": "Schedule a DMV appointment",
        "explanation": "https://www.dmv.ca.gov/portal/appointments/select-appointment-type",
        "isDone": 0
      },
      {
        "taskidx": 4,
        "title": "Upload a picture of your ID",
        "explanation": "Wait 2-4 weeks",
        "isDone": 0
      },
      {
        "taskidx": 5,
        "title": "Get an email address",
        "explanation": "https://support.google.com/mail/answer/56256?hl=en",
        "isDone": 0
      },
      {
        "taskidx": 6,
        "title": "Apply for Cal Fresh and MediCal",
        "explanation": "https://benefitscal.com/ApplyForBenefits/begin/ABOVR?lang=en",
        "isDone": 0
      },
      {
        "taskidx": 7,
        "title": "Upload a picture of your CalFresh card",
        "explanation": "",
        "isDone": 0
      },
      {
        "taskidx": 8,
        "title": "Upload a picture of your MediCal card",
        "explanation": "",
        "isDone": 0
      }
    ]
  },
  {
    "groupID": 1,
    "groupName": "Employment",
    "groupExplanation": "Temporary shelter planning",
    "tasks": [
      {
        "taskidx": 0,
        "title": "Get skills training",
        "explanation": "ask the chatbot for places for skills training",
        "isDone": 0
      },
      {
        "taskidx": 1,
        "title": "Create a resume",
        "explanation": "ask the chatbot for serices to help with resume creation",
        "isDone": 0
      },
      {
        "taskidx": 2,
        "title": "Prepare for an interview",
        "explanation": "ask the chatbot for services to assist with interview preparation",
        "isDone": 0
      },
      {
        "taskidx": 3,
        "title": "Find professional interview clothes",
        "explanation": "ask the chatbot for services that provide free professional clothes",
        "isDone": 0
      },
      {
        "taskidx": 4,
        "title": "Apply for a job",
        "explanation": "ask the chatbot for job application sites",
        "isDone": 0
      },
      {
        "taskidx": 5,
        "title": "Upload a picture of start date, pay stub, or other verification of employment",
        "explanation": "",
        "isDone": 0
      }
    ]
  },
  {
    "groupID": 2,
    "groupName": "Housing",
    "groupExplanation": "Long-term stable living",
    "tasks": [
      {
        "taskidx": 0,
        "title": "Go to an access point",
        "explanation": "Access points are picky and may refer you to other places. They'll help you find rental assistance and find permanet below-market rate housing",
        "isDone": 0
      },
      {
        "taskidx": 1,
        "title": "Find rental assistance",
        "explanation": "Find help from an access point or ask the chatbot to provide you with rental assistance services",
        "isDone": 0
      },
      {
        "taskidx": 2,
        "title": "Find permanent housing",
        "explanation": "Find help from an access point or ask the chatbot to provide you with below market rate housing services",
        "isDone": 0
      }
    ]
  }
]
''';
