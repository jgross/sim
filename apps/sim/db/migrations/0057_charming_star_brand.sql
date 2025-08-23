ALTER TABLE "sim_workflow_schedule" DROP CONSTRAINT "sim_workflow_schedule_workflow_id_unique";--> statement-breakpoint
ALTER TABLE "sim_webhook" ADD COLUMN "block_id" text;--> statement-breakpoint
ALTER TABLE "sim_workflow_schedule" ADD COLUMN "block_id" text;--> statement-breakpoint
ALTER TABLE "sim_webhook" ADD CONSTRAINT "sim_webhook_block_id_workflow_blocks_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."sim_workflow_blocks"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_workflow_schedule" ADD CONSTRAINT "sim_workflow_schedule_block_id_workflow_blocks_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."sim_workflow_blocks"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE UNIQUE INDEX "sim_workflow_schedule_workflow_block_unique" ON "sim_workflow_schedule" USING btree ("workflow_id","block_id");