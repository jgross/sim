CREATE TABLE "sim_workspace" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"owner_id" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sim_workspace_member" (
	"id" text PRIMARY KEY NOT NULL,
	"workspace_id" text NOT NULL,
	"user_id" text NOT NULL,
	"role" text DEFAULT 'member' NOT NULL,
	"joined_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "sim_workflow" ADD COLUMN "workspace_id" text;--> statement-breakpoint
ALTER TABLE "sim_workspace" ADD CONSTRAINT "sim_workspace_owner_id_user_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_workspace_member" ADD CONSTRAINT "sim_workspace_member_workspace_id_workspace_id_fk" FOREIGN KEY ("workspace_id") REFERENCES "public"."sim_workspace"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_workspace_member" ADD CONSTRAINT "sim_workspace_member_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE UNIQUE INDEX "sim_user_workspace_idx" ON "sim_workspace_member" USING btree ("user_id","workspace_id");--> statement-breakpoint
ALTER TABLE "sim_workflow" ADD CONSTRAINT "sim_workflow_workspace_id_workspace_id_fk" FOREIGN KEY ("workspace_id") REFERENCES "public"."sim_workspace"("id") ON DELETE cascade ON UPDATE no action;