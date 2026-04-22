-- ════════════════════════════════════════════════════════════════
--  Waldwoche 2026 – Waldfest Kuchenliste (zusätzliches SQL)
--  Im Supabase SQL-Editor ausführen (einmalig)
-- ════════════════════════════════════════════════════════════════

CREATE TABLE waldfest_kuchen (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       TEXT NOT NULL,
    kuchenart  TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE waldfest_kuchen ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public read waldfest_kuchen"   ON waldfest_kuchen FOR SELECT USING (true);
CREATE POLICY "public insert waldfest_kuchen" ON waldfest_kuchen FOR INSERT WITH CHECK (true);
CREATE POLICY "public delete waldfest_kuchen" ON waldfest_kuchen FOR DELETE USING (true);
