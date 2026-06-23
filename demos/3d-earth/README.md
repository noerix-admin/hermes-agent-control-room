# 🌍 Interaktives 3D-Erdmodell

Ein bewegliches 3D-Modell der Erde, das die wichtigsten Begriffe des geografischen
Koordinatensystems anschaulich und mit Beispielen erklärt:

- **Äquator** – der größte Kreis, Breite 0° (Beispiel: Quito)
- **Meridian** – ein Halbkreis von Pol zu Pol (Beispiel: Nord-/Südpol)
- **Nullmeridian** – Länge 0° durch Greenwich
- **Breitengrad** – Parallelkreise zum Äquator (Beispiel: Berlin 52,5° N)
- **Längengrad** – Linien von Pol zu Pol (Beispiel: Berlin 13,4° O)

## Bedienung

- **Drehen:** mit der Maus ziehen (oder Finger wischen)
- **Zoomen:** Mausrad / Pinch-Geste
- **Begriff wählen:** rechts im Panel anklicken – das Modell hebt die passenden
  Linien farbig hervor und blendet einen Erklärtext mit Beispiel ein
- **Ansicht:** Auto-Rotation, Gradnetz ein/aus und Ansicht zurücksetzen

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
