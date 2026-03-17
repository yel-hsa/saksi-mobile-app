import { createBrowserRouter } from "react-router-dom";

import { Splash } from "./screens/auth/Splash";
import { Login } from "./screens/auth/Login";
import { DeviceSetup } from "./screens/auth/DeviceSetup";

import { ResidentLayout } from "./screens/resident/ResidentLayout";
import { Dashboard } from "./screens/resident/Dashboard";
import { History } from "./screens/resident/History";
import { Settings } from "./screens/resident/Settings";

import { OfficialLayout } from "./screens/official/OfficialLayout";
import { CommandCenter } from "./screens/official/CommandCenter";
import { Analytics } from "./screens/official/Analytics";
import { Reports } from "./screens/official/Reports";
import { CaseDetails } from "./screens/official/CaseDetails";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: Splash,
  },
  {
    path: "/login",
    Component: Login,
  },
  {
    path: "/setup",
    Component: DeviceSetup,
  },
  {
    path: "/resident",
    Component: ResidentLayout,
    children: [
      { index: true, Component: Dashboard },
      { path: "history", Component: History },
      { path: "settings", Component: Settings },
    ],
  },
  {
    path: "/official",
    Component: OfficialLayout,
    children: [
      { index: true, Component: CommandCenter },
      { path: "analytics", Component: Analytics },
      { path: "reports", Component: Reports },
      { path: "case/:id", Component: CaseDetails },
    ],
  },
]);
