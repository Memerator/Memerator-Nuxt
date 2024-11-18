import prisma from "~/lib/prisma";

export interface MemeCommentsResponse {
    id: number;
    text: string;
    created_at: Date;
    updated_at: Date;
    author: {
        id: bigint;
        username: string;
    }
}

export default defineEventHandler(async (event) => {
    const id = getRouterParam(event, 'id')

    const commentsSql = await prisma.comments.findMany({
        where: {
            meme_id: id
        },
        include: {
            users: {
                select: {
                    username: true
                }
            }
        }
    })

    const comments: MemeCommentsResponse[] = commentsSql.map(comment => {
        return {
            id: comment.id,
            text: comment.text,
            created_at: comment.created_at,
            updated_at: comment.updated_at,
            author: {
                id: comment.user_id,
                username: comment.users.username
            }
        }
    })

    // Return the comments
    return comments
})
