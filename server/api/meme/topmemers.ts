import {TopMemers} from "~/types/stats";

export default defineEventHandler(async (event) => {
    // Fetch the meme from the API
    const memeRes: Response = await fetch(`https://api.memerator.me/v1/topmemers`, {
        headers: {
            Authorization: useRuntimeConfig().memeratorApiKey,
        }
    })

    // Return the meme
    return await memeRes.json() as TopMemers
})
