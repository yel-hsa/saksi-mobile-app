import { clsx } from "clsx";
import { motion } from "framer-motion";

export interface TabItem {
  id: string;
  label: string;
}

export interface TabsProps {
  tabs: TabItem[];
  activeTab: string;
  onChange: (id: string) => void;
  fullWidth?: boolean;
}

export function Tabs({ tabs, activeTab, onChange, fullWidth = false }: TabsProps) {
  return (
    <div className={clsx("flex items-center gap-1.5 bg-gray-100 p-1.5 rounded-2xl", fullWidth && "w-full")}>
      {tabs.map((tab) => {
        const isActive = activeTab === tab.id;
        return (
          <button
            key={tab.id}
            onClick={() => onChange(tab.id)}
            className={clsx(
              "relative py-2.5 px-4 rounded-xl text-sm font-bold transition-colors outline-none",
              fullWidth && "flex-1",
              isActive ? "text-[#333333]" : "text-gray-500 hover:text-gray-700"
            )}
          >
            {isActive && (
              <motion.div
                layoutId="active-tab"
                className="absolute inset-0 bg-white rounded-xl shadow-sm border border-gray-200"
                transition={{ type: "spring", stiffness: 300, damping: 25 }}
              />
            )}
            <span className="relative z-10">{tab.label}</span>
          </button>
        );
      })}
    </div>
  );
}
