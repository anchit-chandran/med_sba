import 'package:flutter/material.dart';

const questionData = {
  1: {
    "questionNumber": 1,
    "stem":
        "A 65-year-old male patient presents to the emergency department with central chest pain radiating to his left arm, which started 2 hours ago. He is sweating profusely and looks pale. His past medical history includes hypertension and type 2 diabetes mellitus. An ECG shows ST-segment elevation in leads II, III, and aVF. His blood pressure is 135/85 mmHg, and his pulse is 90 beats per minute.\n\nWhich of the following is the most appropriate next step in management?",
    "answers": {
      'answer1': 'Immediate administration of a sublingual nitrate',
      'answer2': 'Urgent coronary angiography',
      'answer3': 'Intravenous administration of a fibrinolytic agent',
      'answer4': 'High-dose oral aspirin and a beta-blocker',
      'answer5': 'Observation and repeat ECG in one hour',
    },
    "correctAnswer": 1,
  },
  2: {
    "questionNumber": 2,
    "stem":
        "A 58-year-old woman presents with a 3-month history of progressive dyspnea and dry cough. She has never smoked and has no significant past medical history. Physical examination reveals fine crackles at the lung bases. A high-resolution CT scan shows bilateral pulmonary fibrosis.\n\nWhich of the following is the most likely diagnosis?",
    "answers": {
      'answer1': 'Chronic obstructive pulmonary disease (COPD)',
      'answer2': 'Asthma',
      'answer3': 'Idiopathic pulmonary fibrosis',
      'answer4': 'Lung carcinoma',
      'answer5': 'Pulmonary embolism',
    },
    "correctAnswer": 3,
  },
  3: {
    "questionNumber": 3,
    "stem":
        "A 45-year-old man with a history of intravenous drug use presents with fever, weight loss, and a new heart murmur. Blood cultures grow Staphylococcus aureus. An echocardiogram shows vegetations on the tricuspid valve.\n\nWhat is the most likely diagnosis?",
    "answers": {
      'answer1': 'Acute pericarditis',
      'answer2': 'Infective endocarditis',
      'answer3': 'Rheumatic heart disease',
      'answer4': 'Aortic stenosis',
      'answer5': 'Myocardial infarction',
    },
    "correctAnswer": 2,
  },
  4: {
    "questionNumber": 4,
    "stem":
        "A 50-year-old male with a history of smoking and chronic alcoholism presents with epigastric pain radiating to the back, nausea, and vomiting. Laboratory tests reveal elevated serum amylase and lipase levels.\n\nWhat is the most appropriate initial management?",
    "answers": {
      'answer1': 'Endoscopic retrograde cholangiopancreatography (ERCP)',
      'answer2': 'Intravenous fluid resuscitation',
      'answer3': 'Immediate surgery',
      'answer4': 'Oral pancreatic enzyme supplements',
      'answer5': 'Proton pump inhibitor therapy',
    },
    "correctAnswer": 2,
  },
  5: {
    "questionNumber": 5,
    "stem":
        "A 30-year-old woman presents with a two-day history of painful, burning urination and increased urinary frequency. She has no significant past medical history and takes no medications. A urine dipstick test is positive for nitrites.\n\nWhat is the most appropriate treatment?",
    "answers": {
      'answer1': 'Oral ciprofloxacin',
      'answer2': 'Intravenous fluids',
      'answer3': 'Oral paracetamol',
      'answer4': 'Behavioral modification and pelvic floor exercises',
      'answer5': 'Intramuscular ceftriaxone',
    },
    "correctAnswer": 1,
  },
  6: {
    "questionNumber": 6,
    "stem":
        "A 70-year-old man with a history of hypertension and hyperlipidemia presents with sudden onset of severe headache, nausea, and vomiting. Examination reveals a stiff neck but no focal neurological deficits. A CT scan of the head is normal.\n\nWhat is the most appropriate next step in management?",
    "answers": {
      'answer1': 'Lumbar puncture',
      'answer2': 'Immediate neurosurgery consultation',
      'answer3': 'Start antihypertensive therapy',
      'answer4': 'Magnetic resonance imaging (MRI) of the brain',
      'answer5': 'Observe and repeat CT scan in 24 hours',
    },
    "correctAnswer": 1,
  },
  7: {
    "questionNumber": 7,
    "stem":
        "A 25-year-old woman presents with a three-day history of painful red eyes, photophobia, and blurred vision. Examination reveals bilateral conjunctival injection and corneal haziness. Slit-lamp examination shows cells in the anterior chamber.\n\nWhat is the most likely diagnosis?",
    "answers": {
      'answer1': 'Bacterial conjunctivitis',
      'answer2': 'Keratitis',
      'answer3': 'Acute glaucoma',
      'answer4': 'Uveitis',
      'answer5': 'Viral conjunctivitis',
    },
    "correctAnswer": 4,
  },
  8: {
    "questionNumber": 8,
    "stem":
        "A 60-year-old man with a history of smoking presents with hemoptysis, weight loss, and a cough lasting for 3 months. A chest X-ray reveals a mass in the right upper lobe.\n\nWhat is the most appropriate next step?",
    "answers": {
      'answer1': 'Start antituberculosis therapy',
      'answer2': 'Perform a bronchoscopy',
      'answer3': 'Prescribe a course of broad-spectrum antibiotics',
      'answer4': 'Immediate lobectomy',
      'answer5': 'CT scan of the chest',
    },
    "correctAnswer": 2,
  },
  9: {
    "questionNumber": 9,
    "stem":
        "A 55-year-old man with a long history of type 2 diabetes mellitus presents with decreased sensation in his feet, bilateral foot ulcers, and intermittent claudication. His pulses are diminished in both feet.\n\nWhat is the most likely underlying condition?",
    "answers": {
      'answer1': 'Diabetic neuropathy',
      'answer2': 'Peripheral arterial disease',
      'answer3': 'Venous stasis ulcers',
      'answer4': 'Charcot foot',
      'answer5': 'Deep vein thrombosis',
    },
    "correctAnswer": 2,
  },
  10: {
    "questionNumber": 10,
    "stem":
        "A 40-year-old woman with a history of systemic lupus erythematosus presents with fatigue, arthralgia, and a facial rash. Laboratory tests show hematuria and proteinuria. A renal biopsy is performed and shows glomerulonephritis.\n\nWhat is the most appropriate initial treatment?",
    "answers": {
      'answer1': 'High-dose corticosteroids',
      'answer2': 'Non-steroidal anti-inflammatory drugs (NSAIDs)',
      'answer3': 'Cyclophosphamide',
      'answer4': 'Renal transplantation',
      'answer5': 'Angiotensin-converting enzyme (ACE) inhibitors',
    },
    "correctAnswer": 1,
  },
};

class QuestionNotifier extends ChangeNotifier {
  int _selectedAnswer = -1;
  bool _hasSubmittedAnswer = false;
  bool _isCorrect = false;
  int _currentQuestionNum = 1;
  var _currentQuestionData = questionData[1]!;

  get selectedAnswer => _selectedAnswer;
  get hasSubmittedAnswer => _hasSubmittedAnswer;
  get isCorrect => _isCorrect;
  get currentQuestionData => _currentQuestionData;
  get currentQuestionNum => _currentQuestionNum;

  void changeAnswer(int newAnswer) {
    _selectedAnswer = newAnswer;
    notifyListeners();
  }

  void setSubmittedAnswer() {
    _hasSubmittedAnswer = true;
    notifyListeners();
  }

  void setIsCorrect() {
    _isCorrect = true;
    notifyListeners();
  }

  void resetStateFields() {
    _selectedAnswer = -1;
    _hasSubmittedAnswer = false;
    _isCorrect = false;
  }

  void changeQuestion(int newQuestion) {
    resetStateFields();
    print('changing question to $newQuestion');
    _currentQuestionNum = newQuestion;
    _currentQuestionData = questionData[_currentQuestionNum]!;
    notifyListeners();
  }

  int getTotalQuestions() {
    return questionData.length;
  }
}
