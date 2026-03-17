import { useNavigate } from "react-router-dom";
import { ArrowLeft, User, MapPin, Bell, Wifi, ChevronRight, LogOut, Shield, FileText } from "lucide-react";

export function Settings() {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col min-h-full w-full pb-24 bg-[#F5F5F5] font-sans">
      <header className="flex items-center gap-4 px-6 py-4 bg-white shadow-sm z-10 sticky top-0">
        <button
          onClick={() => navigate(-1)}
          className="p-2 -ml-2 rounded-full hover:bg-gray-100 transition-colors"
          aria-label="Go back"
        >
          <ArrowLeft className="w-6 h-6 text-[#333333]" />
        </button>
        <h1 className="font-black text-xl tracking-tight text-[#333333]">Profile & Settings</h1>
      </header>

      <div className="px-6 py-6">
        {/* Profile Card */}
        <div className="bg-white rounded-[24px] p-6 shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 flex items-center gap-5 mb-8 relative overflow-hidden">
          <div className="w-[72px] h-[72px] bg-gray-50 rounded-2xl flex items-center justify-center shadow-inner flex-shrink-0 border border-gray-100">
            <User className="w-8 h-8 text-gray-400" />
          </div>
          <div className="z-10">
            <h2 className="text-xl font-black text-[#333333] leading-tight mb-1">Juan Dela Cruz</h2>
            <div className="flex items-center gap-2">
              <span className="text-[11px] font-bold text-gray-500 uppercase tracking-wider bg-gray-100 px-2 py-0.5 rounded-md">
                SAKSI-94A2
              </span>
            </div>
            <p className="text-[13px] text-gray-400 font-medium mt-1.5 line-clamp-1 flex items-center gap-1.5">
              <MapPin className="w-3.5 h-3.5" />
              144 Mabini St, Brgy. San Juan
            </p>
          </div>
          <div className="absolute -top-10 -right-10 w-32 h-32 bg-[#D32F2F]/5 rounded-full blur-2xl pointer-events-none" />
        </div>

        {/* Section: Account & Device */}
        <h3 className="text-[11px] font-bold text-gray-400 uppercase tracking-widest px-4 mb-3">Device & Alerts</h3>
        <div className="bg-white rounded-[24px] shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 overflow-hidden divide-y divide-gray-100 mb-8">
          <button className="w-full flex items-center gap-4 p-5 hover:bg-gray-50 transition-colors group text-left">
            <div className="w-10 h-10 rounded-xl bg-[#D32F2F]/10 flex items-center justify-center flex-shrink-0">
              <MapPin className="w-5 h-5 text-[#D32F2F]" />
            </div>
            <div className="flex-1">
              <span className="text-[15px] font-bold text-[#333333] block mb-0.5">Location Zone</span>
              <span className="text-xs text-gray-400 font-medium">Recalibrate home boundaries</span>
            </div>
            <ChevronRight className="w-5 h-5 text-gray-300 group-hover:text-[#333333] transition-colors" />
          </button>

          <button className="w-full flex items-center justify-between gap-4 p-5 hover:bg-gray-50 transition-colors">
            <div className="flex items-center gap-4">
              <div className="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center flex-shrink-0 border border-gray-100">
                <Bell className="w-5 h-5 text-gray-600" />
              </div>
              <div className="flex-1 text-left">
                <span className="text-[15px] font-bold text-[#333333] block mb-0.5">Push Alerts</span>
                <span className="text-xs text-gray-400 font-medium">Warnings & threshold breaches</span>
              </div>
            </div>
            <div className="w-[52px] h-[30px] bg-green-500 rounded-full p-1 relative shadow-inner flex items-center justify-end transition-colors cursor-pointer">
              <div className="w-6 h-6 bg-white rounded-full shadow-sm" />
            </div>
          </button>

          <button className="w-full flex items-center gap-4 p-5 hover:bg-gray-50 transition-colors group text-left">
            <div className="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center flex-shrink-0 border border-gray-100">
              <Wifi className="w-5 h-5 text-gray-600" />
            </div>
            <div className="flex-1">
              <span className="text-[15px] font-bold text-[#333333] block mb-0.5">Sensor Network</span>
              <span className="text-xs text-gray-400 font-medium">Connected to: <span className="text-[#333333]">Saksi-Home-5G</span></span>
            </div>
            <ChevronRight className="w-5 h-5 text-gray-300 group-hover:text-[#333333] transition-colors" />
          </button>
        </div>

        {/* Section: Support & Privacy */}
        <h3 className="text-[11px] font-bold text-gray-400 uppercase tracking-widest px-4 mb-3">Support & Legal</h3>
        <div className="bg-white rounded-[24px] shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 overflow-hidden divide-y divide-gray-100 mb-8">
          <button className="w-full flex items-center gap-4 p-5 hover:bg-gray-50 transition-colors group text-left">
            <div className="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0">
              <Shield className="w-5 h-5 text-blue-600" />
            </div>
            <div className="flex-1">
              <span className="text-[15px] font-bold text-[#333333] block mb-0.5">Privacy Overview</span>
              <span className="text-xs text-gray-400 font-medium">How your data is protected</span>
            </div>
            <ChevronRight className="w-5 h-5 text-gray-300 group-hover:text-[#333333] transition-colors" />
          </button>

          <button className="w-full flex items-center gap-4 p-5 hover:bg-gray-50 transition-colors group text-left">
            <div className="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center flex-shrink-0 border border-gray-100">
              <FileText className="w-5 h-5 text-gray-600" />
            </div>
            <div className="flex-1">
              <span className="text-[15px] font-bold text-[#333333] block mb-0.5">Barangay Ordinances</span>
              <span className="text-xs text-gray-400 font-medium">Local noise regulations guide</span>
            </div>
            <ChevronRight className="w-5 h-5 text-gray-300 group-hover:text-[#333333] transition-colors" />
          </button>
        </div>

        {/* Logout */}
        <button
          onClick={() => navigate("/")}
          className="w-full bg-white border border-gray-200 text-[#D32F2F] font-bold py-4 rounded-[20px] flex items-center justify-center gap-2.5 shadow-sm hover:bg-red-50 hover:border-red-100 active:scale-[0.98] transition-all"
        >
          <LogOut className="w-5 h-5" />
          <span className="text-[15px] tracking-wide">Sign Out Device</span>
        </button>
      </div>
    </div>
  );
}
