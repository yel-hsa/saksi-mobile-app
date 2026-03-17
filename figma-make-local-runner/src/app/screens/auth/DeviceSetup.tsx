import { useNavigate } from "react-router-dom";
import { Cpu, Wifi, MapPin, Loader2, ArrowLeft, CheckCircle2 } from "lucide-react";
import { useState, useEffect } from "react";
import { motion } from "framer-motion";

export function DeviceSetup() {
  const navigate = useNavigate();
  const [isScanning, setIsScanning] = useState(true);
  const [gpsLocked, setGpsLocked] = useState(false);

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsScanning(false);
    }, 3000);
    return () => clearTimeout(timer);
  }, []);

  return (
    <div className="min-h-screen bg-white text-black font-sans px-6 py-12 flex flex-col relative">
      <button 
        onClick={() => navigate(-1)} 
        className="absolute top-6 left-6 p-2 rounded-full hover:bg-gray-100 transition-colors"
        aria-label="Go back"
      >
        <ArrowLeft className="w-6 h-6" />
      </button>

      <div className="flex-1 flex flex-col items-center justify-center max-w-sm mx-auto w-full pt-16">
        <h1 className="text-3xl font-black mb-8 text-center leading-tight">
          Connect Your SAKSI Device
        </h1>

        <div className="relative mb-12">
          <motion.div
            animate={{ scale: [1, 1.2, 1], opacity: [0.5, 0, 0.5] }}
            transition={{ repeat: Infinity, duration: 2 }}
            className="absolute inset-0 bg-blue-100 rounded-full"
          />
          <div className="w-40 h-40 bg-gray-50 border-4 border-[#333333] rounded-3xl flex items-center justify-center relative z-10 shadow-lg">
            <Cpu className="w-20 h-20 text-[#333333]" strokeWidth={1.5} />
            <motion.div
              animate={{ opacity: [0, 1, 0] }}
              transition={{ repeat: Infinity, duration: 1.5 }}
              className="absolute -top-4 -right-4"
            >
              <Wifi className="w-10 h-10 text-[#D32F2F]" />
            </motion.div>
          </div>
        </div>

        <div className="w-full bg-[#F5F5F5] rounded-xl p-6 shadow-sm mb-8 flex items-center gap-4 border border-gray-200">
          {isScanning ? (
            <Loader2 className="w-6 h-6 animate-spin text-[#D32F2F]" />
          ) : (
            <CheckCircle2 className="w-6 h-6 text-green-600" />
          )}
          <p className="text-sm font-semibold text-[#333333]">
            {isScanning
              ? "Scanning for nearby SAKSI ESP32 monitors..."
              : "SAKSI-ESP32-94A2 Found & Connected"}
          </p>
        </div>

        <label className="w-full bg-white border-2 border-gray-200 rounded-xl p-4 flex items-center justify-between cursor-pointer active:bg-gray-50 transition-colors shadow-sm">
          <div className="flex items-center gap-3">
            <div className="bg-red-50 p-2 rounded-full">
              <MapPin className="w-5 h-5 text-[#D32F2F]" />
            </div>
            <span className="font-bold text-[#333333]">Lock Home Zone (GPS)</span>
          </div>
          <div className={`w-14 h-8 flex items-center rounded-full p-1 transition-colors ${gpsLocked ? 'bg-[#D32F2F]' : 'bg-gray-300'}`}>
            <input 
              type="checkbox"
              className="hidden"
              checked={gpsLocked}
              onChange={() => setGpsLocked(!gpsLocked)}
            />
            <motion.div 
              className="bg-white w-6 h-6 rounded-full shadow-md"
              animate={{ x: gpsLocked ? 24 : 0 }}
            />
          </div>
        </label>

        <button
          onClick={() => navigate("/resident")}
          disabled={isScanning || !gpsLocked}
          className="w-full bg-black text-white font-bold py-4 rounded-xl mt-8 disabled:opacity-50 disabled:active:scale-100 active:scale-95 transition-all shadow-md"
        >
          Complete Setup
        </button>
      </div>
    </div>
  );
}
