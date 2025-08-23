ALTER TABLE "sim_settings" ADD COLUMN "console_expanded_by_default" boolean DEFAULT true NOT NULL;--> statement-breakpoint
ALTER TABLE "sim_settings" DROP COLUMN "debug_mode";