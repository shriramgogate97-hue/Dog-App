const menu = ['📊 Dashboard', '🧭 Incident Map', '🏥 NGO Network', '✅ Verification', '⚙️ Settings'];

export default function Sidebar() {
  return (
    <aside className="sidebar">
      <h2>🛡️ Admin</h2>
      <ul>
        {menu.map((item) => (
          <li key={item}>{item}</li>
        ))}
      </ul>
    </aside>
  );
}
