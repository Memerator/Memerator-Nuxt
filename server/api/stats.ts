import {Stats} from "~/types/stats";

export default defineEventHandler(async (event) => {
    // Fetch the stats from the API
    const res: Response = await fetch(`https://api.memerator.me/v1/stats`, {
        headers: {
            Authorization: useRuntimeConfig().memeratorApiKey,
        }
    })

    // json time
    // Return the meme
    return await res.json() as Stats
})
