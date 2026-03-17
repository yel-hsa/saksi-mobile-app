import { useNavigate } from "react-router-dom";
import { ArrowLeft, FileText, Download, Plus, Search, Filter, ShieldCheck, MapPin } from "lucide-react";

export function Reports() {
  const navigate = useNavigate();

  const reports = [
    { id: '1042-A', date: 'Oct 12, 2023', parties: 'Household 104 vs. Brgy', status: 'Pending Review', location: 'Mabini St. Block 2' },
    { id: '1041-B', date: 'Oct 10, 2023', parties: 'Zone 2 Complainant', status: 'Resolved', location: 'Rizal Ave.' },
  ];

  return (
    <div className="flex flex-col min-h-full w-full pb-24 bg-[#F5F5F5] relative font-sans">
      <header className="flex items-center justify-between px-6 pt-6 pb-4 bg-white shadow-sm z-10 sticky top-0 border-b border-gray-100">
        <div className="flex items-center gap-4">
          <button
            onClick={() => navigate(-1)}
            className="p-2 -ml-2 rounded-xl hover:bg-gray-100 transition-colors"
            aria-label="Go back"
          >
            <ArrowLeft className="w-6 h-6 text-[#333333]" />
          </button>
          <div>
            <h1 className="font-black text-xl tracking-tight text-[#333333] leading-none mb-1">Mediation Logs</h1>
            <p className="text-[11px] font-bold text-gray-400 uppercase tracking-widest">Official Records</p>
          </div>
        </div>
        <button className="p-2.5 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors border border-gray-100" aria-label="Search">
          <Search className="w-5 h-5 text-[#333333]" />
        </button>
      </header>

      {/* Trust Banner */}
      <div className="bg-blue-50/50 border-b border-blue-100 px-6 py-3 flex items-start gap-3">
        <ShieldCheck className="w-5 h-5 text-blue-600 mt-0.5 flex-shrink-0" />
        <div>
          <h4 className="text-[13px] font-bold text-blue-900 mb-0.5">Secure Evidence Vault</h4>
          <p className="text-[11px] text-blue-800/80 font-medium leading-relaxed">
            All records are cryptographically timestamped and verified for barangay mediation purposes.
          </p>
        </div>
      </div>

      <div className="px-6 py-5 flex gap-2 overflow-x-auto no-scrollbar">
        <button className="bg-[#333333] text-white px-5 py-2.5 rounded-xl text-[13px] font-bold flex items-center gap-2 whitespace-nowrap shadow-md">
          Active Cases
        </button>
        <button className="bg-white border border-gray-200 text-gray-600 px-5 py-2.5 rounded-xl text-[13px] font-bold flex items-center gap-2 whitespace-nowrap hover:bg-gray-50 transition-colors">
          Archived
        </button>
        <button className="bg-white border border-gray-200 text-gray-600 px-4 py-2.5 rounded-xl text-[13px] font-bold flex items-center justify-center whitespace-nowrap hover:bg-gray-50 transition-colors" aria-label="Filter">
          <Filter className="w-4 h-4" />
        </button>
      </div>

      <div className="px-6 flex flex-col gap-4">
        {reports.map((report) => (
          <div key={report.id} className="bg-white rounded-[24px] p-6 shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 flex flex-col relative overflow-hidden group hover:border-gray-200 hover:shadow-md transition-all">
            
            <div className="flex justify-between items-start mb-5">
              <div>
                <div className="flex items-center gap-2 mb-2">
                  <span className="text-[11px] font-bold text-gray-500 bg-gray-100 px-2 py-0.5 rounded-md uppercase tracking-wider">
                    CASE {report.id}
                  </span>
                  <span className="text-[11px] font-bold text-gray-400 flex items-center gap-1">
                    • {report.date}
                  </span>
                </div>
                <h3 className="font-black text-lg text-[#333333] leading-tight mb-1.5">{report.parties}</h3>
                <p className="text-xs font-medium text-gray-500 flex items-center gap-1.5">
                  <MapPin className="w-3.5 h-3.5" /> {report.location}
                </p>
              </div>
              <span className={`text-[10px] font-bold uppercase tracking-wider px-2.5 py-1 rounded-lg border ${
                report.status === 'Resolved' 
                  ? 'bg-green-50 text-green-700 border-green-200' 
                  : 'bg-amber-50 text-amber-700 border-amber-200'
              }`}>
                {report.status}
              </span>
            </div>

            <div className="h-px w-full bg-gray-100 mb-5" />

            <div className="flex gap-3">
              <button 
                onClick={() => navigate(`/official/case/${report.id.split('-')[0]}`)}
                className="flex-1 bg-[#F5F5F5] hover:bg-gray-200 text-[#333333] text-[13px] font-bold py-3.5 rounded-xl flex items-center justify-center gap-2 active:scale-95 transition-all"
              >
                <FileText className="w-4 h-4" />
                Case File
              </button>
              <button className="flex-[0.6] bg-white border border-[#D32F2F]/20 text-[#D32F2F] hover:bg-red-50 text-[13px] font-bold py-3.5 rounded-xl flex items-center justify-center gap-2 active:scale-95 transition-all">
                <Download className="w-4 h-4" />
                Export
              </button>
            </div>
          </div>
        ))}
      </div>

      <button className="fixed bottom-24 right-6 w-14 h-14 bg-[#D32F2F] text-white rounded-full flex items-center justify-center shadow-[0_8px_20px_rgba(211,47,47,0.3)] active:scale-95 transition-transform z-40 hover:bg-red-700" aria-label="Create new report">
        <Plus className="w-6 h-6" strokeWidth={3} />
      </button>
    </div>
  );
}
