# SAKSI: UI/UX Design AI Prompt Documentation

## Project Overview
**App Name:** SAKSI (Community Mediation & Accountability System)
**System Type:** Dual-platform IoT-based mobile application.
**Core Purpose:** To serve as a digital witness that continuously monitors, records, and reports noise level violations.
**Target Users:** Residents and Barangay Officials.
**Design Frame:** Modern smartphone (e.g., iPhone 15 Pro).

---

## Global Design System & Styling
* **Color Palette:** High-contrast, alert-oriented, and professional. 
  * **Primary Action & Alerts:** Crimson/Blood Red (#D32F2F).
  * **Backgrounds & Surfaces:** Crisp White (#FFFFFF) and Off-White/Light Grey (#F5F5F5).
  * **Text, Icons, & Borders:** Pitch Black (#000000) and Dark Charcoal (#333333).
  * **System Warnings:** Amber/Warning Orange (for offline states).
* **Typography:** Modern, legible sans-serif font (e.g., Inter, Roboto). Heavy/Bold for decibel numbers, Regular for secondary text.
* **UI/UX Vibe:** Utilitarian, sleek, trustworthy, and urgent. Minimalist components with subtle drop shadows.

---

## Part 1: Onboarding, Auth & Setup

### Screen 0: Splash Screen & Role Selection
* **Background:** Clean, solid Crisp White.
* **Branding:** SAKSI in heavy Pitch Black. Tagline: "Community Mediation & Accountability System". 
* **Bottom Action Area:** Vertically stacked buttons: "Continue as Resident" (Solid Black) and "Barangay Official Portal" (Red Outline).

### Screen 0.1: Secure Login / Registration
* **Header:** "Welcome Back" / "Please log in to your SAKSI account."
* **Inputs:** "Email Address" and "Password".
* **Action Button:** Solid Red button: "Sign In".

### Screen 0.2: IoT Device Pairing (Resident Setup)
* **Header:** "Connect Your SAKSI Device"
* **Main Visual:** Outline illustration of the SAKSI hardware emitting wireless waves.
* **Status Box:** "Scanning for nearby SAKSI ESP32 monitors..." with a spinning loading indicator.
* **Action:** "Lock Home Zone (GPS Verification)" toggle switch.

---

## Part 2: Resident Interface

### Screen 1: Resident Dashboard (Real-Time Monitoring)
* **Header:** Top app bar with SAKSI logo, Notification Bell icon, and User Profile icon.
* **Main UI Component:** Large real-time noise level gauge (Speedometer style). Track is dark grey, active fill is Red. Bold number in center (e.g., "72 dB").
* **Status Indicator:** Pill-shaped badge below gauge (e.g., Red: "WARNING: Nearing Limit").
* **Bottom Action Area:** Full-width, solid Red emergency button: "ALERT BARANGAY ASSISTANCE" with a shield icon.
* **Bottom Navigation:** Icons for "Home" (Red), "History", and "Settings".

### Screen 1.1: Emergency Action Status (Modal)
* **Background:** Semi-transparent dark overlay.
* **Center Card:** Crisp white modal. Bold header: "Alert Sent to Barangay". Subtext: "Tanod dispatch notified."
* **Action:** Black outline button: "Dismiss".

### Screen 2: Personal Violation History Tracking
* **Header:** "My Incident History" with back arrow.
* **Overview:** Top summary card showing "Total Violations This Month: 2".
* **List View:** Scrollable list of recent noise incidents as white cards (Date/Time, Peak Noise in Red, Duration, Status Tag).
* **Bottom Navigation:** "History" is highlighted Red.

### Screen 2.1: Settings & Profile Management
* **Header:** "Account Settings"
* **User Info:** Profile avatar, Name, "Household ID / Address".
* **Settings List:** "Update Registered GPS Zone", "Notification Preferences" (toggle), "Manage Wi-Fi Connection".
* **Action:** "Log Out" (Black text).

---

## Part 3: Barangay Official Interface

### Screen 3: Official Command Center & Interactive Map
* **Header:** "Barangay Command Center".
* **Top Section:** Stats row: "Active Alerts: 3" (red), "Monitored Zones: 12" (black).
* **Main UI Component:** Interactive map. 2-3 glowing red "Heatmap" dots.
* **Bottom Sheet:** Sliding card: "Zone 4 - 88 dB Detected" with a "Dispatch Tanod" button.
* **Bottom Navigation:** "Map" (Red), "Analytics", "Reports".

### Screen 4: Analytics & Repeat Offenders
* **Header:** "Analytics & Insights".
* **Top Card:** Horizontal bar chart of top 3 noisiest areas.
* **Middle Section:** List showing 2-3 user profiles with a red warning badge: "3 Violations this week".
* **Bottom Navigation:** "Analytics" is highlighted Red.

### Screen 5: Exportable Reports & Mediation
* **Header:** "Mediation Reports"
* **Main UI:** List of generated case files (Case #, Date, Parties Involved). Buttons: "View Evidence" (Black), "Export PDF" (Red).
* **Floating Action Button (FAB):** Large Red "+" icon.
* **Bottom Navigation:** "Reports" is highlighted Red.

### Screen 5.1: Detailed Evidence View
* **Header:** "Case #1042 Details" with back arrow.
* **Top Map:** Small static map snippet of violation GPS pin.
* **Data Readout:** Exact Time & Date, Peak Decibel Level (Red), Duration, Hardware ID.
* **Action Buttons:** "Mark as Resolved" (Black), "Export PDF Record" (Red outline).

---

## Part 4: System States & Notifications (Edge Cases)

### Screen 6: Empty States (Zero Data)
* **Trigger:** When a resident checks History but has no violations, or an Official checks Reports and all cases are resolved.
* **Visual:** A light, friendly, minimal illustration (e.g., a quiet neighborhood graphic or a checkmark shield).
* **Text:** "All Quiet Here!" or "No active violations at this time."
* **Vibe:** Positive, reinforcing good behavior. No red colors, use soft grey and white.

### Screen 7: Error State (Device Offline Warning)
* **Trigger:** The ESP32 hardware loses power or Wi-Fi connection.
* **Resident Dashboard Override:** The noise gauge is greyed out.
* **Status Badge:** A prominent Amber/Warning Orange banner at the top: "SAKSI Device Offline".
* **Subtext:** "Please check the power supply or Wi-Fi connection of your home monitor. GPS tracking paused."
* **Action Button:** "Troubleshoot Connection" (Black outline).

### Screen 8: Push Notification Panel
* **Header:** "Notifications"
* **List View:** Unread items highlighted with a very faint red background.
  * *Example 1 (Resident):* "Warning: Your household has sustained 80dB for 3 minutes."
  * *Example 2 (Official):* "Urgent: New Noise Complaint logged at Zone 2."