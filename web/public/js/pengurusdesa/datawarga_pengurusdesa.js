// Data warga (diambil dari localStorage)
let dataWarga = JSON.parse(localStorage.getItem('dataWarga') || '[]');

// DOM Elements
const tableBody = document.getElementById('tableBody');
const emptyState = document.getElementById('emptyState');
const tableContainer = document.getElementById('tableContainer');

// Fungsi untuk render tabel
function renderTable() {
    // Check if data is empty
    if (dataWarga.length === 0) {
        emptyState.style.display = 'block';
        tableContainer.style.display = 'none';
        return;
    }

    // Show table, hide empty state
    emptyState.style.display = 'none';
    tableContainer.style.display = 'block';
    
    tableBody.innerHTML = '';
    
    dataWarga.forEach((warga, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${warga.desaWisma || '-'}</td>
            <td>${warga.namaKepala || '-'}</td>
            <td>${warga.noRegistrasi || '-'}</td>
            <td>
                <div class="action-buttons">
                    <button class="btn-action btn-delete" onclick="deleteData(${warga.id})" title="Delete">
                        <img src="/assets/icons/delete.svg" alt="Delete" class="action-icon">
                    </button>
                </div>
            </td>
        `;
        
        // Tambahkan event click pada row (kecuali kolom aksi)
        row.addEventListener('click', (e) => {
            // Cek apakah yang diklik bukan tombol aksi
            if (!e.target.closest('.action-buttons')) {
                window.location.href = `adddatawarga_pengurusdesa?id=${warga.id}`;
            }
        });
        
        // Tambahkan style cursor pointer
        row.style.cursor = 'pointer';
        
        tableBody.appendChild(row);
    });
}

// Fungsi untuk hapus data
function deleteData(id) {
    if (confirm('Apakah Anda yakin ingin menghapus data ini?')) {
        dataWarga = dataWarga.filter(w => w.id !== id);
        localStorage.setItem('dataWarga', JSON.stringify(dataWarga));
        renderTable();
        
        // Tampilkan notifikasi
        alert('Data berhasil dihapus!');
    }
}

// Render tabel pertama kali
renderTable();

// Check login status (opsional)
if (!sessionStorage.getItem('isLoggedIn')) {
    // Redirect ke halaman login jika belum login
    // window.location.href = '../login';
}
