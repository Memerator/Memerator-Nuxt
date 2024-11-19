import {parseUserFlags, UserBitField} from "~/utils/bitfield";
import {decryptAES} from "~/utils/aes";
import crypto from "crypto";

export interface IUserFromSQL {
    id: bigint
    access_token: string | null
    permissions: number
    staff_perms: bigint
    status: number
    logging: number
    code: string | null
    username: string
    password: string | null
    fcmToken: string | null
    bio: string | null
    noti_meme: number
    noti_follow: number
    noti_reports: number
    dark: number
    age: number
    avatar: string | null
    disabled: boolean
    name_color: string | null
    custom_bg_url: string | null
    custom_bg_loc: number
    user_bg_loc: number
    show_custom_bg: boolean
    custom_bg_color: string | null
    logintype: number
    emailonfail: boolean
    emailonsuccess: boolean
    email: string | null
    email_status: number
    email_code: string | null
    resetpass_code: string | null
    mc_code: string | null
    mc_login_code: string | null
    created_at: Date
    updated_at: Date
    last_login: Date | null
    tos: boolean | null
}

export interface IUser extends IUserFromSQL {
    User(input: IUser): User;
    profilePicture(): string;
    isVerified(): boolean;
    isStaff(): boolean;
    isTranslator(): boolean;
    isFounder(): boolean;
    isService(): boolean;
    isPro(): boolean;
}

export default class User implements IUser {
    access_token!: string | null;
    age!: number;
    avatar!: string | null;
    bio!: string | null;
    code!: string | null;
    created_at!: Date;
    custom_bg_color!: string | null;
    custom_bg_loc!: number;
    custom_bg_url!: string | null;
    dark!: number;
    disabled!: boolean;
    email!: string | null;
    email_code!: string | null;
    email_status!: number;
    emailonfail!: boolean;
    emailonsuccess!: boolean;
    fcmToken!: string | null;
    id!: bigint;
    last_login!: Date | null;
    logging!: number;
    logintype!: number;
    mc_code!: string | null;
    mc_login_code!: string | null;
    name_color!: string | null;
    noti_follow!: number;
    noti_meme!: number;
    noti_reports!: number;
    password!: string | null;
    permissions!: number;
    resetpass_code!: string | null;
    show_custom_bg!: boolean;
    staff_perms!: bigint;
    status: number = 0;
    tos!: boolean | null;
    updated_at!: Date;
    user_bg_loc!: number;
    username!: string;

    User(input: IUserFromSQL): User {
        return new User(input);
    }

    public constructor(input: IUserFromSQL) {
        Object.assign(this, input);
    }

    // Optional static factory method for convenience
    static fromUser(input: IUserFromSQL): User {
        return new User(input);
    }

    static profilePicture(encryptedEmail: string): string {
        const email = decryptAES(encryptedEmail);

        // md5 encrypt the email
        const md5Email = crypto.createHash("md5").update(email).digest("hex");

        return "https://www.gravatar.com/avatar/" + md5Email;
    }

    public profilePicture() {
        if (this.avatar === "gravatar" && this.email_status === 2 && this.email !== null) {
            return User.profilePicture(this.email);
        } else {
            return "";
        }
    }

    public isVerified(): boolean {
        return parseUserFlags(this.status).includes(UserBitField.Verified);
    }

    public isStaff(): boolean {
        return parseUserFlags(this.status).includes(UserBitField.Staff);
    }

    public isTranslator(): boolean {
        return parseUserFlags(this.status).includes(UserBitField.Translator);
    }

    public isFounder(): boolean {
        return parseUserFlags(this.status).includes(UserBitField.Founder);
    }

    public isService(): boolean {
        return parseUserFlags(this.status).includes(UserBitField.Service);
    }

    public isPro(): boolean {
        return parseUserFlags(this.status).includes(UserBitField.Pro);
    }
}
