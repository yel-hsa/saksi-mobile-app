# CURRENT STATE (Frontend Handoff)

Repository: `saksi-figma`  
App: `saksi_app/` (Flutter, UI-only milestone)  
Scope: UI/UX + local state + mock data. No Firebase logic should be added yet.

## 1) Completed UI Features

### Global Theming / Design Tokens
- Theme and typography centralized in:
  - `saksi_app/lib/main.dart` (ThemeData, Inter via GoogleFonts, dialog/snackbar/button theming, page transitions)
  - `saksi_app/lib/core/constants/app_colors.dart` (Crimson/White/Black palette + semantic roles like success/warning/info)
  - `saksi_app/lib/core/constants/text_styles.dart` (Inter type scale used across screens)
  - `saksi_app/lib/core/constants/app_layout.dart` (gutter/radii/shadow tokens for consistent “premium” spacing rhythm)

### Shared Components (Reusable + consistent styling)
- Buttons: `saksi_app/lib/ui/shared/custom_button.dart`
- Inputs: `saksi_app/lib/ui/shared/custom_input.dart`
- Cards (Material/Ink surface with ripple + consistent border/shadow): `saksi_app/lib/ui/shared/custom_card.dart`
- Status badge pills: `saksi_app/lib/ui/shared/status_badge.dart`
- Filter pills (shared chip component): `saksi_app/lib/ui/shared/filter_pill.dart`
- Legacy Mapbox-style placeholder (still used by Evidence screen): `saksi_app/lib/ui/shared/mapbox_placeholder.dart`

### Auth + Role Entry
- Splash / Role selection: `saksi_app/lib/ui/auth/splash_screen.dart`
  - Routes to `LoginScreen(role: 'resident')` or `LoginScreen(role: 'official')`
- Login (UI-only): `saksi_app/lib/ui/auth/login_screen.dart`
  - Resident → Setup Pairing
  - Official → Official Layout (tabs)

### Resident Experience (Responsive + functional navigation)
- Resident tab layout (Home / History / Settings): `saksi_app/lib/ui/resident/resident_layout.dart`
  - Uses IndexedStack for state persistence across tabs.
- Dashboard (live gauge simulation + mediation action modal): `saksi_app/lib/ui/resident/resident_dashboard.dart`
  - Simulated decibel updates every 2 seconds (Timer + Random jitter).
  - “REQUEST BARANGAY MEDIATION” opens confirmation dialog → success dialog (UI-only).
  - AppBar icons route to History/Settings via callbacks from ResidentLayout.
- History (scroll-safe + animated list): `saksi_app/lib/ui/resident/history_screen.dart`
  - Uses `flutter_animate` staggered fade/slide for list items.
  - Incident card → Incident detail screen.
- Incident detail: `saksi_app/lib/ui/resident/incident_detail_screen.dart` (scroll-safe)
- Setup pairing (scroll-safe): `saksi_app/lib/ui/resident/setup_pairing_screen.dart`
  - Simulated scanning + “Lock Home Zone (GPS)” toggle; when enabled, “Complete Setup” routes into ResidentLayout.
- Location / Home Zone: `saksi_app/lib/ui/resident/location_zone_screen.dart`
  - Uses `flutter_map` + OSM tiles as a premium map placeholder with a marker.
- Settings / Profile: `saksi_app/lib/ui/resident/settings_screen.dart`
  - Routes:
    - Sensor Network → Setup Pairing
    - Privacy Overview → Privacy screen
    - Barangay Ordinances → Ordinances screen
    - Home Zone → Location Zone screen
    - Sign Out Device → returns to Splash (clears stack)
- Privacy screen: `saksi_app/lib/ui/resident/privacy_overview_screen.dart`
- Ordinances screen: `saksi_app/lib/ui/resident/ordinances_screen.dart`

### Official Experience (Responsive + functional navigation)
- Official tab layout (Map / Analytics / Reports): `saksi_app/lib/ui/official/official_layout.dart`
  - Uses IndexedStack for state persistence across tabs.
- Command Center (Map tab): `saksi_app/lib/ui/official/command_center_map.dart`
  - `flutter_map` with OSM tiles + 3 static “heat” markers.
  - Heat marker tap selects a zone (local state) and opens a bottom sheet-like detail panel.
  - “View Details” routes to Evidence detail (passes mock case file).
  - Filter icon opens a modal bottom sheet (placeholder).
  - Dispatch Tanod button opens a confirmation dialog (placeholder).
- Analytics: `saksi_app/lib/ui/official/analytics_screen.dart`
  - Uses `flutter_animate` for offender list entry animations.
  - Tapping offender card routes to Evidence detail (placeholder).
- Reports: `saksi_app/lib/ui/official/reports_list_screen.dart`
  - Uses `flutter_animate` for case list animations.
  - Search icon opens a modal bottom sheet (placeholder).
  - FAB routes to Create Report.
  - Report card → Evidence detail (passes mock case file).
  - Export action triggers a premium dialog (placeholder).
- Create report: `saksi_app/lib/ui/official/create_report_screen.dart`
  - Scroll-safe with keyboard-aware padding.
  - “Create Case” shows SnackBar + returns.
- Evidence detail: `saksi_app/lib/ui/official/evidence_detail_screen.dart`
  - Consumes a `MockCaseFile` to render data-driven “Mediation Report”.
  - Export/Resolved actions show dialogs (placeholders).

## 2) Mock Data

### Location
- Centralized mock data: `saksi_app/lib/core/mock_data.dart`

### What’s inside
- `MockData.violationThresholdDb` = 85
- `MockData.resident` (name/address/hardwareId + home zone lat/lng)
- `MockData.incidents` (personal history logs with realistic peaks like 88dB/104dB)
- `MockData.caseFiles` (official case list with IDs like 1042-A)
- `MockData.hotspots` (zone labels + peak dB used by Official map + Analytics chart)

### Where it is wired
- Resident:
  - `settings_screen.dart` reads `MockData.resident`
  - `history_screen.dart` maps `MockData.incidents` into the timeline UI (also derives `isViolation`)
  - `location_zone_screen.dart` uses `MockData.resident.homeZoneLat/Lng` as map center
- Official:
  - `reports_list_screen.dart` reads `MockData.caseFiles`
  - `command_center_map.dart` uses `MockData.resident.homeZone*` for map center and `MockData.hotspots` to place heat markers
  - `analytics_screen.dart` uses `MockData.hotspots` for chart bars
  - `evidence_detail_screen.dart` accepts a `MockCaseFile?` and defaults to `MockData.caseFiles.first`

## 3) Pending UI/UX Tasks (Next Developer)

### Priority A (Consistency + finishing polish)
- Replace remaining ad-hoc Containers in screens with shared `CustomCard` for consistent radii/shadow/border:
  - Most visible remaining: `resident/settings_screen.dart`, `official/command_center_map.dart` (stats chips + zone sheet), `official/evidence_detail_screen.dart` (verification seal + peak box).
- Standardize “status” colors across screens:
  - Some places still use hardcoded greens/blues or raw hex values.
  - Goal: use `AppColors.success* / warning* / info* / danger*` consistently.
- Replace remaining MapboxPlaceholder usage:
  - Evidence detail still uses `ui/shared/mapbox_placeholder.dart`.
  - Option: migrate Evidence detail map to `flutter_map` for parity with Command Center + Home Zone.

### Priority B (Animations)
- Add consistent page-level transitions for modal routes (currently uses Theme pageTransitions + selective `flutter_animate`).
- Expand “micro-interactions”:
  - Press states on cards/chips/buttons are mostly good; remaining ad-hoc gesture Containers should become Material Ink surfaces.

### Priority C (Feature completeness per SAKSI docs)
- AI chat assistant (resident) is not implemented yet.
- Real export/report generation is not implemented (dialogs are placeholders).
- No empty/error/offline banners beyond simple local simulation; add UX for:
  - “no incidents”
  - “no active violations”
  - “offline mode” (resident + official)

## 4) Known Issues / Technical Notes

### Analyzer output (non-blocking but noisy)
- `flutter analyze` returns non-zero because the project currently reports many deprecation infos:
  - `.withOpacity(...)` is deprecated in newer Flutter SDKs (should migrate to `.withValues(...)`).
  - `Switch.activeColor` is deprecated (use `activeThumbColor`).
- These are tracked across multiple files (UI + shared). No compile-blocking errors are present.

### Platform tooling
- `flutter run -d windows` fails without a suitable Visual Studio toolchain (requires VS build tools).
- Web / Android / iOS are the recommended dev targets.

### Map tiles dependency
- `flutter_map` uses OpenStreetMap tiles (`https://tile.openstreetmap.org/...`) which requires network access.
- If offline support is needed later, a tile cache/offline strategy will be required.

### Remaining “placeholder” interactions
- `ui/shared/mapbox_placeholder.dart` control buttons (zoom/navigation) are intentionally no-op.
- Some filter pills in list headers are UI-only and don’t change datasets yet.

## Quick Runbook
- From `saksi_app/`:
  - `flutter test`
  - `flutter analyze` (expect deprecation infos until migrated)
  - `flutter run -d chrome` (or `-d web-server` for preview)

