ALTER TABLE "sim_workflow" ADD COLUMN "is_deployed" boolean DEFAULT false NOT NULL;--> statement-breakpoint
ALTER TABLE "sim_workflow" ADD COLUMN "deployed_at" timestamp;--> statement-breakpoint
ALTER TABLE "sim_workflow" ADD COLUMN "api_key" text;