import { useState, useEffect } from "react";
import { Bell, User, Shield, AlertTriangle, CheckCircle, WifiOff, MapPin, Lock, Cloud, CloudOff, Info } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";

export function Dashboard() {
  const [decibels, setDecibels] = useState(45);
  const [isConfirmOpen, setIsConfirmOpen] = useState(false);
  const [isSuccessOpen, setIsSuccessOpen] = useState(false);
  const [isOffline, setIsOffline] = useState(false);

  // Simulate real-time noise changes
  useEffect(() => {
    if (isOffline) return;
    const interval = setInterval(() => {
      setDecibels((prev) => {
        const variance = Math.floor(Math.random() * 15) - 7;
        const newDb = Math.max(30, Math.min(120, prev + variance));
        return newDb;
      });
    }, 2000);
    return () => clearInterval(interval);
  }, [isOffline]);

  const limit = 85;
  const isWarning = decibels > limit;
  const isDanger = decibels > 100;

  // Gauge calculations
  const maxDb = 120;
  const percentage = isOffline ? 0 : Math.min(100, Math.max(0, (decibels / maxDb) * 100));
  const radius = 110;
  const strokeWidth = 20;
  const circumference = 2 * Math.PI * radius;
  // Arc is 75% of a full circle (starts at bottom left, ends at bottom right)
  const dashOffset = circumference - (percentage / 100) * (circumference * 0.75);

  const getStatusColor = () => {
    if (isOffline) return "#9ca3af";
    if (isDanger) return "#b91c1c"; // Dark red
    if (isWarning) return "#D32F2F"; // Primary Red
    return "#10B981"; // Emerald green
  };

  const getStatusText = () => {
    if (isOffline) return "Monitoring Paused";
    if (isDanger) return "Violation Level";
    if (isWarning) return "Elevated Noise";
    return "Normal Levels";
  };

  return (
    <div className="flex flex-col flex-1 h-full w-full relative bg-[#F5F5F5] pb-6">
      {/* Top App Bar */}
      <header className="flex justify-between items-center px-6 py-4 bg-white shadow-sm z-10 sticky top-0">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 bg-[#D32F2F] rounded-lg flex items-center justify-center">
            <Shield className="w-5 h-5 text-white" fill="currentColor" />
          </div>
          <h1 className="font-black text-xl tracking-tight text-[#333333]">SAKSI</h1>
        </div>
        <div className="flex gap-4">
          <button className="p-2 relative rounded-full hover:bg-gray-100 transition-colors" aria-label="Notifications">
            <Bell className="w-5 h-5 text-[#333333]" />
            <span className="absolute top-2 right-2 w-2 h-2 bg-[#D32F2F] rounded-full ring-2 ring-white" />
          </button>
          <button className="p-2 bg-gray-100 rounded-full hover:bg-gray-200 transition-colors" aria-label="User profile">
            <User className="w-5 h-5 text-[#333333]" />
          </button>
        </div>
      </header>

      {/* Trust & Status Bar */}
      <div className="px-6 py-3 flex gap-2 overflow-x-auto no-scrollbar">
        <div className="flex items-center gap-1.5 px-3 py-1.5 bg-green-50 text-green-700 rounded-full border border-green-200 shadow-sm whitespace-nowrap">
          <MapPin className="w-3.5 h-3.5" />
          <span className="text-[11px] font-bold uppercase tracking-wider">Verified Home Zone</span>
          <CheckCircle className="w-3.5 h-3.5 ml-0.5" />
        </div>
        <div className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full border shadow-sm whitespace-nowrap ${
          isOffline ? "bg-amber-50 text-amber-700 border-amber-200" : "bg-blue-50 text-blue-700 border-blue-200"
        }`}>
          {isOffline ? <CloudOff className="w-3.5 h-3.5" /> : <Cloud className="w-3.5 h-3.5" />}
          <span className="text-[11px] font-bold uppercase tracking-wider">
            {isOffline ? "Sync Offline" : "Cloud Sync Active"}
          </span>
        </div>
      </div>

      {/* Main Content - Centered */}
      <div className="flex-1 flex flex-col items-center justify-center px-6 py-4">
        {/* Layered Dashboard Card */}
        <div className="bg-white rounded-3xl p-8 shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 w-full max-w-sm flex flex-col items-center relative overflow-hidden">
          
          <h2 className="text-xs font-bold text-gray-400 uppercase tracking-widest mb-6 text-center">
            Live Environment Monitor
          </h2>

          <div className="relative w-64 h-64 flex items-center justify-center mb-2">
            <svg
              className="w-full h-full transform -rotate-[135deg]"
              viewBox="0 0 300 300"
            >
              {/* Background Track */}
              <circle
                cx="150"
                cy="150"
                r={radius}
                stroke="#f3f4f6"
                strokeWidth={strokeWidth}
                fill="none"
                strokeDasharray={circumference}
                strokeDashoffset={circumference * 0.25}
                strokeLinecap="round"
              />
              {/* Animated Fill */}
              <motion.circle
                cx="150"
                cy="150"
                r={radius}
                stroke={getStatusColor()}
                strokeWidth={strokeWidth}
                fill="none"
                strokeDasharray={circumference}
                initial={{ strokeDashoffset: circumference }}
                animate={{ strokeDashoffset: dashOffset }}
                transition={{ type: "spring", stiffness: 60, damping: 15 }}
                strokeLinecap="round"
              />
            </svg>

            <div className="absolute inset-0 flex flex-col items-center justify-center mt-6">
              <div className="flex items-baseline gap-1">
                <span className={`text-6xl font-black tabular-nums tracking-tighter ${isOffline ? 'text-gray-300' : 'text-[#333333]'}`}>
                  {isOffline ? "--" : Math.round(decibels)}
                </span>
                <span className="text-xl font-bold text-gray-400">dB</span>
              </div>
            </div>
          </div>

          {/* Status Indicator */}
          <motion.div
            layout
            className={`px-4 py-2 rounded-xl flex items-center gap-2 font-bold text-sm transition-colors ${
              isOffline 
                ? "bg-gray-100 text-gray-500"
                : isDanger
                ? "bg-red-100 text-red-800"
                : isWarning
                  ? "bg-red-50 text-[#D32F2F]"
                  : "bg-green-50 text-green-700"
            }`}
          >
            {isOffline ? <WifiOff className="w-4 h-4" /> : isWarning ? <AlertTriangle className="w-4 h-4" /> : <CheckCircle className="w-4 h-4" />}
            {getStatusText()}
          </motion.div>
          
        </div>
      </div>

      {/* Action Area */}
      <div className="px-6 mt-auto flex flex-col gap-4">
        <button
          onClick={() => setIsConfirmOpen(true)}
          className="w-full bg-[#D32F2F] text-white font-bold py-4 rounded-2xl flex items-center justify-center gap-3 shadow-[0_8px_20px_rgba(211,47,47,0.25)] active:scale-[0.98] transition-all group"
        >
          <Shield className="w-6 h-6 group-hover:scale-110 transition-transform" fill="currentColor" />
          <span className="text-[15px] tracking-wide">REQUEST BARANGAY MEDIATION</span>
        </button>
        
        <div className="flex items-start justify-center gap-2 text-center text-gray-400 px-4">
          <Lock className="w-4 h-4 flex-shrink-0 mt-0.5" />
          <p className="text-[11px] font-medium leading-relaxed">
            Privacy secured. Only your data is visible to you and authorized barangay officials.
          </p>
        </div>
      </div>

      {/* Confirmation Modal */}
      <AnimatePresence>
        {isConfirmOpen && (
          <div className="fixed inset-0 z-50 flex items-end justify-center sm:items-center p-4 pb-24 sm:pb-4">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="absolute inset-0 bg-black/40 backdrop-blur-sm"
              onClick={() => setIsConfirmOpen(false)}
            />
            <motion.div
              initial={{ scale: 0.95, opacity: 0, y: 40 }}
              animate={{ scale: 1, opacity: 1, y: 0 }}
              exit={{ scale: 0.95, opacity: 0, y: 40 }}
              className="bg-white rounded-3xl p-6 relative z-10 w-full max-w-sm shadow-2xl flex flex-col border border-gray-100"
            >
              <div className="w-12 h-12 bg-red-50 rounded-full flex items-center justify-center mb-4">
                <AlertTriangle className="w-6 h-6 text-[#D32F2F]" />
              </div>
              <h2 className="text-xl font-black text-[#333333] mb-2">Request Mediation?</h2>
              <p className="text-gray-500 text-sm font-medium mb-6 leading-relaxed">
                This will officially notify your barangay to dispatch an officer for peaceful mediation. This action is logged for accountability.
              </p>
              
              <div className="flex gap-3 w-full">
                <button
                  onClick={() => setIsConfirmOpen(false)}
                  className="flex-1 bg-gray-100 text-[#333333] font-bold py-3.5 rounded-xl hover:bg-gray-200 transition-colors"
                >
                  Cancel
                </button>
                <button
                  onClick={() => {
                    setIsConfirmOpen(false);
                    setTimeout(() => setIsSuccessOpen(true), 300);
                  }}
                  className="flex-1 bg-[#D32F2F] text-white font-bold py-3.5 rounded-xl shadow-md active:scale-95 transition-all"
                >
                  Yes, Request
                </button>
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>

      {/* Success Modal */}
      <AnimatePresence>
        {isSuccessOpen && (
          <div className="fixed inset-0 z-50 flex items-center justify-center p-6">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="absolute inset-0 bg-black/60 backdrop-blur-md"
              onClick={() => setIsSuccessOpen(false)}
            />
            <motion.div
              initial={{ scale: 0.9, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.9, opacity: 0 }}
              className="bg-white rounded-3xl p-8 relative z-10 w-full max-w-sm shadow-2xl flex flex-col items-center text-center"
            >
              <motion.div 
                initial={{ scale: 0 }}
                animate={{ scale: 1 }}
                transition={{ type: "spring", delay: 0.1 }}
                className="w-20 h-20 bg-green-50 rounded-full flex items-center justify-center mb-6"
              >
                <CheckCircle className="w-10 h-10 text-green-600" />
              </motion.div>
              <h2 className="text-2xl font-black mb-2 text-[#333333]">Alert Confirmed</h2>
              <p className="text-gray-500 mb-8 font-medium text-sm leading-relaxed">
                Barangay officials have been securely notified. Help is on the way. Please remain in a safe location.
              </p>
              <button
                onClick={() => setIsSuccessOpen(false)}
                className="w-full bg-gray-100 text-[#333333] font-bold py-4 rounded-xl active:scale-95 transition-transform"
              >
                Dismiss
              </button>
            </motion.div>
          </div>
        )}
      </AnimatePresence>
      
      {/* Dev Toggle for testing offline state */}
      <button 
        onClick={() => setIsOffline(!isOffline)}
        className="fixed top-20 right-4 bg-gray-800 text-white text-[10px] px-2 py-1 rounded-md opacity-30 hover:opacity-100 z-50 transition-opacity font-mono"
      >
        Toggle Dev State
      </button>
    </div>
  );
}
