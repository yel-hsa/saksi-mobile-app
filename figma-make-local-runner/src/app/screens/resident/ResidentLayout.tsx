import { Outlet, NavLink, useLocation } from "react-router-dom";
import { Home, History as HistoryIcon, Settings } from "lucide-react";
import { clsx } from "clsx";
import { motion, AnimatePresence } from "framer-motion";

export function ResidentLayout() {
  const location = useLocation();

  const navItems = [
    { path: "/resident", icon: Home, label: "Home" },
    { path: "/resident/history", icon: HistoryIcon, label: "History" },
    { path: "/resident/settings", icon: Settings, label: "Settings" },
  ];

  return (
    <div className="flex flex-col min-h-screen bg-[#F5F5F5] font-sans text-black overflow-hidden relative pb-20">
      <main className="flex-1 overflow-y-auto">
        <AnimatePresence mode="wait">
          <motion.div
            key={location.pathname}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.2 }}
          >
            <div className="flex flex-col flex-1 h-full min-h-[calc(100vh-80px)] w-full">
              <Outlet />
            </div>
          </motion.div>
        </AnimatePresence>
      </main>

      <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 pb-safe shadow-[0_-4px_20px_rgba(0,0,0,0.05)] z-50">
        <div className="flex justify-around items-center h-20 px-6 max-w-md mx-auto">
          {navItems.map((item) => {
            const Icon = item.icon;
            const isActive = location.pathname === item.path;

            return (
              <NavLink
                key={item.path}
                to={item.path}
                className={clsx(
                  "flex flex-col items-center gap-1 p-2 rounded-xl transition-all",
                  isActive ? "text-[#D32F2F]" : "text-[#333333] hover:text-black"
                )}
              >
                <div className="relative">
                  <Icon className="w-6 h-6" strokeWidth={isActive ? 2.5 : 2} />
                  {isActive && (
                    <motion.div
                      layoutId="nav-pill"
                      className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-1 h-1 bg-[#D32F2F] rounded-full"
                    />
                  )}
                </div>
                <span className="text-xs font-semibold">{item.label}</span>
              </NavLink>
            );
          })}
        </div>
      </nav>
    </div>
  );
}
