import { useState } from "react";
import { Shield, MapPin, Navigation, BellRing, Settings, Filter, Search, ChevronRight } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import "./mapGrid.css";

export function CommandCenter() {
  const [selectedZone, setSelectedZone] = useState<number | null>(4);
  const [isListExpanded, setIsListExpanded] = useState(false);

  return (
    <div className="flex flex-col flex-1 h-full w-full relative bg-[#F5F5F5] overflow-hidden">
      {/* Premium Header */}
      <header className="px-6 pt-5 pb-4 bg-white shadow-[0_2px_10px_rgba(0,0,0,0.02)] z-30 relative flex justify-between items-center">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-[#333333] rounded-xl flex items-center justify-center shadow-md border border-gray-800">
            <Shield className="w-5 h-5 text-white" fill="currentColor" />
          </div>
          <div>
            <h1 className="font-black text-xl tracking-tight text-[#333333] leading-none mb-1">
              Command Center
            </h1>
            <span className="text-[10px] font-bold uppercase tracking-widest text-green-600 flex items-center gap-1">
              <span className="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse" />
              Live Feed Active
            </span>
          </div>
        </div>
        <button className="p-2.5 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors border border-gray-100 shadow-sm" aria-label="Filter zones">
           <Filter className="w-5 h-5 text-[#333333]" />
        </button>
      </header>

      {/* Floating Stats Row */}
      <div className="absolute top-24 left-0 right-0 px-4 z-20 flex gap-2 pointer-events-none">
        <div className="flex-1 bg-white/90 backdrop-blur-md border border-white/40 rounded-2xl p-4 flex flex-col justify-center shadow-[0_8px_30px_rgba(0,0,0,0.08)] pointer-events-auto">
          <div className="flex items-center justify-between mb-1">
            <span className="text-[10px] font-bold uppercase tracking-wider text-gray-500">Active Violations</span>
            <div className="w-2 h-2 bg-[#D32F2F] rounded-full animate-pulse" />
          </div>
          <span className="text-3xl font-black text-[#D32F2F] leading-none">3</span>
        </div>
        <div className="flex-1 bg-white/90 backdrop-blur-md border border-white/40 rounded-2xl p-4 flex flex-col justify-center shadow-[0_8px_30px_rgba(0,0,0,0.08)] pointer-events-auto">
          <div className="flex items-center justify-between mb-1">
            <span className="text-[10px] font-bold uppercase tracking-wider text-gray-500">High-Risk Zones</span>
            <MapPin className="w-3 h-3 text-amber-500" />
          </div>
          <span className="text-3xl font-black text-[#333333] leading-none">2</span>
        </div>
      </div>

      {/* Map Area */}
      <div className="flex-1 relative bg-[#E8ECEF] z-10 overflow-hidden">
        {/* Modern Map Grid */}
        <div className="map-grid-background absolute inset-0" />
        
        {/* Map Elements (Roads etc) */}
        <svg className="absolute inset-0 w-full h-full opacity-30 pointer-events-none">
          <path d="M50,0 L80,800 M200,0 L180,800 M350,0 L380,800" stroke="#9ca3af" strokeWidth="12" strokeLinecap="round" />
          <path d="M0,150 L500,180 M0,350 L500,320 M0,550 L500,600" stroke="#9ca3af" strokeWidth="16" strokeLinecap="round" />
        </svg>

        {/* Heatmap Nodes */}
        {/* Node 1 - Severe */}
        <button 
          onClick={() => setSelectedZone(4)}
          className="absolute top-[45%] left-[55%] -translate-x-1/2 -translate-y-1/2 focus:outline-none z-20 group"
          aria-label="Zone 4 - High Risk Area"
        >
          <motion.div
            animate={{ scale: [1, 2.5], opacity: [0.6, 0] }}
            transition={{ repeat: Infinity, duration: 2, ease: "easeOut" }}
            className="absolute inset-0 bg-[#D32F2F] rounded-full w-16 h-16 -ml-5 -mt-5"
          />
          <div className="absolute inset-0 bg-[#D32F2F]/20 rounded-full w-24 h-24 -ml-9 -mt-9 blur-md pointer-events-none" />
          <div className={`relative w-6 h-6 rounded-full border-[3px] border-white shadow-xl flex items-center justify-center transition-all duration-300 ${selectedZone === 4 ? 'bg-[#D32F2F] scale-125 ring-4 ring-red-500/30' : 'bg-[#D32F2F]'}`}>
            <div className="w-1.5 h-1.5 bg-white rounded-full" />
          </div>
        </button>

        {/* Node 2 - Elevated */}
        <button 
          onClick={() => setSelectedZone(2)}
          className="absolute top-[25%] left-[30%] -translate-x-1/2 -translate-y-1/2 focus:outline-none z-20 group"
          aria-label="Zone 2 - Elevated Risk Area"
        >
           <motion.div
            animate={{ scale: [1, 2], opacity: [0.5, 0] }}
            transition={{ repeat: Infinity, duration: 2.5, ease: "easeOut", delay: 0.5 }}
            className="absolute inset-0 bg-amber-500 rounded-full w-12 h-12 -ml-3 -mt-3"
          />
          <div className={`relative w-5 h-5 rounded-full border-2 border-white shadow-lg flex items-center justify-center transition-all ${selectedZone === 2 ? 'bg-amber-500 scale-125' : 'bg-amber-400'}`} />
        </button>

        {/* Node 3 - Normal */}
        <button 
          onClick={() => setSelectedZone(7)}
          className="absolute top-[70%] left-[20%] -translate-x-1/2 -translate-y-1/2 focus:outline-none z-10 group"
          aria-label="Zone 7 - Normal Activity Area"
        >
          <div className={`relative w-4 h-4 rounded-full border-2 border-white shadow-sm flex items-center justify-center transition-all ${selectedZone === 7 ? 'bg-green-500 scale-125' : 'bg-gray-400'}`} />
        </button>

        {/* Map Controls */}
        <div className="absolute right-4 top-1/2 -translate-y-1/2 flex flex-col gap-2 z-20">
          <div className="bg-white/90 backdrop-blur-sm rounded-2xl shadow-lg border border-gray-100 overflow-hidden flex flex-col">
            <button className="w-11 h-11 flex items-center justify-center hover:bg-gray-50 active:bg-gray-100 transition-colors text-[#333333] font-medium text-lg border-b border-gray-100" aria-label="Zoom in">
              +
            </button>
            <button className="w-11 h-11 flex items-center justify-center hover:bg-gray-50 active:bg-gray-100 transition-colors text-[#333333] font-medium text-lg" aria-label="Zoom out">
              −
            </button>
          </div>
          <button className="w-11 h-11 bg-white/90 backdrop-blur-sm rounded-2xl shadow-lg border border-gray-100 flex items-center justify-center mt-1 hover:bg-gray-50 active:scale-95 transition-all" aria-label="Reset map orientation">
            <Navigation className="w-5 h-5 text-[#333333]" fill="currentColor" />
          </button>
        </div>
      </div>

      {/* Expandable Case List Bottom Sheet */}
      <motion.div 
        className="absolute bottom-0 left-0 right-0 bg-white rounded-t-[32px] shadow-[0_-10px_40px_rgba(0,0,0,0.12)] z-40 border-t border-gray-100 flex flex-col"
        animate={{ height: selectedZone ? "auto" : isListExpanded ? "60vh" : "80px" }}
        transition={{ type: "spring", damping: 25, stiffness: 200 }}
      >
        {/* Grabber */}
        <button 
          className="w-full py-4 flex flex-col items-center justify-center focus:outline-none group cursor-pointer"
          onClick={() => {
            if (!selectedZone) setIsListExpanded(!isListExpanded);
            else setSelectedZone(null);
          }}
        >
          <div className="w-12 h-1.5 bg-gray-200 rounded-full group-hover:bg-gray-300 transition-colors" />
          {!selectedZone && (
             <span className="text-[10px] font-bold uppercase tracking-widest text-gray-400 mt-2">
               {isListExpanded ? "Swipe down to close" : "Swipe up for cases"}
             </span>
          )}
        </button>
        
        <AnimatePresence mode="wait">
          {selectedZone === 4 ? (
            <motion.div
              key="selected-zone"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: 20 }}
              className="px-6 pb-8"
            >
              <div className="flex justify-between items-start mb-6">
                <div>
                  <h3 className="text-2xl font-black text-[#333333] leading-none mb-1.5 flex items-center gap-2">
                    Zone 4
                    <span className="bg-[#D32F2F] text-white text-[10px] font-bold px-2 py-0.5 rounded-md uppercase tracking-wider">Critical</span>
                  </h3>
                  <p className="text-sm font-semibold text-gray-500 flex items-center gap-1.5">
                    <MapPin className="w-3.5 h-3.5" /> Mabini St. Block 2
                  </p>
                </div>
                <div className="text-right">
                   <div className="text-3xl font-black text-[#D32F2F] leading-none mb-1 tracking-tighter">88<span className="text-sm">dB</span></div>
                   <p className="text-[10px] font-bold uppercase tracking-widest text-gray-400">Peak Noise</p>
                </div>
              </div>

              <div className="bg-red-50 border border-red-100 rounded-2xl p-4 mb-6 flex items-start gap-3">
                <BellRing className="w-5 h-5 text-[#D32F2F] mt-0.5" />
                <div>
                  <h4 className="text-[13px] font-bold text-red-900 mb-0.5">Active Dispute Logged</h4>
                  <p className="text-xs text-red-700/80 leading-relaxed font-medium">Multiple resident reports received in the last 15 minutes. Protocol dictates intervention.</p>
                </div>
              </div>

              <div className="flex gap-3">
                <button className="flex-[2] bg-[#333333] text-white font-bold py-4 rounded-2xl shadow-[0_8px_20px_rgba(51,51,51,0.25)] active:scale-[0.98] transition-all flex items-center justify-center gap-2">
                  <Shield className="w-5 h-5" />
                  <span className="text-[15px]">Dispatch Tanod</span>
                </button>
                <button 
                  onClick={() => setSelectedZone(null)}
                  className="flex-[1] bg-gray-50 border border-gray-200 text-[#333333] font-bold py-4 rounded-2xl active:bg-gray-100 transition-colors"
                >
                  Dismiss
                </button>
              </div>
            </motion.div>
          ) : (
            <motion.div
               key="case-list"
               initial={{ opacity: 0 }}
               animate={{ opacity: isListExpanded ? 1 : 0 }}
               className={`px-6 pb-6 overflow-y-auto flex-1 ${!isListExpanded && 'pointer-events-none'}`}
            >
              <div className="flex items-center justify-between mb-4">
                 <h3 className="font-black text-lg text-[#333333]">Active Cases</h3>
                 <span className="text-xs font-bold text-[#D32F2F] bg-red-50 px-2.5 py-1 rounded-lg">3 Requires Action</span>
              </div>
              
              {/* List Items */}
              <div className="flex flex-col gap-3">
                 {[1, 2, 3].map((item) => (
                    <div key={item} className="p-4 rounded-2xl border border-gray-100 bg-white shadow-sm flex items-center justify-between group hover:border-gray-200 hover:shadow-md transition-all cursor-pointer">
                       <div className="flex items-center gap-4">
                          <div className={`w-10 h-10 rounded-xl flex items-center justify-center ${item === 1 ? 'bg-red-50 text-[#D32F2F]' : 'bg-amber-50 text-amber-600'}`}>
                             <BellRing className="w-5 h-5" />
                          </div>
                          <div>
                             <h4 className="font-bold text-[#333333] text-[15px] mb-0.5">Zone {item === 1 ? '4' : item === 2 ? '2' : '9'}</h4>
                             <p className="text-xs text-gray-500 font-medium">{item === 1 ? 'Mabini St. Block 2' : 'Rizal Ave.'}</p>
                          </div>
                       </div>
                       <ChevronRight className="w-5 h-5 text-gray-300 group-hover:text-[#333333] transition-colors" />
                    </div>
                 ))}
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </motion.div>
    </div>
  );
}
