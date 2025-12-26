import { PrismaMariaDb } from '@prisma/adapter-mariadb'
// noinspection ES6PreferShortImport Cloudflare might hate this one!
import { PrismaClient } from '../../prisma/generated/client'

const prismaClientSingleton = () => {
    const pool = new PrismaMariaDb({
        host: process.env.DATABASE_URL,
        port: 3306,
        user: process.env.DATABASE_USER,
    })
    return new PrismaClient({ adapter: pool })
}

type PrismaClientSingleton = ReturnType<typeof prismaClientSingleton>

const globalForPrisma = globalThis as unknown as {
    prisma: PrismaClientSingleton | undefined
}

export const prisma = globalForPrisma.prisma ?? prismaClientSingleton()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma
