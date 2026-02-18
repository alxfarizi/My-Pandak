// Initialize Map
document.addEventListener('DOMContentLoaded', function() {
    // Check if map element exists
    if (document.getElementById('map')) {
        // Initialize map centered on Pandak, Baturraden, Banyumas (approximate coordinates)
        // Coordinates for Pandak, Baturraden: -7.3305, 109.2347 (Example coords)
        const map = L.map('map').setView([-7.3305, 109.2347], 15);

        // Add OpenStreetMap tile layer
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Add a marker for the Village Office (Balai Desa)
        const marker = L.marker([-7.3305, 109.2347]).addTo(map)
            .bindPopup('<b>Balai Desa Pandak</b><br>Kec. Baturraden, Kab. Banyumas.')
            .openPopup();
    }
});

// Sidebar Active State Management
const currentPath = window.location.pathname.split('/').pop();
const navItems = document.querySelectorAll('.nav-item');

navItems.forEach(item => {
    const href = item.getAttribute('href');
    if (href === currentPath) {
        item.classList.add('active');
    } else {
        item.classList.remove('active');
    }
});
