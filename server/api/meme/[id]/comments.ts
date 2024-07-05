import {Meme} from "~/types/meme";
import {Comment} from "~/types/comment";

export default defineEventHandler(async (event) => {
    const id = getRouterParam(event, 'id')

    console.log("ID: " + id)

    // Fetch the meme from the API
    const commentRes: Response = await fetch(`https://api.memerator.me/v1/meme/${id}/comments`, {
        headers: {
            Authorization: useRuntimeConfig().memeratorApiKey,
        }
    })
    // print the resposne out for debugging
    console.log(commentRes)

    // json time
    const comments: Comment[] = await commentRes.json()

    // Return the meme
    return comments
})