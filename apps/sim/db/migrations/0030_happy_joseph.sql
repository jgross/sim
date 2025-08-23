CREATE TABLE "sim_chat" (
	"id" text PRIMARY KEY NOT NULL,
	"workflow_id" text NOT NULL,
	"user_id" text NOT NULL,
	"subdomain" text NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"customizations" json DEFAULT '{}',
	"auth_type" text DEFAULT 'public' NOT NULL,
	"password" text,
	"allowed_emails" json DEFAULT '[]',
	"output_block_id" text,
	"output_path" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sim_subscription" (
	"id" text PRIMARY KEY NOT NULL,
	"plan" text NOT NULL,
	"reference_id" text NOT NULL,
	"stripe_customer_id" text,
	"stripe_subscription_id" text,
	"status" text,
	"period_start" timestamp,
	"period_end" timestamp,
	"cancel_at_period_end" boolean,
	"seats" integer
);
--> statement-breakpoint
ALTER TABLE "sim_user" ADD COLUMN "stripe_customer_id" text;--> statement-breakpoint
ALTER TABLE "sim_chat" ADD CONSTRAINT "sim_chat_workflow_id_workflow_id_fk" FOREIGN KEY ("workflow_id") REFERENCES "public"."sim_workflow"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_chat" ADD CONSTRAINT "sim_chat_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE UNIQUE INDEX "subdomain_idx" ON "sim_chat" USING btree ("subdomain");