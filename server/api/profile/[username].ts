import type {Perks, Pro, Stats} from "~/types/user";
import prisma from "~/lib/prisma";
import User from "~/models/user";

export interface ProfileUsernameResponse {
    username: string;
    bio: string | null;
    id: bigint;
    stats: Stats;
    perks: Perks;
    joined: Date;
    pro?: Pro;
    avatar: string;
    memes: {
        id: string
        url: string
        created_at: Date
    }[];
}

export default defineEventHandler(async (event) => {
    const username = getRouterParam(event, 'username')

    if (username == null) {
        return new Response('Username not provided', {status: 400})
    }

    // Fetch the meme from the API
    const userSql = await prisma.users.findFirst({
        where: {
            username: username
        },
        // also get memes
        include: {
            memes: {
                select: {
                    id: true,
                    url: true,
                    created_at: true
                },
            }
        }
    });

    if (userSql == null) {
        return new Response('User not found', {status: 404})
    }

    const user = User.fromUser(userSql)

    const userResponse: ProfileUsernameResponse = {
        username: user.username ?? '',
        bio: user.bio ?? null,
        id: user.id ?? 0,
        stats: {
            memes: 0,
            followers: 0,
            following: 0,
        },
        perks: {
            verified: user.isVerified(),
            pro: user.isPro(),
            staff: user.isStaff(),
            translator: user.isTranslator(),
            service: user.isService(),
            founder: user.isFounder(),
        },
        joined: user.created_at,
        avatar: user.profilePicture(),
        memes: userSql.memes
    }

    if (user.isPro()) {
        userResponse.pro = {
            name_color: user.custom_bg_color ?? '',
            background_color: user.custom_bg_color ?? '',
            background_url: user.custom_bg_url ?? '',
            active: true,
            since: user.created_at,
        }
    }

    // Return the user
    return userResponse
})
