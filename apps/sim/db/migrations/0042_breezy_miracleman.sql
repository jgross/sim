CREATE TABLE "sim_workflow_folder" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"user_id" text NOT NULL,
	"workspace_id" text NOT NULL,
	"parent_id" text,
	"color" text DEFAULT '#6B7280',
	"is_expanded" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "sim_workflow" ADD COLUMN "folder_id" text;--> statement-breakpoint
ALTER TABLE "sim_workflow_folder" ADD CONSTRAINT "sim_workflow_folder_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_workflow_folder" ADD CONSTRAINT "sim_workflow_folder_workspace_id_workspace_id_fk" FOREIGN KEY ("workspace_id") REFERENCES "public"."sim_workspace"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_workflow_folder" ADD CONSTRAINT "sim_workflow_folder_parent_id_workflow_folder_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."sim_workflow_folder"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "sim_workflow_folder_workspace_parent_idx" ON "sim_workflow_folder" USING btree ("workspace_id","parent_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_folder_user_idx" ON "sim_workflow_folder" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "sim_workflow_folder_parent_sort_idx" ON "sim_workflow_folder" USING btree ("parent_id","sort_order");--> statement-breakpoint
ALTER TABLE "sim_workflow" ADD CONSTRAINT "sim_workflow_folder_id_workflow_folder_id_fk" FOREIGN KEY ("folder_id") REFERENCES "public"."sim_workflow_folder"("id") ON DELETE set null ON UPDATE no action;