import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { ArrowLeft, Clock, Calendar, CheckCircle2, ShieldCheck, Filter, AlertOctagon, ChevronRight } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";

export function History() {
  const navigate = useNavigate();
  const [activeFilter, setActiveFilter] = useState("Month");
  
  const filters = ["Today", "Week", "Month"];

  // Simulate data
  const incidents = [
    {
      id: 1,
      date: "Oct 12, 2023",
      time: "11:45 PM",
      peakDb: 88,
      duration: "15 mins",
      status: "Resolved",
      isViolation: false,
    },
    {
      id: 2,
      date: "Oct 05, 2023",
      time: "02:10 AM",
      peakDb: 104,
      duration: "45 mins",
      status: "Pending Review",
      isViolation: true,
    },
    {
      id: 3,
      date: "Sep 28, 2023",
      time: "09:30 PM",
      peakDb: 92,
      duration: "30 mins",
      status: "Resolved",
      isViolation: true,
    },
  ];

  return (
    <div className="flex flex-col min-h-full w-full pb-24 bg-[#F5F5F5] font-sans">
      <header className="flex items-center justify-between px-6 py-4 bg-white shadow-sm z-10 sticky top-0">
        <div className="flex items-center gap-4">
          <button
            onClick={() => navigate(-1)}
            className="p-2 -ml-2 rounded-full hover:bg-gray-100 transition-colors"
            aria-label="Go back"
          >
            <ArrowLeft className="w-6 h-6 text-[#333333]" />
          </button>
          <h1 className="font-black text-xl tracking-tight text-[#333333]">Audit Log</h1>
        </div>
      </header>

      {/* Summary Banner */}
      <div className="px-6 pt-6 pb-2">
        <div className="bg-[#333333] text-white rounded-2xl p-6 shadow-[0_8px_30px_rgba(0,0,0,0.12)] relative overflow-hidden">
          <div className="relative z-10 flex items-center justify-between">
            <div>
              <h2 className="text-[13px] font-bold text-gray-400 uppercase tracking-widest mb-1">
                Total Violations
              </h2>
              <div className="flex items-baseline gap-2">
                <span className="text-4xl font-black tabular-nums">3</span>
                <span className="text-sm font-semibold text-gray-400">Recorded</span>
              </div>
            </div>
            <div className="w-14 h-14 bg-white/10 rounded-full flex items-center justify-center backdrop-blur-sm border border-white/20">
              <ShieldCheck className="w-7 h-7 text-white" />
            </div>
          </div>
          {/* Decorative gradients */}
          <div className="absolute -top-12 -right-12 w-32 h-32 bg-[#D32F2F]/20 rounded-full blur-3xl pointer-events-none" />
          <div className="absolute -bottom-10 -left-10 w-24 h-24 bg-blue-500/20 rounded-full blur-3xl pointer-events-none" />
        </div>
      </div>

      {/* Filter Chips */}
      <div className="px-6 py-4 flex items-center gap-2 overflow-x-auto no-scrollbar">
        <div className="px-3 py-2 bg-gray-200/50 rounded-xl mr-2 flex-shrink-0">
          <Filter className="w-4 h-4 text-gray-500" />
        </div>
        {filters.map((filter) => (
          <button
            key={filter}
            onClick={() => setActiveFilter(filter)}
            className={`px-5 py-2 rounded-xl text-sm font-bold whitespace-nowrap transition-all ${
              activeFilter === filter
                ? "bg-[#D32F2F] text-white shadow-md"
                : "bg-white text-gray-500 border border-gray-200 hover:bg-gray-50"
            }`}
          >
            {filter}
          </button>
        ))}
      </div>

      {/* Timeline View */}
      {incidents.length > 0 ? (
        <div className="px-6 py-2 relative flex flex-col gap-6">
          {/* Timeline Vertical Line */}
          <div className="absolute left-[39px] top-6 bottom-4 w-[2px] bg-gray-200 z-0" />

          {incidents.map((incident, index) => (
            <motion.div
              key={incident.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className="relative z-10 flex gap-4 w-full group cursor-pointer"
            >
              {/* Timeline Node */}
              <div className="flex flex-col items-center pt-5 flex-shrink-0">
                <div className={`w-4 h-4 rounded-full border-4 border-[#F5F5F5] shadow-sm z-10 ${
                  incident.isViolation ? "bg-[#D32F2F]" : "bg-green-500"
                }`} />
              </div>

              {/* Event Card */}
              <div className="flex-1 bg-white rounded-2xl p-5 shadow-sm border border-gray-100 group-hover:shadow-md group-hover:border-gray-200 transition-all">
                <div className="flex justify-between items-start mb-4">
                  <div className="flex flex-col gap-1">
                    <span className="text-[11px] font-bold text-gray-400 uppercase tracking-wider flex items-center gap-1.5">
                      <Calendar className="w-3.5 h-3.5" />
                      {incident.date}
                    </span>
                    <span className="text-[#333333] font-bold text-base flex items-center gap-1.5">
                      <Clock className="w-4 h-4 text-gray-400" />
                      {incident.time}
                      <span className="text-gray-400 font-medium text-xs ml-1 bg-gray-100 px-2 py-0.5 rounded-md">
                        {incident.duration}
                      </span>
                    </span>
                  </div>
                  <div className="flex flex-col items-end">
                    <div className="flex items-baseline gap-1">
                      <span className={`text-2xl font-black tabular-nums tracking-tight ${
                        incident.isViolation ? "text-[#D32F2F]" : "text-[#333333]"
                      }`}>
                        {incident.peakDb}
                      </span>
                      <span className="text-xs font-bold text-gray-400">dB</span>
                    </div>
                    <span className="text-[10px] font-bold uppercase tracking-wider text-gray-400">
                      Peak Noise
                    </span>
                  </div>
                </div>

                <div className="flex items-center justify-between pt-4 border-t border-gray-100">
                  <div className={`text-[11px] font-bold px-2.5 py-1 rounded-md flex items-center gap-1.5 ${
                    incident.isViolation 
                      ? incident.status === 'Resolved'
                        ? 'bg-amber-50 text-amber-700 border border-amber-200'
                        : 'bg-red-50 text-[#D32F2F] border border-red-200'
                      : 'bg-green-50 text-green-700 border border-green-200'
                  }`}>
                    {incident.isViolation ? <AlertOctagon className="w-3 h-3" /> : <CheckCircle2 className="w-3 h-3" />}
                    {incident.isViolation ? (incident.status === 'Resolved' ? 'Violation Logged' : 'Pending Action') : 'Compliant Log'}
                  </div>
                  
                  <div className="w-8 h-8 rounded-full bg-gray-50 flex items-center justify-center group-hover:bg-[#333333] group-hover:text-white transition-colors text-gray-400">
                    <ChevronRight className="w-4 h-4" />
                  </div>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      ) : (
        <div className="flex-1 flex flex-col items-center justify-center p-8 text-center mt-4">
          <div className="w-24 h-24 bg-white rounded-3xl flex items-center justify-center shadow-sm mb-6 border border-gray-100">
             <ShieldCheck className="w-12 h-12 text-gray-300" strokeWidth={1.5} />
          </div>
          <h2 className="text-xl font-black text-[#333333] mb-2">All Clear</h2>
          <p className="text-gray-500 font-medium text-sm leading-relaxed max-w-[240px]">
            No recorded noise incidents in this time frame. Keep up the good work!
          </p>
        </div>
      )}
    </div>
  );
}
