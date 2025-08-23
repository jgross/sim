ALTER TABLE "sim_knowledge_base" DROP CONSTRAINT "sim_knowledge_base_workspace_id_workspace_id_fk";
--> statement-breakpoint
ALTER TABLE "sim_knowledge_base" ADD CONSTRAINT "sim_knowledge_base_workspace_id_workspace_id_fk" FOREIGN KEY ("workspace_id") REFERENCES "public"."sim_workspace"("id") ON DELETE no action ON UPDATE no action;