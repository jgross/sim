CREATE TABLE "sim_custom_tools" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"title" text NOT NULL,
	"schema" json NOT NULL,
	"code" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "sim_custom_tools" ADD CONSTRAINT "sim_custom_tools_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;