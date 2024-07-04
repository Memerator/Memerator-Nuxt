import {Meme} from "~/types/meme";

export default defineEventHandler(async (event) => {
    const id = getRouterParam(event, 'id')

    console.log("ID: " + id)

    // Fetch the meme from the API
    const memeRes: Response = await fetch(`https://api.memerator.me/v1/meme/${id}`, {
        headers: {
            Authorization: useRuntimeConfig().memeratorApiKey,
        }
    })
    // print the resposne out for debugging
    console.log(memeRes)

    // json time
    const meme: Meme = await memeRes.json()

    // Return the meme
    return meme
})
