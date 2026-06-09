# 2ndBrain Merge – Ablaufdokument

Phasen-Ablauf, um die drei Sichten auf das 2ndBrain –
**Obsidian-Vault-Layout**, **GitHub-Repo-Layout** und **NAS-Layout** –
zusammenzuführen, daraus ein **kanonisches Soll** abzuleiten und dieses
gegen den **Ist-Zustand** abzugleichen.

> Status: Entwurf · Stand: 2026-06-09 · Branch: `claude/2ndbrain-merge-process`

## Abgrenzung (zuerst lesen)

- Dieses Dokument behandelt **ausschließlich den 2ndBrain-Merge**
  (Vault / Repo / NAS → kanonisches Soll → Soll-Ist-Abgleich).
- Es ist **nicht** der **noerix-os-Merge (OS-v2.6)**. Falls Schritte hier mit
  dem OS-v2.6-Merge kollidieren, hat der OS-v2.6-Merge Vorrang und wird in einem
  eigenen Dokument geführt. Die beiden Merges bleiben getrennt – aber **dort, wo
  sie sich berühren, wird die Berührung benannt und nicht still aufgelöst**
  (siehe Abschnitt „Berührungspunkte zum noerix-os-Merge").
- **Anlass:** Der aktuelle **Ssc-Vault auf dem Handy** weicht vom
  **Vier-Vault-Plan** ab. Diese Drift ist der Auslöser und gleichzeitig der
  erste konkrete Abgleichfall (siehe Phase 4).

## Berührungspunkte zum noerix-os-Merge (OS-v2.6)

Beide Merges bleiben eigenständig, teilen sich aber Substrat. Wo ein 2ndBrain-
Schritt eine OS-v2.6-Entscheidung voraussetzt oder beeinflusst, wird das hier
markiert, statt es im 2ndBrain-Merge eigenmächtig festzulegen.

Regel für Berührungspunkte:

```text
1. Erkennen statt auflösen. Berührt ein Schritt den OS-v2.6-Merge, wird er
   im Interface-Log (unten) eingetragen, nicht still entschieden.
2. OS-v2.6 hat Vorrang. Steht eine OS-v2.6-Entscheidung noch aus, wartet der
   abhängige 2ndBrain-Schritt oder nutzt einen klar markierten Platzhalter.
3. Keine Doppelwahrheit. Gemeinsame Artefakte (Pfade, Namen, NAS-Shares,
   Sync/Secrets) werden nur an einer Stelle kanonisch definiert; die andere
   Sicht referenziert sie.
```

Wahrscheinliche Berührungspunkte (prüfen und im Log führen):

| Bereich | Mögliche Berührung mit OS-v2.6 | Wer ist führend |
|---------|--------------------------------|-----------------|
| GitHub-Repo-Layout | 2ndBrain-Repo liegt in/neben der noerix-os-Repostruktur | i. d. R. OS-v2.6 |
| NAS-Layout | gemeinsame Shares, Snapshot-/Backup-Mechanik, Pfadschema | i. d. R. OS-v2.6 |
| Namenskonvention | gemeinsamer Slug-/Namensstandard über Systeme hinweg | gemeinsam, OS-v2.6 setzt Rahmen |
| Geräte-/Sync-Topologie | welche Geräte (inkl. Handy/Ssc) wie synchronisieren | OS-v2.6 (Geräteebene) |
| Sync/Secrets | geteilte Sync-Keys/Tokens (nur als Name/Ort dokumentiert) | OS-v2.6 |
| Reihenfolge | OS-v2.6 verschiebt Pfade/Repos -> 2ndBrain-Merge muss nachziehen | OS-v2.6 (Timing) |

Interface-Log (fortlaufend führen):

```text
Datum | Berührungspunkt | OS-v2.6-Status | 2ndBrain-Abhängigkeit | Auflösung
------+-----------------+----------------+-----------------------+----------
      |                 | offen/geklärt  |                       |
```

## Grundregeln

```text
1. Read-only zuerst. Keine Quelle wird verändert, bevor das Ist erfasst
   und ein Backup vorhanden ist.
2. Backup-vor-Merge. Vor jedem schreibenden Schritt eine wiederherstellbare
   Kopie (Vault-Export, Repo-Tag, NAS-Snapshot).
3. Eine Quelle der Wahrheit. Nach dem Merge gilt genau ein kanonisches Soll;
   alle anderen Sichten leiten sich davon ab.
4. Keine Geheimnisse. Tokens, Sync-Keys und Passwörter werden nur als
   Name/Ort/Zweck dokumentiert, nie im Klartext.
5. Entscheidungen werden protokolliert (Decision Log, Phase 4).
```

## Quellen und ihre Rollen

```text
Obsidian-Vault-Layout   Arbeits- und Lesesicht (inkl. Ssc-Vault am Handy)
GitHub-Repo-Layout      Versions-, Review- und Verteil-Sicht
NAS-Layout              Speicher-, Backup- und Langzeit-Sicht
Vier-Vault-Plan         angestrebtes Zielmodell (Grundlage des kanonischen Solls)
```

---

## Phase 0 – Setup & Scope-Fixierung

Ziel: gemeinsame Begriffe, Werkzeuge und Sicherheitsnetz.

```text
[ ] Abgrenzung gegen OS-v2.6-Merge bestätigt und notiert.
[ ] Vier-Vault-Plan als Referenzdokument lokalisiert und verlinkt
    (Quelle/Version eintragen): __________________________
[ ] Arbeitsverzeichnis/Branch festgelegt (dieses Dokument).
[ ] Begriffe geklärt: was zählt als "Vault", "Repo", "NAS-Share".
```

Ergebnis: Scope, Referenzen und Vokabular stehen fest.

---

## Phase 1 – Ist-Inventur (read-only)

Ziel: jede der drei Quellen unverändert erfassen. Nichts verschieben.

```text
[ ] Obsidian: alle Vaults auflisten (Name, Pfad/Gerät, Sync-Methode,
    ungefährer Umfang). Den Ssc-Vault am Handy ausdrücklich mit erfassen.
[ ] GitHub: relevante Repos/Verzeichnisse auflisten (Name, Branch, Zweck).
[ ] NAS: Share-/Ordner-Layout auflisten (Pfad, Zweck, Backup-Status).
[ ] Berührungspunkte markieren: Quellen, die zugleich vom noerix-os-Merge
    (OS-v2.6) angefasst werden, im Interface-Log eintragen.
```

Inventur-Tabelle (pro Quelle ausfüllen):

| Quelle | Einheit (Vault/Repo/Share) | Pfad / Gerät | Zweck | Sync/Backup | Umfang |
|--------|----------------------------|--------------|-------|-------------|--------|
| Obsidian | Ssc-Vault | Handy | … | … | … |
| Obsidian | … | … | … | … | … |
| GitHub | … | … | … | … | … |
| NAS | … | … | … | … | … |

Ergebnis: vollständiges, eingefrorenes Ist-Bild aller drei Sichten.

---

## Phase 2 – Backup & Snapshot

Ziel: jeder schreibende Schritt ab Phase 5 ist rückholbar.

```text
[ ] Obsidian: Export/Kopie jedes Vaults (inkl. Ssc-Vault am Handy).
[ ] GitHub: Tag/Branch als Wiederherstellungspunkt
    (z. B. tag: pre-2ndbrain-merge).
[ ] NAS: Snapshot oder Kopie der betroffenen Shares.
[ ] Wiederherstellungspunkte notiert (wo, wann, wie zurückrollen).
```

Ergebnis: definierte Rollback-Punkte für alle drei Quellen.

---

## Phase 3 – Kanonisches Soll ableiten

Ziel: ein einziges Ziel-Layout, das Vault, Repo und NAS gemeinsam abbildet,
auf Basis des Vier-Vault-Plans.

```text
[ ] Vier-Vault-Plan in vier benannte Vaults überführen (Namen/Zweck eintragen):
    1. __________   2. __________   3. __________   4. __________
[ ] Für jeden der vier Vaults festlegen:
      - Obsidian-Pfad/Geräte (welche Geräte synchronisieren ihn)
      - GitHub-Abbildung (Repo/Unterordner, ja/nein)
      - NAS-Ort (Share/Pfad, Backup-Strategie)
[ ] Namenskonvention festlegen (ein stabiler Slug pro Vault über alle Sichten,
    analog docs/naming.md). Falls OS-v2.6 einen Namens-/Pfadrahmen vorgibt,
    diesen übernehmen statt einen eigenen zu erfinden (Interface-Log).
[ ] Mapping-Tabelle Soll erstellen.
```

Soll-Mapping (Zielzustand):

| Vault (Soll) | Slug | Obsidian-Geräte | GitHub | NAS-Pfad | Backup |
|--------------|------|-----------------|--------|----------|--------|
| Vault 1 | … | … | … | … | … |
| Vault 2 | … | … | … | … | … |
| Vault 3 | … | … | … | … | … |
| Vault 4 | … | … | … | … | … |

Ergebnis: kanonisches Soll als ein konsistentes Vier-Vault-Mapping über alle
drei Sichten.

---

## Phase 4 – Soll-Ist-Abgleich (Gap-/Drift-Analyse)

Ziel: jede Abweichung zwischen Ist (Phase 1) und Soll (Phase 3) benennen und
entscheiden. Der Ssc-Vault-Drift am Handy ist der erste Eintrag.

Drift-Matrix:

| Fund (Ist) | Soll | Abweichungstyp | Entscheidung | Aktion in Phase 5 |
|------------|------|----------------|--------------|-------------------|
| Ssc-Vault am Handy weicht vom Vier-Vault-Plan ab | … | umbenennen / aufteilen / mergen | … | … |
| … | … | fehlt / doppelt / falscher Ort / Namens­drift | … | … |

Konfliktregeln:

```text
- Inhaltskonflikt (gleiche Notiz, verschiedene Stände):
    neuere/­vollständigere Version gewinnt; Verlierer-Version als Kopie sichern.
- Ortskonflikt (Notiz in falschem Vault): nach Soll verschieben,
    Quelle leeren.
- Namensdrift (Ssc-Vault vs. Plan-Name): auf Soll-Slug umbenennen,
    alle drei Sichten nachziehen.
- Unklar: nicht raten -> als offene Frage markieren und vor Phase 5 klären.
```

Decision Log (fortlaufend führen):

```text
Datum | Konflikt | Entscheidung | Begründung | betroffene Sichten
------+----------+--------------+------------+-------------------
      |          |              |            |
```

Ergebnis: vollständige, entschiedene Liste aller Abweichungen.

---

## Phase 5 – Durchführung (Merge/Migration)

Ziel: Ist gemäß den Entscheidungen aus Phase 4 in das Soll überführen.
Erst nach erfolgreichem Backup (Phase 2).

```text
[ ] Interface-Log prüfen: offene OS-v2.6-Berührungspunkte blockieren die
    betroffenen Schritte, bis OS-v2.6 entschieden hat (OS-v2.6 hat Vorrang).
[ ] Trockenlauf: Aktionen ohne Schreiben durchgehen, Reihenfolge prüfen.
[ ] Eine Quelle als Leitsicht migrieren (Empfehlung: zuerst NAS als
    stabiler Speicher, dann GitHub, dann Obsidian-Geräte angleichen).
[ ] Ssc-Vault am Handy auf Soll-Vault umstellen (umbenennen/aufteilen
    gemäß Drift-Matrix), danach Sync neu verbinden.
[ ] Jede Aktion gegen das Decision Log abhaken.
[ ] Keine Quelle halb migriert zurücklassen.
```

Ergebnis: alle drei Sichten entsprechen dem kanonischen Soll.

---

## Phase 6 – Verifikation & Re-Sync

Ziel: bestätigen, dass Soll erreicht ist und die Geräte sauber synchronisieren.

```text
[ ] Soll-Mapping (Phase 3) gegen den neuen Ist-Zustand erneut prüfen
    -> Drift-Matrix muss leer/erledigt sein.
[ ] Ssc-Vault am Handy: Sync läuft, Inhalt entspricht dem Soll-Vault.
[ ] GitHub: Stand committet, NAS-Backup des neuen Zustands erstellt.
[ ] Stichproben: ausgewählte Notizen in allen drei Sichten identisch.
```

Ergebnis: verifizierter, konsistenter Zustand über Obsidian, GitHub und NAS.

---

## Phase 7 – Abschluss & Governance

Ziel: den neuen Zustand als kanonisch festschreiben und künftige Drift
früh erkennen.

```text
[ ] Kanonisches Soll-Mapping als verbindliche Referenz markieren
    (dieses Dokument aktualisieren, Status: Final).
[ ] Backups/Tags aus Phase 2 erst nach erfolgreicher Verifikation aufräumen.
[ ] Wiederkehrende Drift-Kontrolle festlegen (z. B. periodischer Abgleich
    Ssc-Vault <-> Soll).
[ ] Restpunkte/offene Fragen aus Phase 4 schließen oder als Folge-Aufgabe
    notieren.
```

Ergebnis: ein dokumentiertes, gepflegtes 2ndBrain mit einer Quelle der Wahrheit.

---

## Offene Punkte (vom Auftraggeber zu ergänzen)

```text
[ ] Vier-Vault-Plan: Quelle/Version + die vier Vault-Namen.
[ ] Vollständige Liste der Obsidian-Vaults und Sync-Geräte.
[ ] GitHub-Repo(s)/Unterordner des 2ndBrain.
[ ] NAS-Share-/Ordnerstruktur des 2ndBrain.
[ ] Konkrete Soll-Vorgabe für den Ssc-Vault am Handy.
[ ] Stand des noerix-os-Merges (OS-v2.6) und welche Berührungspunkte daraus
    bereits feststehen bzw. noch offen sind.
```
