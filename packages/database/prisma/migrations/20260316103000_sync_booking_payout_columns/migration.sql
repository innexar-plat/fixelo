-- Migration: Sync Booking payout-related columns with current Prisma schema
-- Date: 2026-03-16

ALTER TABLE "Booking" ADD COLUMN IF NOT EXISTS "payoutId" TEXT;
ALTER TABLE "Booking" ADD COLUMN IF NOT EXISTS "payoutStatus" TEXT NOT NULL DEFAULT 'PENDING';
ALTER TABLE "Booking" ADD COLUMN IF NOT EXISTS "payoutEligibleAt" TIMESTAMP(3);
ALTER TABLE "Booking" ADD COLUMN IF NOT EXISTS "disputeStatus" TEXT;

CREATE INDEX IF NOT EXISTS "Booking_payoutId_idx" ON "Booking"("payoutId");

-- Add foreign key only if target table exists and constraint does not already exist
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'Payout'
  ) AND NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'Booking_payoutId_fkey'
  ) THEN
    ALTER TABLE "Booking"
      ADD CONSTRAINT "Booking_payoutId_fkey"
      FOREIGN KEY ("payoutId") REFERENCES "Payout"("id")
      ON DELETE SET NULL ON UPDATE CASCADE;
  END IF;
END $$;
