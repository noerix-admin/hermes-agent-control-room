# 🌍 Interaktives 3D-Erdmodell

Ein bewegliches 3D-Modell der Erde, das die wichtigsten Begriffe des geografischen
Koordinatensystems anschaulich und mit Beispielen erklärt:

- **Äquator** – der größte Kreis, Breite 0° (Beispiel: Quito)
- **Meridian** – ein Halbkreis von Pol zu Pol (Beispiel: Nord-/Südpol)
- **Nullmeridian** – Länge 0° durch Greenwich
- **Breitengrad** – Parallelkreise zum Äquator (Beispiel: Berlin 52,5° N)
- **Längengrad** – Linien von Pol zu Pol (Beispiel: Berlin 13,4° O)
- **Wende- & Polarkreise** – ±23,5° und ±66,5° (Sonnenwende, Mitternachtssonne, Polarnacht)

Dazu (Niveau 5. Klasse Realschule Geografie):

- **Authentische Erde** mit echter Satellitentextur, glänzenden Ozeanen und Wolken
- **Pole** mit Kurzinfo, **Kontinente** mit Steckbrief beim Mouseover
- **Live-Koordinaten** am Mauszeiger (Breite/Länge)
- **Länder**: werden mit ihrer **echten Grenze** gezeichnet (Geodaten vom CDN).
  Mit der Maus darüberfahren hebt das Land farbig hervor und zeichnet den Umriss
  nach; ein Klick zeigt Infos + **echtes Foto** (Wikipedia).
- **Städte**: zeigen ihre (ungefähre) **Stadtgrenze**; Klick zeigt Infos + Foto.
- **Einzelobjekte** als Punkte: Nil (Flusslauf), Himalaya (Gebirge),
  Mount Everest (Gipfel) – Klick hebt sie hervor und erklärt sie.
- **Kontinente** mit Umriss + Steckbrief
- **Städte**: wichtige Großstädte inkl. der wichtigsten Stadt je Land
  (Berlin, Paris, London, Rom, Moskau, Peking, Kairo, …)
- **Weitere Ebenen** (ein-/ausblendbar): die **7 Weltwunder der Antike**, **Welterbe** (UNESCO),
  **Wüsten** und **Meere/Ozeane** (Info & Foto). **Flüsse** werden blau, **Gebirge** braun
  direkt auf der Karte gezeichnet; fährt man über ein Gebirge, ragt es als 3D-Gipfelkette heraus.
- Kontinent-Namen erscheinen nur, wenn der Kontinent zur Kamera zeigt
  (verschwinden beim Drehen auf der Rückseite); Ländergrenzen zeigen die Außengrenzen.
- **Greenwich**: Mouseover erklärt den Nullmeridian
- **Erdschichten-Querschnitt** („🍰 Erdschichten"): ein Tortenstück wird entfernt
  und man sieht Kruste, Mantel, äußeren und inneren Erdkern mit Kurzdaten
- **Quiz** („❓ Quiz"): Multiple-Choice rund um die Erde (Niveau Realschule
  Bayern, 5. Klasse), mit Punkten und Auswertung
- **VR-tauglich (WebXR)**: Auf einem VR-Headset erscheint ein „VR betreten"-Button;
  der Globus ist dann in 3D begehbar (die 2D-Bedienpanels bleiben am Bildschirm)
- **Mystische Hintergrundmusik**: echtes Stück (`music.mp3`, CC BY 4.0,
  Kevin MacLeod). Fehlt die Datei, spielt automatisch ein generativer Klang.
  Start über den Button **🎵 Musik** (Browser erlauben Ton erst nach einem Klick).

> Hinweis: Umrisse (Ländergrenzen) und Fotos werden online nachgeladen
> (jsDelivr bzw. Wikipedia). Ohne Internet erscheinen stattdessen ein Markierungsring
> und kein Foto – der Rest funktioniert offline.

## Bedienung

- **Drehen:** mit der Maus ziehen (oder Finger wischen)
- **Zoomen:** Mausrad / Pinch-Geste
- **Begriff wählen:** rechts im Panel anklicken – das Modell hebt die passenden
  Linien farbig hervor und blendet einen Erklärtext mit Beispiel ein
- **Über die Erde fahren:** zeigt laufend Breiten-/Längengrad am Mauszeiger
- **Punkte anklicken:** hebt Fluss/Gebirge/Berg bzw. Land hervor und zeigt eine Info-Karte
- **Ansicht:** Auto-Rotation, Gradnetz, Tag & Nacht, Wolken, Kontinente, Länder,
  Städte, Orte, Musik, Ansicht zurücksetzen

## Starten

Die Anwendung ist eine einzige, in sich geschlossene HTML-Datei. Einfach im Browser öffnen:

```bash
# direkt öffnen
xdg-open demos/3d-earth/index.html      # Linux
open demos/3d-earth/index.html          # macOS

# oder über einen lokalen Server
cd demos/3d-earth && python3 -m http.server 8000
# dann http://localhost:8000 aufrufen
```

## Technik

- [Three.js](https://threejs.org/) (über CDN/Importmap geladen) für die 3D-Darstellung
- `OrbitControls` zum Drehen und Zoomen
- Das Gradnetz (Breiten-/Längengrade) wird prozedural als Linien­geometrie erzeugt
- Die Erdtextur wird offline-tauglich auf einer Canvas gezeichnet; bei vorhandener
  Internet­verbindung wird zusätzlich eine echte Satelliten­textur nachgeladen

> Keine Build-Schritte, keine Abhängigkeiten zum Installieren – nur eine HTML-Datei.

## Live-Entwicklung (Auto-Update vom Branch)

Loop für gemeinsames Arbeiten: Änderungen werden auf den Branch
`claude/3d-earth-interactive-model-vx3d98` gepusht, dein PC zieht sie
automatisch, du lädst nur den Browser neu (F5).

**Einmal einrichten** (Repo klonen, Branch auschecken):

```bash
git clone https://github.com/noerix-admin/hermes-agent-control-room.git
cd hermes-agent-control-room
git checkout claude/3d-earth-interactive-model-vx3d98
```

**Bei jeder Session starten** (auto-pull + lokaler Server in einem):

```bash
cd demos/3d-earth
./dev.sh                 # Linux / macOS  → http://localhost:8000
```

Unter **Windows** (PowerShell) als Einzeiler:

```powershell
cd demos\3d-earth
python -m http.server 8000
# in zweitem Fenster für Auto-Pull:
while ($true) { git pull --ff-only origin claude/3d-earth-interactive-model-vx3d98; Start-Sleep 20 }
```

Danach `http://localhost:8000` öffnen. Nach jeder gepushten Änderung genügt **F5**.

> Wichtig: Die Seite muss über `http://localhost` laufen, **nicht** per Doppelklick
> (`file://`) – Browser blockieren dort die ES-Module (CORS).
