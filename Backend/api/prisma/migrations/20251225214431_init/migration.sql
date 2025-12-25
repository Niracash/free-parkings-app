-- CreateEnum
CREATE TYPE "PlaceType" AS ENUM ('car', 'bike');

-- CreateEnum
CREATE TYPE "PlaceStatus" AS ENUM ('active', 'temp_unavailable', 'disputed', 'hidden', 'deleted');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "emailVerifiedAt" TIMESTAMP(3),
    "lastActiveAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL DEFAULT 'active',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Place" (
    "id" TEXT NOT NULL,
    "type" "PlaceType" NOT NULL,
    "status" "PlaceStatus" NOT NULL DEFAULT 'active',
    "lat" DOUBLE PRECISION NOT NULL,
    "lng" DOUBLE PRECISION NOT NULL,
    "createdByUserId" TEXT,
    "createdByUsernameSnap" TEXT NOT NULL,
    "note" TEXT,
    "avgRating" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "ratingsCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Place_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarRule" (
    "placeId" TEXT NOT NULL,
    "isFree" BOOLEAN NOT NULL,
    "freeMinutes" INTEGER,
    "freeOutsideHours" BOOLEAN NOT NULL,
    "outsideHoursBehavior" TEXT NOT NULL,

    CONSTRAINT "CarRule_pkey" PRIMARY KEY ("placeId")
);

-- CreateTable
CREATE TABLE "CarTimeWindow" (
    "id" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,
    "weekday" INTEGER NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,

    CONSTRAINT "CarTimeWindow_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Place" ADD CONSTRAINT "Place_createdByUserId_fkey" FOREIGN KEY ("createdByUserId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarRule" ADD CONSTRAINT "CarRule_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarTimeWindow" ADD CONSTRAINT "CarTimeWindow_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
