import prisma from "~/lib/prisma";
import User from "~/models/user";

interface RecentMeme {
    id: string;
    caption: string | null;
    url: string;
    created_at: string;
    author: {
        username: string;
        avatar: string | null;
    };
    ratings: {
        total: number;
        average: number;
    };
}

export interface RecentMemeResponse {
    memes: RecentMeme[];
    page: number;
    min: number;
    max: number;
    total: number;
}

export default defineEventHandler(async (event) => {
    const query = getQuery(event)
    const page: number = (query.page ?? 1) as number;
    const offset = (page - 1) * 25

    // Fetch the meme from the API
    const memeSql = await prisma.memes.findMany({
        where: {
            disabled: false,
            approved: true
        },
        orderBy: {
            created_at: 'desc'
        },
        skip: offset,
        take: 25,
        select: {
            id: true,
            caption: true,
            url: true,
            created_at: true,
            users: {
                select: {
                    username: true,
                    avatar: true,
                    email: true,
                }
            },
            ratings: {
                select: {
                    rating: true
                }
            }
        }
    })

    const totalMemes = await prisma.memes.count({
        where: {
            disabled: false,
            approved: true
        }
    });

    // Return the memes
    const mappedMemes = memeSql.map(meme => {
        const email = meme.users.email
        const avatar = (email && meme.users.avatar === 'gravatar') ? User.profilePicture(email) : null

        const newMeme: RecentMeme = {
            id: meme.id,
            url: meme.url,
            caption: meme.caption,
            created_at: meme.created_at.toString(),
            author: {
                username: meme.users.username,
                avatar
            },
            ratings: {
                total: meme.ratings.length,
                average: meme.ratings.reduce((a, b) => a + b.rating, 0) / meme.ratings.length
            }
        }

        return newMeme
    })

    const response: RecentMemeResponse = {
        memes: mappedMemes,
        page,
        min: offset + 1,
        max: offset + mappedMemes.length,
        total: totalMemes
    }

    return response
})
