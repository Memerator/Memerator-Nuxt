import type {Stats} from "~/types/stats";

export default defineEventHandler(async () => {
    // Get the results simultaneously
    const results = await Promise.allSettled([
        prisma.memes.count({
            where: {
                disabled: false,
            },
        }),
        prisma.ratings.count(),
        prisma.users.count(),
        prisma.memes.groupBy({
            by: ['user_id'],
            _count: {
                user_id: true,
            },
        }).then(results => results.length),
    ]);

    // Map to the stats object
    const response: Stats = {
        memes: results[0].status === 'fulfilled' ? results[0].value : 0,
        ratings: results[1].status === 'fulfilled' ? results[1].value : 0,
        website_users: results[2].status === 'fulfilled' ? results[2].value : 0,
        unique_memers: results[3].status === 'fulfilled' ? results[3].value : 0,
    };

    // Return the stats
    return response;
})
