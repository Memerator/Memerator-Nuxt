import type {Author} from "~/types/user";

export interface Stats {
    memes:         number;
    ratings:       number;
    website_users: number;
    unique_memers: number;
}

export interface TopMemer {
    rank: number;
    user: Author;
    score: number;
}

export interface TopMemers {
    "1d": TopMemer[]
    "7d": TopMemer[]
    "1mo": TopMemer[]
}
