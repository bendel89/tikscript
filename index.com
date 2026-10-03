<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TikScript - Générateur d'idées & scripts TikTok</title>
  <style>
    :root {
      --primary: #fe2c55;
      --primary-hover: #ff4d6d;
      --bg: #0a0a0a;
      --card: #141414;
      --text: #ffffff;
      --muted: #888;
      --border: #2a2a2a;
      --success: #00e676;
    } 

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: var(--bg);
      color: var(--text);
      min-height: 100vh;
      line-height: 1.5;
    }

    .container {
      max-width: 720px;
      margin: 0 auto;
      padding: 30px 20px 60px;
    }

    /* Header */
    header {
      text-align: center;
      margin-bottom: 40px;
    }

    .logo {
      font-size: 1.5rem;
      font-weight: 800;
      background: linear-gradient(90deg, #fe2c55, #25f4ee);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-bottom: 8px;
    }

    h1 {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 8px;
    }

    .subtitle {
      color: var(--muted);
      font-size: 1rem;
    }

    /* Card */
    .card {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 18px;
      padding: 28px;
      margin-bottom: 24px;
    }

    .section-title {
      font-size: 0.95rem;
      font-weight: 600;
      margin-bottom: 14px;
      color: #ccc;
    }

    /* Niche */
    select, input[type="text"] {
      width: 100%;
      padding: 14px 16px;
      border-radius: 12px;
      border: 1px solid var(--border);
      background: #0f0f0f;
      color: var(--text);
      font-size: 15px;
      margin-bottom: 12px;
    }

    select:focus, input:focus {
      outline: none;
      border-color: var(--primary);
    }

    /* Type de contenu */
    .type-grid {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 10px;
      margin-bottom: 8px;
    }

    @media (max-width: 500px) {
      .type-grid {
        grid-template-columns: 1fr;
      }
    }

    .type-btn {
      padding: 14px;
      border-radius: 12px;
      border: 1px solid var(--border);
      background: #0f0f0f;
      color: var(--text);
      font-size: 14px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s;
      text-align: center;
    }

    .type-btn:hover {
      border-color: #555;
    }

    .type-btn.active {
      background: var(--primary);
      border-color: var(--primary);
      color: white;
    }

    /* Options */
    .options {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
      margin-top: 18px;
    }

    .option-group label {
      display: block;
      font-size: 13px;
      color: var(--muted);
      margin-bottom: 6px;
    }

    .option-group select {
      width: 140px;
      margin-bottom: 0;
    }

    /* Generate button */
    .generate-btn {
      width: 100%;
      padding: 16px;
      margin-top: 24px;
      border: none;
      border-radius: 14px;
      background: linear-gradient(135deg, #fe2c55, #ff4d6d);
      color: white;
      font-size: 16px;
      font-weight: 700;
      cursor: pointer;
      transition: all 0.2s;
      box-shadow: 0 4px 20px #fe2c5540;
    }

    .generate-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 25px #fe2c5560;
    }

    .generate-btn:disabled {
      opacity: 0.6;
      cursor: not-allowed;
      transform: none;
    }

    /* Results */
    .results {
      margin-top: 10px;
    }

    .result-card {
      background: #0f0f0f;
      border: 1px solid var(--border);
      border-radius: 14px;
      padding: 18px;
      margin-bottom: 14px;
      position: relative;
    }

    .result-card pre {
      white-space: pre-wrap;
      font-family: inherit;
      font-size: 15px;
      line-height: 1.6;
      margin-bottom: 12px;
    }

    .copy-btn {
      padding: 8px 16px;
      border-radius: 8px;
      border: none;
      background: #222;
      color: white;
      font-size: 13px;
      cursor: pointer;
      transition: background 0.2s;
    }

    .copy-btn:hover {
      background: #333;
    }

    /* Loader */
    .loader {
      display: none;
      text-align: center;
      padding: 30px;
      color: var(--muted);
    }

    .spinner {
      width: 28px;
      height: 28px;
      border: 3px solid #333;
      border-top-color: var(--primary);
      border-radius: 50%;
      animation: spin 0.8s linear infinite;
      margin: 0 auto 12px;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
    }

    /* History */
    .history {
      margin-top: 30px;
    }

    .history-title {
      font-size: 0.9rem;
      color: var(--muted);
      margin-bottom: 12px;
    }

    .history-item {
      padding: 10px 14px;
      background: #111;
      border-radius: 10px;
      font-size: 13px;
      color: #aaa;
      margin-bottom: 8px;
      cursor: pointer;
      border: 1px solid transparent;
    }

    .history-item:hover {
      border-color: var(--border);
      color: #ddd;
    }

    .hidden {
      display: none !important;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Header -->
    <header>
      <div class="logo">TikScript</div>
      <h1>Idées & Scripts TikTok</h1>
      <p class="subtitle">Génère des idées virales et des scripts en quelques secondes</p>
    </header>

    <!-- Generator Card -->
    <div class="card">
      <!-- Niche -->
      <div class="section-title">1. Choisis ta niche</div>
      <select id="nicheSelect">
        <option value="">-- Sélectionne une niche --</option>
        <option value="Finance personnelle">Finance personnelle / Argent</option>
        <option value="Développement personnel">Développement personnel</option>
        <option value="Fitness & Perte de poids">Fitness & Perte de poids</option>
        <option value="Entrepreneuriat">Entrepreneuriat / Side Hustle</option>
        <option value="Relations & Séduction">Relations & Séduction</option>
        <option value="Productivité">Productivité</option>
        <option value="Minimalisme">Mode de vie minimaliste</option>
        <option value="Cuisine">Cuisine rapide</option>
        <option value="Tech & IA">Tech & IA</option>
        <option value="Motivation">Motivation</option>
        <option value="Études">Études / Étudiants</option>
        <option value="Marketing digital">Marketing digital</option>
        <option value="Voyage">Voyage</option>
        <option value="Parenting">Parenting</option>
        <option value="Beauté">Beauté / Skincare</option>
        <option value="autre">Autre (personnalisée)</option>
      </select>

      <input type="text" id="customNiche" class="hidden" placeholder="Écris ta niche ici...">

      <!-- Type -->
      <div class="section-title" style="margin-top: 22px;">2. Que veux-tu générer ?</div>
      <div class="type-grid">
        <div class="type-btn active" data-type="idees">Idées de vidéos</div>
        <div class="type-btn" data-type="hooks">Hooks</div>
        <div class="type-btn" data-type="script">Script complet</div>
      </div>

      <!-- Options -->
      <div class="options">
        <div class="option-group">
          <label>Nombre</label>
          <select id="quantity">
            <option value="5">5</option>
            <option value="3">3</option>
            <option value="7">7</option>
          </select>
        </div>
        <div class="option-group">
          <label>Ton</label>
          <select id="tone">
            <option value="naturel">Naturel</option>
            <option value="provocant">Provocant</option>
            <option value="éducatif">Éducatif</option>
            <option value="humoristique">Humoristique</option>
          </select>
        </div>
      </div>

      <!-- Generate Button -->
      <button class="generate-btn" id="generateBtn" onclick="generate()">
        Générer
      </button>
    </div>

    <!-- Loader -->
    <div class="loader" id="loader">
      <div class="spinner"></div>
      <div>Génération en cours avec Claude...</div>
    </div>

    <!-- Results -->
    <div class="results" id="results"></div>

    <!-- History -->
    <div class="history" id="historySection">
      <div class="history-title">Historique récent</div>
      <div id="historyList"></div>
    </div>
  </div>

  <script>
    // ========== STATE ==========
    let selectedType = 'idees';
    let history = JSON.parse(localStorage.getItem('tikscript_history') || '[]');

    // ========== INIT ==========
    renderHistory();

    // Niche select
    document.getElementById('nicheSelect').addEventListener('change', function() {
      const custom = document.getElementById('customNiche');
      if (this.value === 'autre') {
        custom.classList.remove('hidden');
        custom.focus();
      } else {
        custom.classList.add('hidden');
      }
    });

    // Type buttons
    document.querySelectorAll('.type-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        document.querySelectorAll('.type-btn').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
        selectedType = this.dataset.type;

        // Cache le nombre si c'est un script
        const quantityGroup = document.querySelector('.option-group');
        if (selectedType === 'script') {
          quantityGroup.style.opacity = '0.4';
          quantityGroup.style.pointerEvents = 'none';
        } else {
          quantityGroup.style.opacity = '1';
          quantityGroup.style.pointerEvents = 'auto';
        }
      });
    });

    // ========== GENERATE ==========
    async function generate() {
      const nicheSelect = document.getElementById('nicheSelect').value;
      const customNiche = document.getElementById('customNiche').value.trim();
      const niche = nicheSelect === 'autre' ? customNiche : nicheSelect;
      const quantity = document.getElementById('quantity').value;
      const tone = document.getElementById('tone').value;

      if (!niche) {
        alert('Choisis ou écris une niche');
        return;
      }

      // Affiche loader
      document.getElementById('loader').style.display = 'block';
      document.getElementById('results').innerHTML = '';
      document.getElementById('generateBtn').disabled = true;

      // Ici tu brancheras Claude plus tard
      // Pour l'instant on simule
      setTimeout(() => {
        document.getElementById('loader').style.display = 'none';
        document.getElementById('generateBtn').disabled = false;

        // Résultat de démonstration
        showDemoResults(niche, selectedType, quantity, tone);

        // Sauvegarde historique
        addToHistory(niche, selectedType);
      }, 1500);
    }

    function showDemoResults(niche, type, quantity, tone) {
      const container = document.getElementById('results');
      let html = '';

      if (type === 'idees') {
        for (let i = 1; i <= quantity; i++) {
          html += `
            <div class="result-card">
              <pre><strong>Idée ${i} — ${niche}</strong>

Titre : Comment j'ai changé ma vie grâce à ça...
Description : Une vidéo qui montre une transformation ou un résultat concret.
Pourquoi ça marche : Les gens adorent les preuves et les résultats visibles.</pre>
              <button class="copy-btn" onclick="copyText(this)">Copier</button>
            </div>`;
        }
      }

      if (type === 'hooks') {
        for (let i = 1; i <= quantity; i++) {
          html += `
            <div class="result-card">
              <pre>Hook ${i} : "J'ai arrêté de faire ça pendant 30 jours... et voici ce qui s'est passé."</pre>
              <button class="copy-btn" onclick="copyText(this)">Copier</button>
            </div>`;
        }
      }

      if (type === 'script') {
        html += `
          <div class="result-card">
            <pre>J'ai arrêté d'économiser 200€ par mois... et j'ai enfin commencé à devenir riche.

Pendant des années je mettais de l'argent de côté comme tout le monde.
Mais mon argent ne travaillait pas.

Un jour j'ai compris une chose simple :
L'argent qu'on met sous le matelas perd de la valeur.

Depuis que j'ai commencé à l'investir intelligemment, tout a changé.

Si tu veux que je te montre exactement comment j'ai fait, commente "MOI".</pre>
            <button class="copy-btn" onclick="copyText(this)">Copier</button>
          </div>`;
      }

      container.innerHTML = html;
    }

    // ========== UTILS ==========
    function copyText(btn) {
      const text = btn.parentElement.querySelector('pre').innerText;
      navigator.clipboard.writeText(text).then(() => {
        btn.textContent = 'Copié !';
        setTimeout(() => btn.textContent = 'Copier', 2000);
      });
    }

    function addToHistory(niche, type) {
      const entry = `${type.toUpperCase()} — ${niche}`;
      history.unshift(entry);
      if (history.length > 8) history.pop();
      localStorage.setItem('tikscript_history', JSON.stringify(history));
      renderHistory();
    }

    function renderHistory() {
      const list = document.getElementById('historyList');
      if (history.length === 0) {
        list.innerHTML = '<div style="color:#555;font-size:13px">Aucune génération pour le moment</div>';
        return;
      }
      list.innerHTML = history.map(h => `<div class="history-item">${h}</div>`).join('');
    }
  </script>
</body>
</html>