import {Meme} from "~/types/meme";

export default defineEventHandler(async (event) => {
    const id = getRouterParam(event, 'id')
    const query = getQuery(event)
    const offset = ((query.page || 1) - 1) * 25

    // Fetch the meme from the API
    const memeRes: Response = await fetch(`https://api.memerator.me/v1/meme/recents?amount=25&offset=${offset}`, {
        headers: {
            Authorization: useRuntimeConfig().memeratorApiKey,
        }
    })

    // json time
    const meme: Meme[] = await memeRes.json()

    // Return the meme
    return meme
})
