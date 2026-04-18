import Sidebar from './components/Sidebar';

const incidents = [
  { animal: 'Dog', condition: 'Injured leg', area: 'Indiranagar', eta: '12 min' },
  { animal: 'Puppy', condition: 'Dehydration', area: 'Koramangala', eta: '18 min' },
  { animal: 'Cat', condition: 'Roadside accident', area: 'HSR Layout', eta: '22 min' }
];

export default function App() {
  return (
    <div className="layout">
      <Sidebar />
      <main className="content">
        <header>
          <h1>Animal Rescue Network India 🧡</h1>
          <p>Report fast. Rescue faster. Save lives.</p>
        </header>

        <section className="hero-card">
          <h3>🚨 Emergency SOS</h3>
          <button type="button">Raise Incident</button>
        </section>

        <section className="incidents">
          <h3>Live Incidents</h3>
          {incidents.map((item) => (
            <article key={`${item.animal}-${item.area}`} className="incident-card">
              <img
                src="https://images.unsplash.com/photo-1548199973-03cce0bbc87b?auto=format&fit=crop&w=600&q=80"
                alt="Rescue dog"
              />
              <div>
                <h4>{item.animal} • {item.area}</h4>
                <p>{item.condition}</p>
                <p>🛰️ Team ETA: {item.eta}</p>
              </div>
            </article>
          ))}
        </section>
      </main>
    </div>
  );
}
