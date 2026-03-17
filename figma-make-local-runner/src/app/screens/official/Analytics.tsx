import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, Cell, CartesianGrid } from 'recharts';
import { ArrowLeft, AlertTriangle, ChevronRight, User, TrendingUp, Activity } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

export function Analytics() {
  const navigate = useNavigate();

  const chartData = [
    { name: 'Zone 4', db: 88, color: '#D32F2F' },
    { name: 'Zone 2', db: 75, color: '#ff6b6b' },
    { name: 'Zone 7', db: 65, color: '#333333' },
    { name: 'Zone 1', db: 55, color: '#9ca3af' },
  ];

  const offenders = [
    { id: 1, name: 'Household 104', zone: 'Zone 4', violations: 3, avatarColor: 'bg-red-50 text-[#D32F2F]', risk: 'High Risk' },
    { id: 2, name: 'Household 052', zone: 'Zone 2', violations: 2, avatarColor: 'bg-amber-50 text-amber-600', risk: 'Elevated Risk' },
  ];

  return (
    <div className="flex flex-col min-h-full w-full pb-24 bg-[#F5F5F5] font-sans">
      <header className="flex items-center gap-4 px-6 pt-6 pb-4 bg-white shadow-sm z-10 sticky top-0">
        <button
          onClick={() => navigate(-1)}
          className="p-2 -ml-2 rounded-xl hover:bg-gray-100 transition-colors"
          aria-label="Go back"
        >
          <ArrowLeft className="w-6 h-6 text-[#333333]" />
        </button>
        <div>
          <h1 className="font-black text-xl tracking-tight text-[#333333] leading-none mb-1">Analytics Dashboard</h1>
          <p className="text-[11px] font-bold text-gray-400 uppercase tracking-widest">Community Overview</p>
        </div>
      </header>

      <div className="p-6 flex flex-col gap-8">
        
        {/* Risk Score Summary */}
        <div className="bg-[#333333] text-white rounded-[24px] p-6 shadow-[0_8px_30px_rgba(0,0,0,0.12)] relative overflow-hidden">
          <div className="relative z-10">
            <h2 className="text-[13px] font-bold text-gray-400 uppercase tracking-widest mb-4 flex items-center gap-2">
              <Activity className="w-4 h-4" />
              Community Risk Score
            </h2>
            <div className="flex items-end justify-between">
              <div className="flex items-baseline gap-2">
                <span className="text-5xl font-black tabular-nums tracking-tighter">72</span>
                <span className="text-sm font-semibold text-gray-400">/ 100</span>
              </div>
              <div className="flex items-center gap-1.5 bg-red-500/20 text-red-300 px-3 py-1.5 rounded-lg border border-red-500/30">
                <TrendingUp className="w-3.5 h-3.5" />
                <span className="text-xs font-bold">+12% vs last week</span>
              </div>
            </div>
          </div>
          {/* Subtle gradient background */}
          <div className="absolute top-0 right-0 w-64 h-64 bg-[#D32F2F]/10 rounded-full blur-3xl pointer-events-none transform translate-x-1/3 -translate-y-1/3" />
        </div>

        {/* Data Viz Section */}
        <section>
          <div className="flex items-center justify-between mb-4">
             <h2 className="text-[15px] font-black text-[#333333]">Escalation Trends</h2>
             <span className="text-[10px] font-bold uppercase tracking-wider bg-gray-200/50 text-gray-600 px-2.5 py-1 rounded-md">
               This Week
             </span>
          </div>
          
          <div className="bg-white rounded-[24px] p-6 shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 flex flex-col h-72">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart
                id="analytics-bar-chart"
                layout="vertical"
                data={chartData}
                margin={{ top: 0, right: 20, left: -10, bottom: 0 }}
              >
                <CartesianGrid strokeDasharray="3 3" horizontal={false} stroke="#f3f4f6" />
                <XAxis key="x-axis" id="x-axis" type="number" hide />
                <YAxis 
                  key="y-axis"
                  id="y-axis"
                  type="category" 
                  dataKey="name" 
                  axisLine={false} 
                  tickLine={false} 
                  tick={{ fill: '#6b7280', fontSize: 11, fontWeight: 700 }} 
                  width={60}
                />
                <Tooltip 
                  key="tooltip"
                  id="tooltip"
                  cursor={{ fill: '#f9fafb' }}
                  contentStyle={{ borderRadius: '16px', border: '1px solid #f3f4f6', boxShadow: '0 8px 30px rgba(0,0,0,0.08)', fontWeight: 'bold' }}
                  itemStyle={{ color: '#333333' }}
                />
                <Bar key="bar" id="bar" dataKey="db" radius={[0, 12, 12, 0]} barSize={24}>
                  {chartData.map((entry) => (
                    <Cell key={entry.name} fill={entry.color} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
            <div className="mt-4 flex items-center justify-center gap-4 text-[10px] font-bold uppercase tracking-widest text-gray-400 border-t border-gray-100 pt-4">
               <div className="flex items-center gap-1.5"><span className="w-2 h-2 rounded-full bg-[#D32F2F]" /> Violation</div>
               <div className="flex items-center gap-1.5"><span className="w-2 h-2 rounded-full bg-[#ff6b6b]" /> Warning</div>
               <div className="flex items-center gap-1.5"><span className="w-2 h-2 rounded-full bg-[#333333]" /> Normal</div>
            </div>
          </div>
        </section>

        {/* Repeat Offenders */}
        <section>
          <h2 className="text-[15px] font-black text-[#333333] mb-4">Enforcement Activity</h2>
          
          <div className="flex flex-col gap-3">
            {offenders.map((offender) => (
              <div key={offender.id} className="bg-white rounded-[20px] p-5 shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 flex items-center gap-4 group cursor-pointer hover:shadow-md hover:border-gray-200 transition-all">
                <div className={`w-12 h-12 rounded-2xl flex items-center justify-center flex-shrink-0 ${offender.avatarColor} border border-gray-100`}>
                   <User className="w-6 h-6" />
                </div>
                <div className="flex-1">
                  <h3 className="font-bold text-[#333333] text-[15px] mb-0.5">{offender.name}</h3>
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-gray-500 font-medium">{offender.zone}</span>
                    <span className="w-1 h-1 bg-gray-300 rounded-full" />
                    <span className={`text-[10px] font-bold uppercase tracking-wider ${
                      offender.violations > 2 ? 'text-[#D32F2F]' : 'text-amber-600'
                    }`}>
                      {offender.risk}
                    </span>
                  </div>
                </div>
                <div className="flex flex-col items-end gap-1">
                  <div className="flex items-center gap-1.5 bg-red-50 px-2.5 py-1 rounded-lg border border-red-100">
                    <AlertTriangle className="w-3 h-3 text-[#D32F2F]" />
                    <span className="text-xs font-bold text-[#D32F2F]">{offender.violations}</span>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-gray-300 group-hover:text-[#333333] transition-colors ml-1" />
              </div>
            ))}
          </div>
        </section>
      </div>
    </div>
  );
}
