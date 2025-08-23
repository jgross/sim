CREATE TABLE "sim_invitation" (
	"id" text PRIMARY KEY NOT NULL,
	"email" text NOT NULL,
	"inviter_id" text NOT NULL,
	"sim_organization_id" text NOT NULL,
	"role" text NOT NULL,
	"status" text NOT NULL,
	"expires_at" timestamp NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sim_member" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"sim_organization_id" text NOT NULL,
	"role" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sim_organization" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"slug" text NOT NULL,
	"logo" text,
	"metadata" jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "sim_session" ADD COLUMN "active_organization_id" text;--> statement-breakpoint
ALTER TABLE "sim_subscription" ADD COLUMN "trial_start" timestamp;--> statement-breakpoint
ALTER TABLE "sim_subscription" ADD COLUMN "trial_end" timestamp;--> statement-breakpoint
ALTER TABLE "sim_invitation" ADD CONSTRAINT "sim_invitation_inviter_id_user_id_fk" FOREIGN KEY ("inviter_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_invitation" ADD CONSTRAINT "sim_invitation_organization_id_organization_id_fk" FOREIGN KEY ("sim_organization_id") REFERENCES "public"."sim_organization"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_member" ADD CONSTRAINT "sim_member_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."sim_user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_member" ADD CONSTRAINT "sim_member_organization_id_organization_id_fk" FOREIGN KEY ("sim_organization_id") REFERENCES "public"."sim_organization"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sim_session" ADD CONSTRAINT "sim_session_active_organization_id_organization_id_fk" FOREIGN KEY ("active_organization_id") REFERENCES "public"."sim_organization"("id") ON DELETE set null ON UPDATE no action;