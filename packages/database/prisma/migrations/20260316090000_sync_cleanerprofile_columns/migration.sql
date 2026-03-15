-- Migration: Sync CleanerProfile table columns with current Prisma schema
-- Date: 2026-03-16

-- Provider metrics
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "totalJobsOffered" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "totalJobsAccepted" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "totalJobsCompleted" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "totalLateArrivals" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "acceptanceRate" DOUBLE PRECISION NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "completionRate" DOUBLE PRECISION NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "punctualityRate" DOUBLE PRECISION NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "qualityScore" DOUBLE PRECISION NOT NULL DEFAULT 0;

-- Onboarding and verification details
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "businessType" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "taxIdType" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "ein" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "ssnLast4" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "itin" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "yearsOfExperience" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "hasInsurance" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "websiteUrl" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "instagramHandle" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "linkedinProfile" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "facebookProfileUrl" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "bio" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "idDocumentUrl" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "photoIdType" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "selfieVerificationUrl" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "selfieVerified" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "insuranceDocUrl" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "verificationStatus" TEXT NOT NULL DEFAULT 'PENDING';
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "onboardingStep" INTEGER NOT NULL DEFAULT 1;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "documentRequestReason" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "documentRequestedAt" TIMESTAMP(3);
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "documentsRequested" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "submittedAt" TIMESTAMP(3);
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "reviewedAt" TIMESTAMP(3);
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "reviewedBy" TEXT;
ALTER TABLE "CleanerProfile" ADD COLUMN IF NOT EXISTS "rejectionReason" TEXT;

-- Schema indexes
CREATE INDEX IF NOT EXISTS "CleanerProfile_verificationStatus_idx" ON "CleanerProfile"("verificationStatus");
