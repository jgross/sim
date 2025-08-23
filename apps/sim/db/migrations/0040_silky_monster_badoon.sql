-- Add enabled field to embedding table
ALTER TABLE "sim_embedding" ADD COLUMN IF NOT EXISTS "enabled" boolean DEFAULT true NOT NULL;

-- Composite index for knowledge base + enabled chunks (for search optimization)
CREATE INDEX IF NOT EXISTS "emb_kb_enabled_idx" ON "sim_embedding" USING btree ("knowledge_base_id", "enabled");

-- Composite index for document + enabled chunks (for document chunk listings)
CREATE INDEX IF NOT EXISTS "emb_doc_enabled_idx" ON "sim_embedding" USING btree ("document_id", "enabled"); 