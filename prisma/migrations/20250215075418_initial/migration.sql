-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('SUPERADMIN', 'Manager', 'DOCTOR', 'USER');

-- CreateEnum
CREATE TYPE "DaysOfWeek" AS ENUM ('SATURDAY', 'SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY');

-- CreateEnum
CREATE TYPE "AppointmentStatus" AS ENUM ('PENDING', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "InvoiceStatus" AS ENUM ('Pending', 'Paid', 'Canceled');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "verified" BOOLEAN NOT NULL DEFAULT false,
    "resetPasswordToken" VARCHAR(255),
    "role" "Role" NOT NULL DEFAULT 'Manager',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "cancellationLogId" INTEGER,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clinics" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(50) NOT NULL,
    "address" VARCHAR(255),
    "manager" VARCHAR(100),
    "email" VARCHAR(100),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "clinics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_clinics" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "clinicId" INTEGER NOT NULL,

    CONSTRAINT "users_clinics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_profiles" (
    "id" SERIAL NOT NULL,
    "firstName" VARCHAR(50),
    "lastName" VARCHAR(50),
    "phone" VARCHAR(50),
    "birthday" TIMESTAMP(3) NOT NULL,
    "socialId" VARCHAR(100) NOT NULL,
    "license" VARCHAR(255),
    "specialization" VARCHAR(150),
    "bio" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "patients" (
    "id" SERIAL NOT NULL,
    "firstName" VARCHAR(50),
    "lastName" VARCHAR(50),
    "phone" VARCHAR(50),
    "gender" "Gender" NOT NULL,
    "clinicId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "patients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "patients_profiles" (
    "id" SERIAL NOT NULL,
    "birthday" TIMESTAMP(3) NOT NULL,
    "Occupation" VARCHAR(50),
    "length" INTEGER,
    "weight" DECIMAL(10,2),
    "history" TEXT,
    "patientId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "patients_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "appointments" (
    "id" SERIAL NOT NULL,
    "status" "AppointmentStatus" NOT NULL DEFAULT 'PENDING',
    "appointmentDate" TIMESTAMP(3) NOT NULL,
    "reason" TEXT,
    "note" TEXT,
    "createdByUserId" INTEGER NOT NULL,
    "assignedToId" INTEGER NOT NULL,
    "clinicId" INTEGER NOT NULL,
    "patientId" INTEGER NOT NULL,
    "treatmentPlanId" INTEGER,
    "billId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "profileId" INTEGER,

    CONSTRAINT "appointments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "schedules" (
    "id" SERIAL NOT NULL,
    "dayOfWeek" "DaysOfWeek" NOT NULL,
    "availableFrom" TIMESTAMP(3) NOT NULL,
    "availableTo" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "profileId" INTEGER,

    CONSTRAINT "schedules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bills" (
    "id" SERIAL NOT NULL,
    "amount" DECIMAL(65,30) NOT NULL,
    "status" "InvoiceStatus" NOT NULL DEFAULT 'Pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "bills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "treatmentPlans" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "PatientProfileId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "treatmentPlans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "progressionNotes" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "PatientProfileId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "progressionNotes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "examinations" (
    "id" SERIAL NOT NULL,
    "subjectivePainScale" INTEGER,
    "subjectiveLocation" VARCHAR(255),
    "subjectiveDescription" TEXT,
    "subjectiveAggravatingFactors" TEXT,
    "objectivePosture" VARCHAR(255),
    "objectiveRegion" VARCHAR(255),
    "objectivePhysiologicalMotion" TEXT,
    "palpation" TEXT,
    "PatientProfileId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "examinations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cancellationLogs" (
    "id" SERIAL NOT NULL,
    "action" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "appointmentId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "clinicId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "cancellationLogs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ClinicToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_ClinicToUser_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "clinics_email_key" ON "clinics"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_clinics_userId_key" ON "users_clinics"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "users_profiles_license_key" ON "users_profiles"("license");

-- CreateIndex
CREATE UNIQUE INDEX "users_profiles_userId_key" ON "users_profiles"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "patients_clinicId_key" ON "patients"("clinicId");

-- CreateIndex
CREATE UNIQUE INDEX "patients_profiles_patientId_key" ON "patients_profiles"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "appointments_createdByUserId_key" ON "appointments"("createdByUserId");

-- CreateIndex
CREATE UNIQUE INDEX "appointments_assignedToId_key" ON "appointments"("assignedToId");

-- CreateIndex
CREATE UNIQUE INDEX "appointments_clinicId_key" ON "appointments"("clinicId");

-- CreateIndex
CREATE UNIQUE INDEX "appointments_patientId_key" ON "appointments"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "appointments_treatmentPlanId_key" ON "appointments"("treatmentPlanId");

-- CreateIndex
CREATE UNIQUE INDEX "appointments_billId_key" ON "appointments"("billId");

-- CreateIndex
CREATE UNIQUE INDEX "treatmentPlans_PatientProfileId_key" ON "treatmentPlans"("PatientProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "progressionNotes_PatientProfileId_key" ON "progressionNotes"("PatientProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "examinations_PatientProfileId_key" ON "examinations"("PatientProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "cancellationLogs_appointmentId_key" ON "cancellationLogs"("appointmentId");

-- CreateIndex
CREATE UNIQUE INDEX "cancellationLogs_userId_key" ON "cancellationLogs"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "cancellationLogs_clinicId_key" ON "cancellationLogs"("clinicId");

-- CreateIndex
CREATE INDEX "_ClinicToUser_B_index" ON "_ClinicToUser"("B");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_cancellationLogId_fkey" FOREIGN KEY ("cancellationLogId") REFERENCES "cancellationLogs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_clinics" ADD CONSTRAINT "users_clinics_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_clinics" ADD CONSTRAINT "users_clinics_clinicId_fkey" FOREIGN KEY ("clinicId") REFERENCES "clinics"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_profiles" ADD CONSTRAINT "users_profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "patients" ADD CONSTRAINT "patients_clinicId_fkey" FOREIGN KEY ("clinicId") REFERENCES "clinics"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "patients_profiles" ADD CONSTRAINT "patients_profiles_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_createdByUserId_fkey" FOREIGN KEY ("createdByUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_clinicId_fkey" FOREIGN KEY ("clinicId") REFERENCES "clinics"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_treatmentPlanId_fkey" FOREIGN KEY ("treatmentPlanId") REFERENCES "treatmentPlans"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_billId_fkey" FOREIGN KEY ("billId") REFERENCES "bills"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "users_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "schedules" ADD CONSTRAINT "schedules_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "users_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "treatmentPlans" ADD CONSTRAINT "treatmentPlans_PatientProfileId_fkey" FOREIGN KEY ("PatientProfileId") REFERENCES "patients_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "progressionNotes" ADD CONSTRAINT "progressionNotes_PatientProfileId_fkey" FOREIGN KEY ("PatientProfileId") REFERENCES "patients_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "examinations" ADD CONSTRAINT "examinations_PatientProfileId_fkey" FOREIGN KEY ("PatientProfileId") REFERENCES "patients_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cancellationLogs" ADD CONSTRAINT "cancellationLogs_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "appointments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cancellationLogs" ADD CONSTRAINT "cancellationLogs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cancellationLogs" ADD CONSTRAINT "cancellationLogs_clinicId_fkey" FOREIGN KEY ("clinicId") REFERENCES "clinics"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClinicToUser" ADD CONSTRAINT "_ClinicToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "clinics"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClinicToUser" ADD CONSTRAINT "_ClinicToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
