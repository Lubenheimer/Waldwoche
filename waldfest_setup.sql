-- ════════════════════════════════════════════════════════════════
--  Waldwoche 2026 – Waldfest Helferliste (zusätzliches SQL)
--  Im Supabase SQL-Editor ausführen (einmalig, zusätzlich zu setup.sql)
-- ════════════════════════════════════════════════════════════════

-- 1. Aufgaben-Tabelle (Admin trägt To-Dos ein)
CREATE TABLE waldfest_aufgaben (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    titel        TEXT NOT NULL,
    beschreibung TEXT,
    max_helfer   INT NOT NULL DEFAULT 3,
    created_at   TIMESTAMPTZ DEFAULT now()
);

-- 2. Helfer-Tabelle (Eltern tragen sich ein)
CREATE TABLE waldfest_helfer (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    aufgabe_id UUID NOT NULL REFERENCES waldfest_aufgaben(id) ON DELETE CASCADE,
    name       TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- ────────────────────────────────────────────────────────────────
--  Row Level Security
-- ────────────────────────────────────────────────────────────────
ALTER TABLE waldfest_aufgaben ENABLE ROW LEVEL SECURITY;
ALTER TABLE waldfest_helfer   ENABLE ROW LEVEL SECURITY;

-- Lesen: alle
CREATE POLICY "public read waldfest_aufgaben" ON waldfest_aufgaben FOR SELECT USING (true);
CREATE POLICY "public read waldfest_helfer"   ON waldfest_helfer   FOR SELECT USING (true);

-- Schreiben: alle
CREATE POLICY "public insert waldfest_aufgaben" ON waldfest_aufgaben FOR INSERT WITH CHECK (true);
CREATE POLICY "public insert waldfest_helfer"   ON waldfest_helfer   FOR INSERT WITH CHECK (true);

-- Löschen: alle (Schutz durch Admin-Passwort im Frontend)
CREATE POLICY "public delete waldfest_aufgaben" ON waldfest_aufgaben FOR DELETE USING (true);
CREATE POLICY "public delete waldfest_helfer"   ON waldfest_helfer   FOR DELETE USING (true);
