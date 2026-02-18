// Data catatan keluarga (diambil dari localStorage khusus Warga)
let dataCatatan = JSON.parse(localStorage.getItem('dataCatatanWarga') || '[]');

// DOM Elements
const tableBody = document.getElementById('tableBody');
const emptyState = document.getElementById('emptyState');
const tableContainer = document.getElementById('tableContainer');
const btnAddEmpty = document.getElementById('btnAddEmpty');
const btnAddTable = document.getElementById('btnAddTable');

// Fungsi untuk render tabel
function renderTable() {
    // Check if data is empty
    if (dataCatatan.length === 0) {
        emptyState.style.display = 'block';
        tableContainer.style.display = 'none';
        
        if(btnAddEmpty) btnAddEmpty.style.display = 'inline-block';
        return;
    }

    // Show table, hide empty state
    emptyState.style.display = 'none';
    tableContainer.style.display = 'block';
    
    // Single Entry Logic
    if (dataCatatan.length >= 1) {
        if(btnAddTable) btnAddTable.style.display = 'none';
        if(btnAddEmpty) btnAddEmpty.style.display = 'none';
    }
    
    tableBody.innerHTML = '';
    
    dataCatatan.forEach((catatan, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${catatan.desaWisma || '-'}</td>
            <td>${catatan.namaKeluarga || '-'}</td>
            <td>${catatan.noRegistrasi || '-'}</td>
            <td>${catatan.kriteriaRumah || '-'}</td>
            <td>${catatan.tahun || '-'}</td>
            <td>
                <div class="action-buttons">
                    <button class="btn-action btn-delete" onclick="deleteData(${catatan.id})" title="Hapus Data">
                        <img src="/assets/icons/delete.svg" alt="Delete" class="action-icon">
                    </button>
                </div>
            </td>
        `;
        
        row.addEventListener('click', (e) => {
             if (!e.target.closest('.action-buttons')) {
                alert('Data sudah tersimpan. Hapus data terlebih dahulu jika ingin mengisi ulang.');
             }
        });
        
        tableBody.appendChild(row);
    });
}

// Fungsi untuk hapus data
function deleteData(id) {
    if (confirm('Apakah Anda yakin ingin menghapus data ini?')) {
        dataCatatan = dataCatatan.filter(c => c.id !== id);
        localStorage.setItem('dataCatatanWarga', JSON.stringify(dataCatatan));
        renderTable();
        alert('Data berhasil dihapus!');
    }
}

// Render tabel pertama kali
renderTable();
