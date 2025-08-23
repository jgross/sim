CREATE TABLE "sim_api_key" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"name" text NOT NULL,
	"key" text NOT NULL,
	"last_used" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"expires_at" timestamp,
	CONSTRAINT "sim_api_key_key_unique" UNIQUE("key")
);
--> statement-breakpoint
ALTER TABLE "sim_api_key" ADD CONSTRAINT "sim_api_key_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;