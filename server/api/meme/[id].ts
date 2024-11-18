import prisma from "~/lib/prisma";
import type {IMemeFromSQL} from "~/models/meme";
import User from "~/models/user";

interface MemeAuthor {
    username: string;
    pro: boolean;
    verified: boolean;
    name_color: string | null;
    avatar: string | null;
}

export interface MemeResponse extends IMemeFromSQL {
    ratings: {
        "1": number;
        "2": number;
        "3": number;
        "4": number;
        "5": number;
        total: number;
        average: number;
    },
    author: MemeAuthor;
}

export default defineEventHandler(async (event) => {
    const id = getRouterParam(event, 'id')

    // meme
    const memeSql = await prisma.memes.findFirst({
        where: {
            id
        },
        include: {
            ratings: {
                select: {
                    rating: true
                }
            },
            users: true,
        }
    })

    if (!memeSql) {
        return new Response('Meme not found', {status: 404})
    }

    const user: User = new User(memeSql.users)

    const author: MemeAuthor = {
        username: memeSql.users.username,
        pro: user.isPro(),
        verified: user.isVerified(),
        name_color: memeSql.users.name_color,
        avatar: user.profilePicture(),
    }

    // count amount of ratings
    const ratings = {
        "1": memeSql.ratings.filter(r => r.rating === 1).length,
        "2": memeSql.ratings.filter(r => r.rating === 2).length,
        "3": memeSql.ratings.filter(r => r.rating === 3).length,
        "4": memeSql.ratings.filter(r => r.rating === 4).length,
        "5": memeSql.ratings.filter(r => r.rating === 5).length,
        total: memeSql.ratings.length,
        average: memeSql.ratings.reduce((acc, cur) => acc + cur.rating, 0) / memeSql.ratings.length
    }

    const response: MemeResponse = {
        ...memeSql,
        author,
        ratings
    }

    // Return the meme
    return response
})
