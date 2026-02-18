// Data catatan keluarga (diambil dari localStorage)
let dataCatatanKeluarga = JSON.parse(localStorage.getItem('dataCatatanKeluarga') || '[]');

// DOM Elements
const tableBody = document.getElementById('tableBody');
const emptyState = document.getElementById('emptyState');
const tableContainer = document.getElementById('tableContainer');

// Fungsi untuk render tabel
function renderTable() {
    // Check if data is empty
    if (dataCatatanKeluarga.length === 0) {
        emptyState.style.display = 'block';
        tableContainer.style.display = 'none';
        return;
    }

    // Show table, hide empty state
    emptyState.style.display = 'none';
    tableContainer.style.display = 'block';
    
    tableBody.innerHTML = '';
    
    dataCatatanKeluarga.forEach((catatan, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${catatan.desaWisma || '-'}</td>
            <td>${catatan.namaKepala || '-'}</td>
            <td>${catatan.noRegistrasi || '-'}</td>
            <td>
                <div class="action-buttons">
                    <button class="btn-action btn-delete" onclick="deleteData(${catatan.id})" title="Delete">
                        <img src="/assets/icons/delete.svg" alt="Delete" class="action-icon">
                    </button>
                </div>
            </td>
        `;
        
        row.addEventListener('click', (e) => {
             if (!e.target.closest('.action-buttons')) {
                window.location.href = `addcatatankeluarga_pengurusdesa?id=${catatan.id}`;
             }
        });

        tableBody.appendChild(row);
    });
}

// Fungsi untuk hapus data
function deleteData(id) {
    if (confirm('Apakah Anda yakin ingin menghapus data ini?')) {
        dataCatatanKeluarga = dataCatatanKeluarga.filter(c => c.id !== id);
        localStorage.setItem('dataCatatanKeluarga', JSON.stringify(dataCatatanKeluarga));
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
