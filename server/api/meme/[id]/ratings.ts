import {Rating} from "~/types/meme";

export default defineEventHandler(async (event) => {
    const id = getRouterParam(event, 'id')

    // Fetch the meme from the API
    const ratingRes: Response = await fetch(`https://api.memerator.me/v1/meme/${id}/ratings`, {
        headers: {
            Authorization: useRuntimeConfig().memeratorApiKey,
        }
    })

    // json time
    const ratings: Rating[] = await ratingRes.json()

    // Return the meme
    return ratings
})
