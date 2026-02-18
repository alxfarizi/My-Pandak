// Data keluarga (diambil dari localStorage khusus Warga)
let dataKeluarga = JSON.parse(localStorage.getItem('dataKeluargaWarga') || '[]');

// DOM Elements
const tableBody = document.getElementById('tableBody');
const emptyState = document.getElementById('emptyState');
const tableContainer = document.getElementById('tableContainer');
const btnAddEmpty = document.getElementById('btnAddEmpty');
const btnAddTable = document.getElementById('btnAddTable');

// Fungsi untuk render tabel
function renderTable() {
    // Check if data is empty
    if (dataKeluarga.length === 0) {
        emptyState.style.display = 'block';
        tableContainer.style.display = 'none';
        
        // Show add button in empty state
        if(btnAddEmpty) btnAddEmpty.style.display = 'inline-block';
        return;
    }

    // Show table, hide empty state
    emptyState.style.display = 'none';
    tableContainer.style.display = 'block';
    
    // Hide add buttons if data exists (Single Entry Logic)
    if (dataKeluarga.length >= 1) {
        if(btnAddTable) btnAddTable.style.display = 'none';
        if(btnAddEmpty) btnAddEmpty.style.display = 'none';
    }
    
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
                    <button class="btn-action btn-delete" onclick="deleteData(${keluarga.id})" title="Hapus Data (Reset)">
                        <img src="/assets/icons/delete.svg" alt="Delete" class="action-icon">
                    </button>
                </div>
            </td>
        `;
        
        // Klik baris untuk edit (kecuali tombol delete)
        row.addEventListener('click', (e) => {
             if (!e.target.closest('.action-buttons')) {
                // Bisa tambahkan mode edit nanti, untuk sekarang mungkin view/overwrite
                // window.location.href = `adddatakeluarga_warga?id=${keluarga.id}`;
                alert('Data sudah tersimpan. Hapus data terlebih dahulu jika ingin mengisi ulang.');
             }
        });
        
        tableBody.appendChild(row);
    });
}

// Fungsi untuk hapus data
function deleteData(id) {
    if (confirm('Apakah Anda yakin ingin menghapus data ini? Anda bisa mengisi ulang setelah menghapus.')) {
        dataKeluarga = dataKeluarga.filter(k => k.id !== id);
        localStorage.setItem('dataKeluargaWarga', JSON.stringify(dataKeluarga));
        renderTable();
        
        // Tampilkan notifikasi
        alert('Data berhasil dihapus! Silakan isi kembali data keluarga Anda.');
    }
}

// Render tabel pertama kali
renderTable();
