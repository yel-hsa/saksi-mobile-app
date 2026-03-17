SAKSI: Community Mediation & Accountability System Project Description A
dual-platform IoT-based mobile application that tracks household noise
levels and provides objective evidence for community mediation. We\'ll
use custom ESP32 hardware to monitor decibels, Firebase to stream and
store data, and Gemini AI to generate insights and mediation reports.
The app should be utilitarian, sleek, and authoritative.

There should be an onboarding flow for users to sign up and pair their
IoT hardware. The application splits into two roles: Residents and
Barangay Officials. Residents have a dashboard displaying a real-time
decibel gauge and their personal violation history. Barangay Officials
have a Command Center displaying an interactive map with heatmaps of
active violations, analytics on repeat offenders, and the ability to
export AI-generated mediation reports.

The hardware relies on an ESP32 microcontroller, a MAX4466 Electret
Microphone Amplifier for accurate audio readings, and a NEO-6M GPS
module to lock the device to the resident\'s \"Home Zone.\"

Product Requirements Document Product Requirements Document: SAKSI

Introduction The \"SAKSI\" (Witness) application aims to provide
barangays with a dedicated platform to objectively monitor, record, and
report noise level violations. By acting as a digital witness, the
system eliminates subjective \"he-said, she-said\" arguments in
community disputes. Leveraging IoT hardware for data collection and
Gemini AI for report generation and community insights, the app fosters
accountability and peaceful mediation. The application will feature a
high-contrast, alert-oriented design directly translated from a provided
React design system.

Goals

To create an objective, tamper-proof system for logging noise complaints
using calibrated hardware.

To provide a real-time, intuitive dashboard for residents to
self-monitor their household noise.

To equip Barangay Officials with a comprehensive command center for
mapping active incidents and analyzing community trends.

To streamline the mediation process by generating official, AI-assisted
incident reports based on hard data.

To ensure data validity through GPS fencing, confirming hardware is in
its registered location.

Target Audience & Value Proposition Target Audience: Residents who want
to monitor their household noise or securely request mediation, and
Barangay Officials/Tanods responsible for community peace and order.
Value Proposition: \"SAKSI\" provides verifiable, location-locked
evidence for noise disputes. For residents, it offers a way to avoid
accidental violations through self-monitoring. For officials, it
replaces messy complaint logs with an automated dashboard, utilizing
Gemini AI to instantly draft professional mediation reports and predict
high-risk noise zones.

User Stories

General & Setup

As a new user, I want to securely log in or register my household.

As a resident, I want to pair my physical SAKSI IoT device with my app
and lock in my GPS \"Home Zone\".

As a user, I want the app to clearly distinguish between my role
(Resident) and an Admin role (Official).

Resident Experience

As a resident, I want to see a real-time gauge of my current household
decibel level so I know if I am being too loud.

As a resident, I want to view my personal history of noise violations to
hold myself accountable.

As a resident, I want a single \"Alert Barangay Assistance\" button in
case of an emergency or severe disturbance.

As a resident, I want my data to be private; I should not see a map of
my neighbors\' violations to prevent retaliation.

Barangay Official Experience

As an official, I want an interactive map showing heatmaps of active
noise violations across the community.

As an official, I want analytics identifying high-risk zones and repeat
household offenders.

As an official, I want to view detailed evidence (Time, Peak dB,
Duration, Hardware ID) for a specific case.

As an official, I want to generate a formal, AI-written PDF mediation
report to use in barangay hearings.

AI & Smart Features

As an official, I want Gemini AI to summarize complex raw data logs into
a readable paragraph for mediation reports.

As an official, I want Gemini AI to analyze weekly data to suggest where
to deploy Tanods.

As a resident, I want to use an AI chat assistant to ask questions about
local barangay noise ordinances.

Features

5.1. Splash Screen & Role Selection

Description: The entry point. Distinguishes between resident and
administrative access.

Components: SAKSI branding, \"Continue as Resident\" button, and
\"Barangay Official Portal\" button.

5.2. IoT Device Pairing (Resident Setup)

Description: Connects the user\'s account to their physical ESP32
hardware.

Components: Hardware scanning status, and a \"Lock Home Zone (GPS
Verification)\" toggle to register the NEO-6M coordinates.

5.3. Resident Dashboard (Real-Time Monitoring)

Description: The main interface for households to self-monitor.

Components: Large real-time noise level gauge (Speedometer style)
connected to Firebase Realtime Database. Pill-shaped status indicator
(e.g., SAFE, WARNING). \"ALERT BARANGAY ASSISTANCE\" emergency button.

5.4. Personal Violation History (Resident)

Description: Log of past infractions triggered by sustained noise above
a set dB limit.

Components: Summary of total monthly violations, scrollable list of
incident cards (Date/Time, Peak dB, Duration).

5.5. Official Command Center & Interactive Map (Admin)

Description: A live monitoring hub for community leaders.

Components: Map interface with glowing red heatmap markers for active
violations. Quick stats row (Active Alerts). Bottom sheet for
dispatching Tanods to specific zones.

5.6. Analytics & Repeat Offenders (Admin)

Description: Data analysis to deploy resources efficiently.

Components: Horizontal bar chart of noisiest areas, list view of repeat
offending households.

5.7. Exportable Reports & Mediation (Admin)

Description: Interface to view hard evidence and export it for hearings.

Components: List of case files. Detailed evidence view showing exact GPS
pin, peak decibel level, and duration. A button to generate a Gemini AI
summary and export as PDF.

Information Architecture / Data Model (Firebase NoSQL)

users Collection (Firestore):

uid: String (Firebase Auth ID)

role: String (\'resident\' or \'official\')

household_address: String

hardware_id: String (Linked ESP32 MAC address)

home_zone_lat: Number

home_zone_lng: Number

noise_logs Collection (Firestore):

log_id: String

hardware_id: String

user_id: String

peak_db: Number

duration_seconds: Number

timestamp: Timestamp

location_lat: Number

location_lng: Number

status: String (\'active\', \'resolved\')

live_decibels Node (Firebase Realtime Database):

hardware_id:

current_db: Number (Updated every second by ESP32)

is_online: Boolean

User Experience (UX) & Design Aesthetic

Overall Vision: Utilitarian, sleek, trustworthy, and urgent but not
cluttered. The app handles disputes and emergencies, so navigation must
be frictionless. Color Palette: High-contrast, alert-oriented, and
professional. Primary Action & Alerts: Crimson/Blood Red. Backgrounds &
Surfaces: Crisp White and Off-White/Light Grey. Text & Icons: Pitch
Black and Dark Charcoal. Typography: Modern, legible sans-serif (Inter
or Roboto). Heavy, bold weights for decibel numbers and alerts. Imagery:
Minimalist, data-driven interfaces. Clean maps and bold gauges.
Transitions: Fast, snappy, and responsive.

Technical Specifications

8.1. Technology Stack:

Frontend Framework: Flutter (Dart).

UI/UX Blueprint & Design System: Figma (React Export). The React
codebase generated by Figma (found in figma-make-local-runner) will
serve as the strict design system (spacing, typography, hex codes, and
component layout) to be translated into Flutter widgets via Trae AI.

Backend/Database/Auth: Firebase (Authentication, Firestore for static
logs, Realtime Database for live gauge).

Hardware: ESP32 DevKit V1, MAX4466 Electret Microphone Amplifier, U-blox
NEO-6M GPS Module.

Hardware Code: C++ via Arduino IDE.

AI Integration: Google Gemini AI API.

8.2. API Integrations:

Firebase SDK: For all CRUD operations and real-time streams.

Gemini AI API: For generating mediation reports and analyzing community
trends.

Non-Functional Requirements

9.1. Performance & Hardware:

Live decibel gauge must update within 1-2 seconds of real-world noise
via Firebase Realtime Database.

ESP32 must accurately calculate dB levels utilizing the MAX4466 op-amp
characteristics.

9.2. Security & Validation:

GPS Fencing: Cloud functions must validate that the ESP32\'s current GPS
reading matches the registered home_zone before writing a formal
violation to Firestore.

Role-Based Access: Residents must absolutely not be able to access the
Official Map or other users\' data.

Deployment & Hardware Distribution Strategy

Hardware Provisioning: SAKSI nodes will be distributed to households by
the barangay. Devices must be manually calibrated prior to deployment.

Cost: The software relies on generous free tiers of Firebase and Google
AI Studio.

Constraints and Limitations

Hardware Dependency: The system only works if the hardware is powered
on. If the ESP32 loses Wi-Fi, the app must display an \"Offline Mode\"
warning.

No Audio Recording: For privacy reasons, the hardware only transmits
numerical decibel values, never actual recorded audio files.

Technology Stack TECHSTACK

This document outlines the recommended technology stack for SAKSI,
providing justifications based on project requirements, IoT integration,
and real-time needs.

Frontend Framework & Design System

Flutter

Justification: Allows compilation to both Android and iOS from a single
codebase, ensuring maximum accessibility for residents regardless of
their device. Its widget-based architecture is perfect for building the
custom speedometer gauge and interactive maps.

Figma-Make React Export (figma-make-local-runner)

Justification: Acts as the exact visual blueprint. Rather than designing
from scratch in Flutter, developers will use Trae AI to translate the
precise CSS paddings, margins, colors, and layouts from the React
components into Flutter ThemeData and Widgets to maintain 1:1 design
fidelity.

Backend & Persistence

Firebase (Firestore & Realtime Database)

Justification: Firebase is tailor-made for IoT applications.

Realtime Database: Perfect for receiving rapid, per-second decibel
updates from the ESP32 to drive the resident\'s live gauge with minimal
latency.

Firestore: Ideal for storing structured, permanent records of actual
violations (noise_logs) and user profiles.

Authentication: Provides secure, out-of-the-box email/password sign-in.

Hardware Components

ESP32 DevKit V1

Justification: Provides 3.3V logic, dual-core processing, and essential
built-in Wi-Fi for pushing data to Firebase.

MAX4466 Electret Microphone Amplifier

Justification: Features a built-in Operational Amplifier (Op-Amp) with
high AVOL (125dB) and Rail-to-Rail outputs, allowing the ESP32 to
accurately map analog signals to true volume levels.

U-blox NEO-6M GPS Module (with Ceramic Antenna)

Justification: Provides necessary satellite data to establish
location-verified monitoring, ensuring users cannot move the device to
fake data.

AI Integration

Google Gemini AI

Justification: Powerful text generation and data analysis. It will
process JSON arrays of noise logs from Firestore to write
natural-language, professional mediation reports for barangay officials,
saving administrative time.

Project Structure PROJECT STRUCTURE

This section details the directory and file organization of the SAKSI
Flutter application.

Plaintext saksi_app/ ├── android/ ├── ios/ ├── lib/ │ ├── main.dart //
App entry point and Firebase initialization │ ├── core/ │ │ ├──
constants/ │ │ │ ├── app_colors.dart // Mapped exactly from React export
CSS │ │ │ └── text_styles.dart // Mapped exactly from React export CSS │
│ ├── services/ │ │ │ ├── firebase_auth_service.dart │ │ │ ├──
firestore_service.dart │ │ │ ├── realtime_db_service.dart // Handles
live ESP32 stream │ │ │ └── gemini_ai_service.dart // Handles AI report
generation │ │ └── utils/ │ │ └── gps_validator.dart │ ├── models/ │ │
├── user_model.dart │ │ └── noise_log_model.dart │ ├── ui/ │ │ ├──
shared/ │ │ │ ├── custom_button.dart // Recreated from React components
│ │ │ └── status_badge.dart │ │ ├── auth/ │ │ │ ├── splash_screen.dart │
│ │ └── login_screen.dart │ │ ├── resident/ │ │ │ ├──
setup_pairing_screen.dart │ │ │ ├── resident_dashboard.dart // Contains
the live gauge │ │ │ ├── history_screen.dart │ │ │ └──
settings_screen.dart │ │ └── official/ │ │ ├── command_center_map.dart
// Main admin map │ │ ├── analytics_screen.dart │ │ ├──
reports_list_screen.dart │ │ └── evidence_detail_screen.dart ├──
pubspec.yaml // Dependencies (firebase_core, google_generative_ai, etc.)
└── README.md Database Schema Design SCHEMADESIGN

OVERVIEW The database schema utilizes Firebase\'s NoSQL infrastructure.
It splits responsibilities: rapid telemetry goes to the Realtime
Database, while permanent structured data goes to Firestore.

CORE COLLECTIONS (Firestore)

2.1. users Collection \* uid (String, Document ID): Matches Firebase
Auth uid. \* role (String): \'resident\' or \'official\'. \* hardware_id
(String): The MAC address of their assigned ESP32. \* home_zone
(GeoPoint): Registered GPS coordinates. \* created_at (Timestamp).

2.2. noise_logs Collection \* log_id (String, Auto-ID). \* hardware_id
(String): References the device that triggered it. \* user_id (String):
References the resident. \* peak_db (Number): E.g., 88.5. \*
duration_seconds (Number). \* timestamp (Timestamp). \* location
(GeoPoint). \* status (String): \'active\', \'notified\', \'resolved\'.
\* ai_summary (String): The text generated by Gemini, if applicable.

REALTIME DATABASE STRUCTURE \* live_decibels/ \* {hardware_id}/ \*
current_db (Number): Overwritten every 1 second by ESP32. \* last_ping
(Timestamp): To determine if the device is offline.

SECURITY RULES

Realtime DB: ESP32s can only write to their own {hardware_id} node.
Residents can only read their own {hardware_id} node.

Firestore noise_logs: Residents can only read documents where user_id ==
request.auth.uid. Officials (verified via custom claims or role in users
collection) can read all documents.

User Flow USERFLOW

A. User Flow 1: Resident Hardware Setup

Launch app -\> Splash Screen -\> Select \"Continue as Resident\".

Create Account via Firebase Auth.

Access \"Connect Your SAKSI Device\" screen. App scans for the ESP32.

User clicks \"Lock Home Zone (GPS Verification)\" to save their current
coordinates to Firestore.

Redirected to Resident Dashboard.

B. User Flow 2: Resident Monitoring & Alerting

User opens app to Resident Dashboard.

The UI listens to the Firebase Realtime Database. As the ESP32 detects
noise via the MAX4466, the on-screen gauge moves dynamically.

If neighbors are causing a severe disturbance, the user clicks the red
\"ALERT BARANGAY ASSISTANCE\" button.

A modal appears confirming \"Alert Sent to Barangay,\" and a flag is
written to Firestore notifying officials.

C. User Flow 3: Official Command Center & Mediation

Official logs in and is routed to the Command Center Map.

The map queries Firestore for active noise_logs. Heatmap dots appear
over problem zones.

Official clicks a heatmap dot -\> opens bottom sheet -\> clicks \"View
Details\".

Official is taken to Evidence Detail Screen showing the hard data (Peak
dB, Time, GPS).

Official clicks \"Generate AI Report\". The app sends the data payload
to the Gemini AI API, which returns a formal summary paragraph.

Official clicks \"Export PDF\" to save the mediated evidence.

Styling Guidelines STYLING GUIDELINES: SAKSI

OVERVIEW AND DESIGN SYSTEM SOURCING SAKSI is an administrative and
emergency mediation tool. The visual vibe is utilitarian, sleek,
trustworthy, and urgent. Development Workflow: The official Design
System is dictated entirely by the existing Figma-to-React export
located in the figma-make-local-runner folder. During the initial
development phase, the React code (including CSS/style properties) will
be directly translated into Flutter by Trae AI. Flutter\'s ThemeData
will be constructed to perfectly mirror the React export to ensure
design consistency before any functional backend enhancements are made.

COLOR PALETTE (Mapped from React Export)

Primary Alerts & Actions: Crimson/Blood Red (Exact Hex matched to React
export). Used strictly for active alerts, heatmaps, and primary
emergency buttons.

Backgrounds & Surfaces: Crisp White and Light Grey/Off-White (Mapped to
React export) to create depth for UI cards.

Text & Elements: Pitch Black for primary text, Dark Charcoal for
secondary text and borders.

System Warnings: Amber/Warning Orange for hardware offline states.

TYPOGRAPHY & SPACING

Font Family: Inter or Roboto (As defined in the Figma React project).

Text Styles: All heading sizes, body weights, and line heights must be
translated directly from the React CSS/style objects into Flutter
TextStyle definitions.

Spacing: Margins, padding, and border-radiuses will follow the exact
pixel/rem values provided in the React component blueprints.

IMAGERY & ICONOGRAPHY

Minimalist and functional. Use the exact SVG assets or icon libraries
specified in the Figma design.

Do not use abstract or decorative imagery. The focus is purely on the
data (speedometer gauge, maps, bar charts).

UI/UX PRINCIPLES

High Contrast: Ensure text is easily readable outdoors.

Frictionless Action: Emergency buttons must be full-width, solid
colored, and instantly accessible at the bottom of the screen.

Progressive Enhancement: The UI will initially match the React baseline
perfectly. Edge cases (Empty States, Error States, Offline Banners) will
be enhanced and styled natively in Flutter as development progresses.
