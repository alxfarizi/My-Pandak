// Data keluarga (diambil dari localStorage)
let dataKeluarga = JSON.parse(localStorage.getItem('dataKeluarga') || '[]');

// DOM Elements
const tableBody = document.getElementById('tableBody');
const emptyState = document.getElementById('emptyState');
const tableContainer = document.getElementById('tableContainer');

// Fungsi untuk render tabel
function renderTable() {
    // Check if data is empty
    if (dataKeluarga.length === 0) {
        emptyState.style.display = 'block';
        tableContainer.style.display = 'none';
        return;
    }

    // Show table, hide empty state
    emptyState.style.display = 'none';
    tableContainer.style.display = 'block';
    
    tableBody.innerHTML = '';
    
    dataKeluarga.forEach((keluarga, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${keluarga.desaWisma || '-'}</td>
            <td>${keluarga.namaKepala || '-'}</td>
            <td>${keluarga.noRegistrasi || '-'}</td>
            <td>
                <div class="action-buttons">
                    <button class="btn-action btn-delete" onclick="deleteData(${keluarga.id})" title="Delete">
                        <img src="/assets/icons/delete.svg" alt="Delete" class="action-icon">
                    </button>
                </div>
            </td>
        `;
        
        row.addEventListener('click', (e) => {
             if (!e.target.closest('.action-buttons')) {
                window.location.href = `adddatakeluarga_pengurusdesa?id=${keluarga.id}`;
             }
        });
        
        tableBody.appendChild(row);
    });
}

// Fungsi untuk hapus data
function deleteData(id) {
    if (confirm('Apakah Anda yakin ingin menghapus data ini?')) {
        dataKeluarga = dataKeluarga.filter(k => k.id !== id);
        localStorage.setItem('dataKeluarga', JSON.stringify(dataKeluarga));
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
