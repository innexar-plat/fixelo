const { PrismaClient, UserRole, CleanerStatus } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding runtime defaults...');

  // Precomputed bcrypt hash for: password123
  const passwordHash = '$2a$10$5v8J32hyhNe2oI/4BjQPZO051nqmQu9nYbhHK9ZDuIzpu7EARlxf2';

  const adminUser = await prisma.user.upsert({
    where: { email: 'admin@fixelo.app' },
    update: {},
    create: {
      email: 'admin@fixelo.app',
      passwordHash,
      firstName: 'System',
      lastName: 'Admin',
      role: UserRole.ADMIN,
      isActive: true,
    },
  });

  const cleanerUser = await prisma.user.upsert({
    where: { email: 'cleaner@fixelo.app' },
    update: {},
    create: {
      email: 'cleaner@fixelo.app',
      passwordHash,
      firstName: 'John',
      lastName: 'Cleaner',
      role: UserRole.CLEANER,
      isActive: true,
    },
  });

  await prisma.cleanerProfile.upsert({
    where: { userId: cleanerUser.id },
    update: {},
    create: {
      userId: cleanerUser.id,
      serviceRadius: 10,
      status: CleanerStatus.ACTIVE,
      onboardingCompleted: true,
    },
  });

  await prisma.serviceType.upsert({
    where: { slug: 'standard' },
    update: {},
    create: {
      name: 'Standard Cleaning',
      slug: 'standard',
      description: 'Regular home cleaning service',
      basePrice: 109,
      inclusions: [
        'Dusting all surfaces',
        'Vacuum all floors',
        'Mop hard floors',
        'Bathroom cleaning (toilet, sink, shower)',
        'Kitchen surface cleaning',
        'Trash removal',
      ],
      exclusions: ['Inside oven', 'Inside fridge', 'Deep grout cleaning', 'Heavy grease'],
      baseTime: 120,
      timePerBed: 45,
      timePerBath: 30,
    },
  });

  await prisma.serviceType.upsert({
    where: { slug: 'deep' },
    update: {},
    create: {
      name: 'Deep Cleaning',
      slug: 'deep',
      description: 'Thorough deep cleaning service',
      basePrice: 169,
      inclusions: [
        'Everything in Standard Cleaning',
        'Inside oven cleaning',
        'Inside fridge cleaning',
        'Baseboards',
        'Cabinet exteriors',
        'Extra bathroom detail',
        'Heavy dust removal',
      ],
      exclusions: [],
      baseTime: 180,
      timePerBed: 60,
      timePerBath: 45,
    },
  });

  await prisma.serviceType.upsert({
    where: { slug: 'airbnb' },
    update: {},
    create: {
      name: 'Airbnb / Vacation Rental Cleaning',
      slug: 'airbnb',
      description: 'Turnover cleaning for vacation rentals',
      basePrice: 129,
      inclusions: [
        'Turnover cleaning',
        'Bed linens change',
        'Trash removal',
        'Bathroom reset',
        'Kitchen reset',
        'Basic restocking',
      ],
      exclusions: [],
      baseTime: 90,
      timePerBed: 30,
      timePerBath: 20,
    },
  });

  console.log('Runtime seed complete. Admin:', adminUser.email);
}

main()
  .catch((err) => {
    console.error('Runtime seed failed:', err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
