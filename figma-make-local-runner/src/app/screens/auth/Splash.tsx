import { useNavigate } from "react-router-dom";

export function Splash() {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col min-h-screen bg-white font-sans">
      <div className="flex-grow flex flex-col items-center justify-center p-6">
        <h1 className="text-5xl font-black text-black tracking-tighter mb-4">
          SAKSI
        </h1>
        <p className="text-center text-[#333333] text-lg font-medium max-w-[280px]">
          Community Mediation & Accountability System
        </p>
      </div>

      <div className="p-6 flex flex-col gap-4 w-full max-w-sm mx-auto mb-8">
        <button
          onClick={() => navigate("/login?role=resident")}
          className="w-full bg-black text-white font-bold py-4 rounded-xl shadow-md active:scale-95 transition-transform"
        >
          Continue as Resident
        </button>
        <button
          onClick={() => navigate("/login?role=official")}
          className="w-full border-2 border-[#D32F2F] text-[#D32F2F] font-bold py-4 rounded-xl bg-white shadow-sm active:scale-95 transition-transform"
        >
          Barangay Official Portal
        </button>
      </div>
    </div>
  );
}
