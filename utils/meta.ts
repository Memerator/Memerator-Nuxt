/**
 * Adds necessary tags for meta where needed
 * @param title The title of the page. Appears in navbar and embed titles. Do not include "- Memerator"
 * @param description Embed description
 * @param color Embed color
 */
export function metaTags(title: string = '', description: string = '', color: string = '#fabc4d') {
    return useSeoMeta({
        title: `${title} - Memerator`,
        ogTitle: `${title} - Memerator`,
        twitterTitle: `${title} - Memerator`,
        description,
        ogDescription: description,
        twitterDescription: description,
        ogSiteName: 'Memerator',
        twitterSite: 'Memerator',
        themeColor: color,
    })
}
