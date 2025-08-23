CREATE TABLE "sim_workflow_checkpoints" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"workflow_id" text NOT NULL,
	"sim_chat_id" uuid NOT NULL,
	"message_id" text,
	"sim_workflow_state" json NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
DROP TABLE "sim_copilot_checkpoints" CASCADE;--> statement-breakpoint
ALTER TABLE "sim_copilot_chats" ADD COLUMN "preview_yaml" text;--> statement-breakpoint
ALTER TABLE "sim_workflow_checkpoints" ADD CONSTRAINT "sim_workflow_checkpoints_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_workflow_checkpoints" ADD CONSTRAINT "sim_workflow_checkpoints_workflow_id_workflow_id_fk" FOREIGN KEY ("workflow_id") REFERENCES "public"."sim_workflow"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_workflow_checkpoints" ADD CONSTRAINT "sim_workflow_checkpoints_chat_id_copilot_chats_id_fk" FOREIGN KEY ("sim_chat_id") REFERENCES "public"."sim_copilot_chats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_user_id_idx" ON "sim_workflow_checkpoints" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_workflow_id_idx" ON "sim_workflow_checkpoints" USING btree ("workflow_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_chat_id_idx" ON "sim_workflow_checkpoints" USING btree ("sim_chat_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_message_id_idx" ON "sim_workflow_checkpoints" USING btree ("message_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_user_workflow_idx" ON "sim_workflow_checkpoints" USING btree ("user_id","workflow_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_workflow_chat_idx" ON "sim_workflow_checkpoints" USING btree ("workflow_id","sim_chat_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_created_at_idx" ON "sim_workflow_checkpoints" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "sim_workflow_checkpoints_chat_created_at_idx" ON "sim_workflow_checkpoints" USING btree ("sim_chat_id","created_at");