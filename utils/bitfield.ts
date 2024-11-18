export enum UserBitField {
    Verified = 1,
    Pro = 2,
    Staff = 4,
    Translator = 8,
    Service = 16,
    Influencer = 32,
    Founder = 64,
    Trusted = 128,
}

export function parseUserFlags(flags: number): UserBitField[] {
    return Object.values(UserBitField)
        .filter((bit) => typeof bit === "number" && (flags & (bit as number)) !== 0)
        .map((bit) => bit as UserBitField);
}
