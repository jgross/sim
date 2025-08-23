DROP INDEX "sim_workflow_execution_logs_cost_idx";--> statement-breakpoint
DROP INDEX "sim_workflow_execution_logs_duration_idx";--> statement-breakpoint
CREATE INDEX "sim_workflow_execution_logs_workflow_started_at_idx" ON "sim_workflow_execution_logs" USING btree ("workflow_id","started_at");