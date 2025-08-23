CREATE TABLE "sim_workflow_logs" (
	"id" text PRIMARY KEY NOT NULL,
	"workflow_id" text NOT NULL,
	"execution_id" text,
	"level" text NOT NULL,
	"message" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sim_settings" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"general" json NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "sim_settings_user_id_unique" UNIQUE("user_id")
);
--> statement-breakpoint
CREATE TABLE "sim_environment" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"variables" json NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "sim_environment_user_id_unique" UNIQUE("user_id")
);
--> statement-breakpoint
ALTER TABLE "sim_logs" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "sim_user_environment" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "sim_user_settings" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
DROP TABLE "sim_logs" CASCADE;--> statement-breakpoint
DROP TABLE "sim_user_environment" CASCADE;--> statement-breakpoint
DROP TABLE "sim_user_settings" CASCADE;--> statement-breakpoint
ALTER TABLE "sim_workflow" ALTER COLUMN "state" SET DATA TYPE json USING state::json;--> statement-breakpoint
ALTER TABLE "sim_workflow_logs" ADD CONSTRAINT "sim_workflow_logs_workflow_id_workflow_id_fk" FOREIGN KEY ("workflow_id") REFERENCES "public"."sim_workflow"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_settings" ADD CONSTRAINT "sim_settings_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_environment" ADD CONSTRAINT "sim_environment_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;