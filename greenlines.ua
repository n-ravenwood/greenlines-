import React, { useMemo, useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import {
  ArrowRight,
  Globe2,
  Leaf,
  Shield,
  Sprout,
  Users,
  Search,
  Download
} from "lucide-react";
import { ResponsiveContainer, BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid } from "recharts";

const demoJobs = [
  { sector: "Solar", jobs: 42000 },
  { sector: "Wind", jobs: 28000 },
  { sector: "Retrofits", jobs: 52000 },
  { sector: "Circular Hubs", jobs: 16000 },
  { sector: "Demining + Eco", jobs: 12000 },
];

const demoResources = [
  { title: "UNEP Report", scope: "environment", link: "https://unep.org", languages: "EN, UA" },
  { title: "OSCE Mine Action", scope: "war", link: "https://osce.org", languages: "EN" },
  { title: "Local NGO Data", scope: "damage", link: "https://example.org", languages: "UA" },
  { title: "Archived Study", scope: "old data", link: "https://archive.org", languages: "EN, UA, FR" },
];

export default function Greenlines() {
  const [email, setEmail] = useState("");
  const [message, setMessage] = useState("");
  const [search, setSearch] = useState("");

  const kpis = useMemo(
    () => [
      { label: "Buildings to Retrofit", value: "25k+", icon: Shield },
      { label: "Hectares Restored", value: "1.2M+", icon: Sprout },
      { label: "Sensors Deployed", value: "8,000+", icon: Globe2 },
      { label: "Communities Engaged", value: "1,000+", icon: Users },
    ],
    []
  );

  const filteredResources = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return demoResources;
    return demoResources.filter((r) => {
      return (
        (r.title && r.title.toLowerCase().includes(q)) ||
        (r.scope && r.scope.toLowerCase().includes(q)) ||
        (r.languages && r.languages.toLowerCase().includes(q))
      );
    });
  }, [search]);

  const exportCSV = () => {
    try {
      const headers = "Title,Scope,Link,Languages";
      const rows = filteredResources
        .map((r) => `${escapeCsv(r.title)},${escapeCsv(r.scope)},${escapeCsv(r.link)},${escapeCsv(r.languages)}`)
        .join("\n");
      const blob = new Blob([headers + "\n" + rows], { type: "text/csv;charset=utf-8;" });
      const url = URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = "greenlines-resources.csv";
      document.body.appendChild(a);
      a.click();
      a.remove();
      URL.revokeObjectURL(url);
    } catch (err) {
      console.error("Export failed", err);
    }
  };

  function escapeCsv(value) {
    if (value == null) return "";
    const str = String(value);
    if (str.includes(",") || str.includes("\n") || str.includes('"')) {
      return '"' + str.replace(/"/g, '""') + '"';
    }
    return str;
  }

  const handleContactSubmit = (e) => {
    e.preventDefault();
    setEmail("");
    setMessage("");
    alert("Thanks — your message was recorded (demo).");
  };

  const scrollToSection = (id) => {
    const el = document.getElementById(id);
    if (el) el.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <main className="min-h-screen bg-neutral-50 text-neutral-900">
      <header className="sticky top-0 z-50 bg-white/80 backdrop-blur border-b">
        <div className="max-w-7xl mx-auto h-16 px-4 sm:px-6 lg:px-8 flex items-center justify-between">
          <button onClick={() => scrollToSection("home")} className="flex items-center gap-2">
            <Leaf className="w-6 h-6 text-emerald-600" />
            <span className="font-semibold">Greenlines</span>
          </button>
          <nav className="hidden md:flex gap-6 text-sm">
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("mission")}>Mission</button>
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("pillars")}>Pillars</button>
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("programs")}>Programs</button>
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("impact")}>Impact</button>
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("resources")}>Resources</button>
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("timeline")}>Timeline</button>
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("partners")}>Partners</button>
            <button className="hover:text-emerald-700" onClick={() => scrollToSection("contact")}>Contact</button>
          </nav>
          <Button className="rounded-2xl" onClick={() => scrollToSection("contact")}>Get Involved</Button>
        </div>
      </header>

      <section id="home" className="relative bg-emerald-700 text-white py-24 text-center">
        <div className="max-w-3xl mx-auto">
          <h1 className="text-4xl md:text-6xl font-bold leading-tight">Greenlines: Rebuilding Ukraine Sustainably</h1>
          <p className="mt-4 text-lg md:text-xl">A Vision for a Resilient, Green Future in Partnership with the European Council</p>
          <p className="mt-2 text-md">Presented by Yesakova Anastasiia — For Erasmus+, the European Council & the public</p>
          <div className="mt-6 flex justify-center">
            <Button size="lg" className="rounded-2xl bg-white text-emerald-700 hover:bg-neutral-100" onClick={() => scrollToSection("mission")}>
              Learn More <ArrowRight className="ml-2 w-5 h-5" />
            </Button>
          </div>
        </div>
      </section>

      <section id="mission" className="py-16 md:py-24 bg-white text-center">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl md:text-4xl font-bold">Our Mission</h2>
          <p className="mt-4 text-neutral-700">We aim to rebuild Ukraine sustainably with support from the EU, focusing on green energy, infrastructure, and community resilience.</p>
          <img src="https://upload.wikimedia.org/wikipedia/commons/b/b7/European_Council_building_2017.jpg" alt="European Council" className="mt-6 rounded-2xl shadow-md mx-auto" />
        </div>
      </section>

      <section id="impact" className="py-16 md:py-24 bg-neutral-100">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 grid md:grid-cols-4 gap-6">
          {kpis.map((kpi, i) => {
            const Icon = kpi.icon;
            return (
              <Card key={i} className="text-center shadow-sm rounded-2xl">
                <CardHeader>
                  <Icon className="w-8 h-8 mx-auto text-emerald-600" />
                  <CardTitle className="text-xl font-bold mt-2">{kpi.value}</CardTitle>
                </CardHeader>
                <CardContent className="text-sm text-neutral-600">{kpi.label}</CardContent>
              </Card>
            );
          })}
        </div>
      </section>

      <section id="programs" className="py-16 md:py-24 bg-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl md:text-4xl font-bold text-center">Green Recovery = Green Jobs</h2>
          <div className="h-80 mt-8">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={demoJobs}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="sector" />
                <YAxis />
                <Tooltip />
                <Bar dataKey="jobs" fill="#059669" radius={[6, 6, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
          <img src="https://upload.wikimedia.org/wikipedia/commons/7/79/Kyiv_war_damage.jpg" alt="War Damage in Ukraine" className="mt-8 rounded-2xl shadow-md mx-auto" />
        </div>
      </section>

      <section id="resources" className="py-16 md:py-24 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl md:text-4xl font-bold text-center">Open Resources Database</h2>
          <p className="mt-3 text-center text-neutral-700 max-w-3xl mx-auto">Browse and filter research, datasets, and reports supporting green recovery and monitoring.</p>

          <div className="mt-6 flex flex-col sm:flex-row gap-3 items-center justify-between">
            <div className="relative w-full sm:w-80">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-neutral-500" />
              <Input className="pl-9" placeholder="Search by title, scope, or language" value={search} onChange={(e) => setSearch(e.target.value)} />
            </div>
            <Button variant="outline" className="rounded-2xl flex items-center gap-2" onClick={exportCSV}>
              <Download className="w-4 h-4" /> Export CSV
            </Button>
          </div>

          <div className="mt-8 overflow-x-auto">
            <table className="w-full border border-neutral-200 text-sm">
              <thead className="bg-neutral-100">
                <tr>
                  <th className="px-4 py-2 text-left">Title</th>
                  <th className="px-4 py-2 text-left">Scope</th>
                  <th className="px-4 py-2 text-left">Languages</th>
                  <th className="px-4 py-2 text-left">Link</th>
                </tr>
              </thead>
              <tbody>
                {filteredResources.map((r, idx) => (
                  <tr key={idx} className="border-t">
                    <td className="px-4 py-2 font-medium">{r.title}</td>
                    <td className="px-4 py-2 capitalize">{r.scope}</td>
                    <td className="px-4 py-2">{r.languages}</td>
                    <td className="px-4 py-2 text-emerald-700 underline">
                      <a href={r.link} target="_blank" rel="noreferrer">Open</a>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </section>

      <section id="partners" className="py-16 md:py-24 bg-neutral-100">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl md:text-4xl font-bold">Our Partners</h2>
          <p className="mt-3 text-neutral-700">Greenlines collaborates with European institutions, NGOs, and local Ukrainian organizations.</p>
          <div className="mt-8 grid grid-cols-2 md:grid-cols-4 gap-6 items-center">
            <img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/European_Union_emblem.svg" alt="European Union" className="h-20 mx-auto" />
            <img src="https://upload.wikimedia.org/wikipedia/commons/d/d7/Flag_of_Europe.svg" alt="European Council" className="h-20 mx-auto" />
            <img src="https://upload.wikimedia.org/wikipedia/commons/0/0e/Erasmus%2B_Logo.svg" alt="Erasmus+" className="h-20 mx-auto" />
            <img src="https://upload.wikimedia.org/wikipedia/commons/0/02/NGO_icon.svg" alt="NGO" className="h-20 mx-auto" />
          </div>
        </div>
      </section>

      <section id="contact" className="py-16 md:py-24 bg-neutral-100">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl md:text-4xl font-bold">Contact Us</h2>
          <p className="mt-3 text-neutral-700">Get in touch to collaborate or learn more about Greenlines.</p>
          <form onSubmit={handleContactSubmit} className="mt-6 space-y-4 text-left">
            <Input type="email" placeholder="Your email" value={email} onChange={(e) => setEmail(e.target.value)} />
            <Textarea placeholder="Your message" value={message} onChange={(e) => setMessage(e.target.value)} />
            <Button type="submit" className="rounded-2xl w-full">Send</Button>
          </form>
        </div>
      </section>

      <footer className="py-6 text-center text-sm text-neutral-500">© 2025 Greenlines. All rights reserved.</footer>
    </main>
  );
}
