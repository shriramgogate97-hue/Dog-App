import Sidebar from './components/Sidebar';

const stats = [
  { label: 'Today incidents', value: 46 },
  { label: 'Resolved under 30m', value: '71%' },
  { label: 'Active NGOs', value: 19 },
  { label: 'Hotspot zones', value: 7 }
];

export default function App() {
  return (
    <div className="layout">
      <Sidebar />
      <main className="content">
        <h1>Animal Rescue Admin Web App 📈</h1>
        <p>Track trends, assign NGOs, and improve rescue SLAs.</p>
        <div className="cards">
          {stats.map((stat) => (
            <div className="card" key={stat.label}>
              <h3>{stat.value}</h3>
              <p>{stat.label}</p>
            </div>
          ))}
        </div>
      </main>
    </div>
  );
}
