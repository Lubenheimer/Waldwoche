-- ════════════════════════════════════════════════════════════════
--  Waldwoche 2026 – Supabase Setup SQL
--  Dieses Skript im Supabase SQL-Editor ausführen (einmalig)
-- ════════════════════════════════════════════════════════════════

-- 1. Essensbringdienst
CREATE TABLE essensbringdienst (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    datum      TEXT NOT NULL,
    name       TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Feuerholz
CREATE TABLE feuerholz (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    datum      TEXT NOT NULL,
    name       TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Fahrgemeinschaften
CREATE TABLE fahrgemeinschaften (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    typ        TEXT NOT NULL CHECK (typ IN ('suche', 'biete')),
    name       TEXT NOT NULL,
    gruppe     TEXT NOT NULL,
    telefon    TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 4. Kuchenliste
CREATE TABLE kuchenliste (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       TEXT NOT NULL,
    kuchenart  TEXT NOT NULL,
    datum      TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. Änderungsprotokoll
CREATE TABLE change_log (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tabelle       TEXT NOT NULL,
    zeile_id      UUID,
    aktion        TEXT NOT NULL CHECK (aktion IN ('eintrag', 'loeschung')),
    alter_wert    JSONB,
    neuer_wert    JSONB,
    geaendert_von TEXT,
    zeitstempel   TIMESTAMPTZ DEFAULT now()
);

-- ────────────────────────────────────────────────────────────────
--  Row Level Security – alle Tabellen öffentlich lese- und schreibbar
--  (kein Login erforderlich für Eltern)
-- ────────────────────────────────────────────────────────────────

ALTER TABLE essensbringdienst  ENABLE ROW LEVEL SECURITY;
ALTER TABLE feuerholz          ENABLE ROW LEVEL SECURITY;
ALTER TABLE fahrgemeinschaften ENABLE ROW LEVEL SECURITY;
ALTER TABLE kuchenliste        ENABLE ROW LEVEL SECURITY;
ALTER TABLE change_log         ENABLE ROW LEVEL SECURITY;

-- Lesen: alle dürfen alles lesen
CREATE POLICY "public read essensbringdienst"  ON essensbringdienst  FOR SELECT USING (true);
CREATE POLICY "public read feuerholz"          ON feuerholz          FOR SELECT USING (true);
CREATE POLICY "public read fahrgemeinschaften" ON fahrgemeinschaften FOR SELECT USING (true);
CREATE POLICY "public read kuchenliste"        ON kuchenliste        FOR SELECT USING (true);
CREATE POLICY "public read change_log"         ON change_log         FOR SELECT USING (true);

-- Schreiben: alle dürfen Einträge hinzufügen
CREATE POLICY "public insert essensbringdienst"  ON essensbringdienst  FOR INSERT WITH CHECK (true);
CREATE POLICY "public insert feuerholz"          ON feuerholz          FOR INSERT WITH CHECK (true);
CREATE POLICY "public insert fahrgemeinschaften" ON fahrgemeinschaften FOR INSERT WITH CHECK (true);
CREATE POLICY "public insert kuchenliste"        ON kuchenliste        FOR INSERT WITH CHECK (true);
CREATE POLICY "public insert change_log"         ON change_log         FOR INSERT WITH CHECK (true);

-- Löschen: alle dürfen löschen (Schutz erfolgt durch Admin-Passwort im Frontend)
CREATE POLICY "public delete essensbringdienst"  ON essensbringdienst  FOR DELETE USING (true);
CREATE POLICY "public delete feuerholz"          ON feuerholz          FOR DELETE USING (true);
CREATE POLICY "public delete fahrgemeinschaften" ON fahrgemeinschaften FOR DELETE USING (true);
CREATE POLICY "public delete kuchenliste"        ON kuchenliste        FOR DELETE USING (true);
