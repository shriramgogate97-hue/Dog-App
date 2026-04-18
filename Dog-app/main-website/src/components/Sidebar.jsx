const items = ['🏠 Home', '🚨 SOS', '📍 Track Rescue', '🏆 Rewards', '🐕 Street Profiles'];

export default function Sidebar() {
  return (
    <aside className="sidebar">
      <h2>🐶 Dog App</h2>
      <ul>
        {items.map((item) => (
          <li key={item}>{item}</li>
        ))}
      </ul>
    </aside>
  );
}
