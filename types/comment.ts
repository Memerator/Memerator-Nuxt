import {Meme} from "./meme";
import {Author} from "./user";

export interface Comment {
    /**
     * The ID of this comment.
     */
    id: number;
    /**
     * The author of this comment, as a user object.
     */
    author: Author;
    /**
     * The content of this comment.
     */
    content: string;
    /**
     * The meme this comment is on.
     */
    meme: Meme;
    /**
     * The timestamp of this comment.
     */
    timestamp: Date;
    /**
     * The timestamp of this comment in seconds since the epoch.
     */
    timestamp_epoch_seconds: number;
}
