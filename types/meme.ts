import {Author} from "./user";

export interface Meme {
    /**
     * Whether this meme is disabled.
     * This is almost always false, it is only true for meme authors.
     */
    disabled: boolean;
    /**
     * The ID of this meme.
     */
    memeid: string;
    /**
     * The caption of this meme.
     */
    caption: string;
    /**
     * The author of this meme, as a user object.
     */
    author: Author;
    /**
     * A rating object of this meme.
     */
    rating: Rating;
    /**
     * The age rating of this meme.
     */
    age: number;
    /**
     * A link to the IMAGE of this meme.
     */
    url: string;
    /**
     * A link to view this meme on memerator.me
     */
    permalink: string;
    /**
     * The timestamp of this meme.
     */
    timestamp: Date;
    /**
     * The timestamp of this meme in seconds since the epoch.
     */
    timestamp_epoch_seconds: number;
    /**
     * The relative formatted time since this meme was posted.
     */
    time_ago: string;
}

export interface Rating {
    average: number;
    total: number;
}

