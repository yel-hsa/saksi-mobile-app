import { ArrowLeft, Shield, MapPin, CheckCircle, BellRing, User, Info, Search, Mail, Lock } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

import { Button } from "../components/ui/Button";
import { Card } from "../components/ui/Card";
import { Badge } from "../components/ui/Badge";
import { Typography } from "../components/ui/Typography";
import { Input } from "../components/ui/Input";
import { Tabs } from "../components/ui/Tabs";
import { Switch } from "../components/ui/Switch";

export function DesignSystem() {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState("components");
  const [switchState, setSwitchState] = useState(true);

  return (
    <div className="flex flex-col min-h-screen bg-[#F5F5F5] font-sans pb-24">
      <header className="flex items-center gap-4 px-6 pt-6 pb-4 bg-white shadow-sm sticky top-0 z-10 border-b border-gray-100">
        <button
          onClick={() => navigate(-1)}
          className="p-2 -ml-2 rounded-xl hover:bg-gray-100 transition-colors"
          aria-label="Go back"
        >
          <ArrowLeft className="w-6 h-6 text-[#333333]" />
        </button>
        <div>
           <Typography.H2>Design System</Typography.H2>
           <Typography.Subtitle>Component Library UI Kit</Typography.Subtitle>
        </div>
      </header>

      <div className="p-6 flex flex-col gap-10">

        {/* Colors */}
        <section>
          <Typography.Subtitle className="mb-4">Brand Colors</Typography.Subtitle>
          <div className="grid grid-cols-3 gap-3">
            <div className="flex flex-col">
              <div className="w-full h-16 bg-[#D32F2F] rounded-xl shadow-inner mb-2" />
              <Typography.Caption>Primary Red</Typography.Caption>
              <span className="text-[10px] text-gray-400">#D32F2F</span>
            </div>
            <div className="flex flex-col">
              <div className="w-full h-16 bg-[#333333] rounded-xl shadow-inner mb-2" />
              <Typography.Caption>Dark Text</Typography.Caption>
              <span className="text-[10px] text-gray-400">#333333</span>
            </div>
            <div className="flex flex-col">
              <div className="w-full h-16 bg-[#F5F5F5] border border-gray-200 rounded-xl mb-2" />
              <Typography.Caption>Background</Typography.Caption>
              <span className="text-[10px] text-gray-400">#F5F5F5</span>
            </div>
          </div>
        </section>

        {/* Typography */}
        <section>
          <Typography.Subtitle className="mb-4">Typography System</Typography.Subtitle>
          <Card className="flex flex-col gap-4">
             <div>
                <Typography.Caption>H1 (font-black text-2xl)</Typography.Caption>
                <Typography.H1>Page Title Header</Typography.H1>
             </div>
             <div>
                <Typography.Caption>H2 (font-black text-xl)</Typography.Caption>
                <Typography.H2>Section Header</Typography.H2>
             </div>
             <div>
                <Typography.Caption>H3 (font-black text-lg)</Typography.Caption>
                <Typography.H3>Card Title</Typography.H3>
             </div>
             <div>
                <Typography.Caption>Subtitle (text-xs uppercase tracking-widest)</Typography.Caption>
                <Typography.Subtitle>Subheading Label</Typography.Subtitle>
             </div>
             <div>
                <Typography.Caption>Body (text-sm font-medium)</Typography.Caption>
                <Typography.Body>This is the standard body text used for descriptions, instructions, and general readability.</Typography.Body>
             </div>
          </Card>
        </section>

        {/* Buttons */}
        <section>
          <Typography.Subtitle className="mb-4">Buttons</Typography.Subtitle>
          <Card className="flex flex-col gap-4 bg-gray-50/50">
            <div className="flex flex-col gap-2">
              <Typography.Caption>Primary Action</Typography.Caption>
              <Button fullWidth>
                <Shield className="w-5 h-5" /> Default Primary
              </Button>
            </div>
            
            <div className="flex flex-col gap-2">
              <Typography.Caption>Secondary Action</Typography.Caption>
              <Button variant="secondary" fullWidth>
                <CheckCircle className="w-5 h-5" /> Default Secondary
              </Button>
            </div>

            <div className="flex flex-col gap-2">
              <Typography.Caption>Outline / Ghost</Typography.Caption>
              <div className="flex gap-2">
                <Button variant="outline" className="flex-1">Outline</Button>
                <Button variant="ghost" className="flex-1">Ghost</Button>
              </div>
            </div>

            <div className="flex flex-col gap-2">
              <Typography.Caption>Sizes</Typography.Caption>
              <div className="flex items-center gap-3">
                <Button size="sm">Small</Button>
                <Button size="md">Medium</Button>
                <Button size="lg">Large</Button>
              </div>
            </div>
          </Card>
        </section>

        {/* Badges */}
        <section>
          <Typography.Subtitle className="mb-4">Status Badges</Typography.Subtitle>
          <Card className="flex flex-wrap gap-3">
            <Badge variant="success"><CheckCircle className="w-3.5 h-3.5" /> Resolved</Badge>
            <Badge variant="warning"><BellRing className="w-3.5 h-3.5" /> Pending Review</Badge>
            <Badge variant="danger"><Shield className="w-3.5 h-3.5" /> Violation</Badge>
            <Badge variant="info"><Info className="w-3.5 h-3.5" /> Verified</Badge>
            <Badge variant="neutral">Archived</Badge>
          </Card>
        </section>

        {/* Cards & Rows */}
        <section>
          <Typography.Subtitle className="mb-4">Cards & Interactive Rows</Typography.Subtitle>
          <div className="flex flex-col gap-4">
            
            <Card interactive className="flex items-center gap-4">
               <div className="w-12 h-12 rounded-xl bg-red-50 text-[#D32F2F] flex items-center justify-center flex-shrink-0">
                  <User className="w-6 h-6" />
               </div>
               <div className="flex-1">
                  <Typography.H3>Household 104</Typography.H3>
                  <Typography.Body className="flex items-center gap-1.5 text-xs">
                     <MapPin className="w-3.5 h-3.5" /> Zone 4
                  </Typography.Body>
               </div>
               <Badge variant="danger" size="sm">High Risk</Badge>
            </Card>

            <Card padding="sm" className="bg-[#333333] text-white">
              <div className="flex justify-between items-center px-2 py-2">
                <div>
                   <p className="text-[11px] font-bold text-gray-400 uppercase tracking-widest mb-1">Active Cases</p>
                   <span className="text-3xl font-black tabular-nums leading-none">12</span>
                </div>
                <div className="w-10 h-10 bg-white/10 rounded-full flex items-center justify-center border border-white/20">
                   <Shield className="w-5 h-5 text-white" />
                </div>
              </div>
            </Card>

          </div>
        </section>

        {/* Form Controls */}
        <section>
          <Typography.Subtitle className="mb-4">Form Controls</Typography.Subtitle>
          <Card className="flex flex-col gap-6">
            
            <div className="flex flex-col gap-2">
              <Typography.Caption>Text Input</Typography.Caption>
              <Input placeholder="Enter search term..." leftIcon={<Search className="w-5 h-5" />} />
            </div>

            <div className="flex flex-col gap-2">
              <Typography.Caption>Input with Error</Typography.Caption>
              <Input 
                placeholder="Password" 
                type="password"
                leftIcon={<Lock className="w-5 h-5" />} 
                error="Password must be at least 8 characters"
                defaultValue="secret"
              />
            </div>

            <div className="flex flex-col gap-2">
              <Typography.Caption>Switch Toggle</Typography.Caption>
              <div className="flex items-center justify-between bg-gray-50 p-4 rounded-xl border border-gray-100">
                <div>
                  <Typography.Body className="text-[#333333] font-bold">Push Notifications</Typography.Body>
                  <Typography.Caption>Receive alerts for nearby emergencies</Typography.Caption>
                </div>
                <Switch checked={switchState} onChange={setSwitchState} />
              </div>
            </div>

            <div className="flex flex-col gap-2">
              <Typography.Caption>Segmented Tabs</Typography.Caption>
              <Tabs
                activeTab={activeTab}
                onChange={setActiveTab}
                fullWidth
                tabs={[
                  { id: 'components', label: 'Components' },
                  { id: 'templates', label: 'Templates' },
                  { id: 'settings', label: 'Settings' }
                ]}
              />
            </div>
            
          </Card>
        </section>

      </div>
    </div>
  );
}
