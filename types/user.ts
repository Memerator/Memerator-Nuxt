export interface Author {
    username:             string;
    bio:                  string;
    id:                   number;
    stats:                Stats;
    perks:                Perks;
    permalink:            string;
    joined:               Date;
    joined_epoch_seconds: number;
    pro:                  Pro;
}

export interface Perks {
    verified:   boolean;
    pro:        boolean;
    staff:      boolean;
    translator: boolean;
    service:    boolean;
    founder:    boolean;
}

export interface Pro {
    name_color:       string;
    background_color: string;
    background_url:   string;
    active:           boolean;
    since:            Date;
}

export interface Stats {
    memes:     number;
    followers: number;
    following: number;
}
