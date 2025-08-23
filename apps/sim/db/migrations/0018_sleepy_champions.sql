CREATE TABLE "sim_marketplace" (
	"id" text PRIMARY KEY NOT NULL,
	"workflow_id" text NOT NULL,
	"state" json NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"author_id" text NOT NULL,
	"author_name" text NOT NULL,
	"stars" integer DEFAULT 0 NOT NULL,
	"executions" integer DEFAULT 0 NOT NULL,
	"category" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sim_marketplace_execution" (
	"id" text PRIMARY KEY NOT NULL,
	"sim_marketplace_id" text NOT NULL,
	"user_id" text,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sim_marketplace_star" (
	"id" text PRIMARY KEY NOT NULL,
	"sim_marketplace_id" text NOT NULL,
	"user_id" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "sim_marketplace" ADD CONSTRAINT "sim_marketplace_workflow_id_workflow_id_fk" FOREIGN KEY ("workflow_id") REFERENCES "public"."sim_workflow"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_marketplace" ADD CONSTRAINT "sim_marketplace_author_id_user_id_fk" FOREIGN KEY ("author_id") REFERENCES "public"."sim_user"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_marketplace_execution" ADD CONSTRAINT "sim_marketplace_execution_marketplace_id_marketplace_id_fk" FOREIGN KEY ("sim_marketplace_id") REFERENCES "public"."sim_marketplace"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_marketplace_execution" ADD CONSTRAINT "sim_marketplace_execution_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_marketplace_star" ADD CONSTRAINT "sim_marketplace_star_marketplace_id_marketplace_id_fk" FOREIGN KEY ("sim_marketplace_id") REFERENCES "public"."sim_marketplace"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_marketplace_star" ADD CONSTRAINT "sim_marketplace_star_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE UNIQUE INDEX "sim_user_marketplace_idx" ON "sim_marketplace_star" USING btree ("user_id","sim_marketplace_id");