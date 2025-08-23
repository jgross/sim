CREATE TABLE "sim_copilot_feedback" (
	"feedback_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"sim_chat_id" uuid NOT NULL,
	"sim_user_query" text NOT NULL,
	"agent_response" text NOT NULL,
	"is_positive" boolean NOT NULL,
	"feedback" text,
	"sim_workflow_yaml" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "sim_user_stats" ALTER COLUMN "current_usage_limit" SET DEFAULT '10';--> statement-breakpoint
ALTER TABLE "sim_copilot_feedback" ADD CONSTRAINT "sim_copilot_feedback_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_copilot_feedback" ADD CONSTRAINT "sim_copilot_feedback_chat_id_copilot_chats_id_fk" FOREIGN KEY ("sim_chat_id") REFERENCES "public"."sim_copilot_chats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "sim_copilot_feedback_user_id_idx" ON "sim_copilot_feedback" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "sim_copilot_feedback_chat_id_idx" ON "sim_copilot_feedback" USING btree ("sim_chat_id");--> statement-breakpoint
CREATE INDEX "sim_copilot_feedback_user_chat_idx" ON "sim_copilot_feedback" USING btree ("user_id","sim_chat_id");--> statement-breakpoint
CREATE INDEX "sim_copilot_feedback_is_positive_idx" ON "sim_copilot_feedback" USING btree ("is_positive");--> statement-breakpoint
CREATE INDEX "sim_copilot_feedback_created_at_idx" ON "sim_copilot_feedback" USING btree ("created_at");