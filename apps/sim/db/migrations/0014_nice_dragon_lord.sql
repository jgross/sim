ALTER TABLE "sim_webhook" ADD COLUMN "provider_config" json;--> statement-breakpoint
ALTER TABLE "sim_webhook" DROP COLUMN "secret";