<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Pandak - Digitalisasi Desa</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #ffffff;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .splash-container {
            text-align: center;
            animation: fadeIn 1.5s ease-out;
        }

        .logo-image {
            width: 300px;
            height: auto;
            margin-bottom: 20px;
            /* Animation for logo */
            animation: scaleIn 1s ease-out;
        }

        .app-title {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 10px;
            opacity: 0;
            animation: slideUp 0.8s ease-out 0.5s forwards;
        }

        .text-my {
            color: #00c4ff;
        }

        .text-pandak {
            color: #1a3669;
        }

        .tagline {
            font-size: 18px;
            font-weight: 500;
            color: #717171;
            margin-top: 5px;
            opacity: 0;
            animation: slideUp 0.8s ease-out 0.8s forwards;
        }

        .footer {
            position: absolute;
            bottom: 40px;
            font-size: 14px;
            font-weight: 500;
            color: #1a3669;
            text-align: center;
            width: 100%;
            opacity: 0;
            animation: fadeIn 1s ease-out 1.5s forwards;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes scaleIn {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @media (max-width: 768px) {
            .logo-image {
                width: 120px;
            }
            .app-title {
                font-size: 36px;
            }
            .tagline {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="splash-container">
        <img src="/assets/icons/mypandak.png" alt="My Pandak Logo" class="logo-image">
        <h1 class="app-title">
            <span class="text-my">My</span> <span class="text-pandak">Pandak</span>
        </h1>
        <p class="tagline">Digitalisasi Desa Mulai dari My Pandak</p>
    </div>

    <div class="footer">
        Dikembangkan oleh Tim Developer My Pandak
    </div>

    <script>
        // Redirect after 5 seconds (5000ms)
        // User asked for 5-10 seconds. I'll pick 5 seconds for better UX, or maybe 6.
        setTimeout(function() {
            // Redirect to the login page
            // Assuming the default login entry is for Warga based on recent context, 
            // or Pengurus. Usually one main login. 
            // I'll target the Warga login since it has the tab to switch to Pengurus.
            window.location.href = '/warga/login_warga';
        }, 6000); // 6 seconds
    </script>
</body>
</html>