import { useNavigate, useParams } from "react-router-dom";
import { ArrowLeft, MapPin, Clock, Calendar, CheckCircle2, FileDown, Cpu, ShieldAlert, BadgeCheck } from "lucide-react";
import "./mapGrid.css";

export function CaseDetails() {
  const navigate = useNavigate();
  const { id } = useParams();

  const caseData = {
    id: id || "1042-A",
    date: "October 12, 2023",
    time: "11:45 PM - 12:00 AM",
    peakDb: 88,
    duration: "15 minutes",
    hardwareId: "SAKSI-ESP32-94A2",
    zone: "Zone 4, Mabini St. Block 2",
    status: "Pending Investigation",
  };

  return (
    <div className="flex flex-col min-h-screen pb-24 bg-[#F5F5F5] font-sans">
      <header className="flex items-center gap-4 px-6 pt-6 pb-4 bg-white shadow-sm z-10 sticky top-0 border-b border-gray-100">
        <button
          onClick={() => navigate(-1)}
          className="p-2 -ml-2 rounded-xl hover:bg-gray-100 transition-colors"
          aria-label="Go back"
        >
          <ArrowLeft className="w-6 h-6 text-[#333333]" />
        </button>
        <div>
           <h1 className="font-black text-xl tracking-tight text-[#333333] leading-none mb-1">Mediation Report</h1>
           <p className="text-[11px] font-bold text-gray-400 uppercase tracking-widest">Case #{caseData.id}</p>
        </div>
      </header>

      <div className="p-6">
        {/* Verification Seal */}
        <div className="bg-green-50 border border-green-200 rounded-2xl p-4 flex items-center justify-between mb-6 shadow-[0_4px_15px_rgba(0,0,0,0.02)]">
           <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center">
                 <BadgeCheck className="w-6 h-6 text-green-600" />
              </div>
              <div>
                 <h3 className="text-sm font-bold text-green-900">Evidence Verified</h3>
                 <p className="text-[11px] font-medium text-green-700/80">Hardware authenticated at source</p>
              </div>
           </div>
        </div>

        {/* Action Buttons (Moved up for accessibility) */}
        <div className="flex gap-3 mb-6">
          <button className="flex-1 bg-white border border-[#D32F2F]/20 text-[#D32F2F] hover:bg-red-50 text-[13px] font-bold py-3.5 rounded-xl flex items-center justify-center gap-2 active:scale-95 transition-all shadow-sm">
            <FileDown className="w-4 h-4" />
            Export PDF
          </button>
          <button className="flex-[1.5] bg-[#333333] text-white text-[13px] font-bold py-3.5 rounded-xl flex items-center justify-center gap-2 active:scale-[0.98] transition-all shadow-md">
            <CheckCircle2 className="w-4 h-4" />
            Mark as Resolved
          </button>
        </div>

        {/* Map Snippet */}
        <div className="map-container w-full h-48 bg-[#E8ECEF] rounded-[24px] overflow-hidden relative shadow-[0_8px_30px_rgba(0,0,0,0.04)] mb-6 border border-gray-200">
          <div className="map-grid-background-small absolute inset-0" />
          <svg className="absolute inset-0 w-full h-full opacity-30 pointer-events-none">
             <path d="M0,80 L400,100 M200,0 L180,200" stroke="#9ca3af" strokeWidth="8" strokeLinecap="round" />
          </svg>
          <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 flex flex-col items-center">
            <div className="relative">
              <div className="absolute inset-0 bg-[#D32F2F] rounded-full w-12 h-12 -ml-2 -mt-2 blur-md opacity-40 animate-pulse" />
              <div className="w-8 h-8 bg-[#D32F2F] rounded-full border-4 border-white shadow-xl flex items-center justify-center relative z-10">
                 <div className="w-2 h-2 bg-white rounded-full" />
              </div>
            </div>
          </div>
          <div className="absolute bottom-3 left-3 bg-white/95 backdrop-blur-sm px-3 py-1.5 rounded-xl shadow-md border border-gray-100 flex items-center gap-2">
            <MapPin className="w-3.5 h-3.5 text-[#D32F2F]" />
            <span className="text-[11px] font-bold text-[#333333] tracking-wide">{caseData.zone}</span>
          </div>
        </div>

        {/* Data Readout */}
        <div className="bg-white rounded-[24px] shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 overflow-hidden mb-8">
          <div className="p-5 border-b border-gray-100 flex items-center justify-between bg-gray-50/50">
            <div className="flex items-center gap-2 text-[#333333]">
              <ShieldAlert className="w-4 h-4" />
              <h2 className="font-bold text-[13px] uppercase tracking-wider">Incident Summary</h2>
            </div>
            <span className="text-[10px] font-bold bg-amber-50 px-2.5 py-1 rounded-md border border-amber-200 text-amber-700 uppercase tracking-wider">
              {caseData.status}
            </span>
          </div>

          <div className="p-6 flex flex-col gap-6">
            <div className="flex items-center justify-between bg-red-50/50 p-4 rounded-2xl border border-red-100">
              <div>
                <p className="text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-1">Peak Noise Level</p>
                <div className="flex items-baseline gap-1">
                  <span className="text-4xl font-black text-[#D32F2F] tabular-nums tracking-tighter">{caseData.peakDb}</span>
                  <span className="text-sm font-bold text-[#D32F2F]/70">dB</span>
                </div>
              </div>
              <div className="text-right">
                 <span className="text-[11px] font-bold bg-[#D32F2F] text-white px-2 py-1 rounded-md uppercase tracking-wider">Violation</span>
                 <p className="text-[10px] font-medium text-gray-500 mt-1.5">Limit: 85dB</p>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-y-6 gap-x-4">
              <div>
                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest mb-1.5 flex items-center gap-1.5">
                  <Calendar className="w-3 h-3" /> Date Logged
                </p>
                <p className="font-bold text-[#333333] text-[13px]">{caseData.date}</p>
              </div>
              <div>
                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest mb-1.5 flex items-center gap-1.5">
                  <Clock className="w-3 h-3" /> Time Block
                </p>
                <p className="font-bold text-[#333333] text-[13px]">{caseData.time}</p>
              </div>
              <div>
                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest mb-1.5 flex items-center gap-1.5">
                  <Clock className="w-3 h-3" /> Duration
                </p>
                <p className="font-bold text-[#333333] text-[13px]">{caseData.duration}</p>
              </div>
              <div>
                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest mb-1.5 flex items-center gap-1.5">
                  <Cpu className="w-3 h-3" /> Hardware ID
                </p>
                <p className="font-bold text-gray-600 text-[11px] bg-gray-100 px-2 py-1 rounded-md inline-block">{caseData.hardwareId}</p>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
  );
}
