export interface IMemeFromSQL {
    id: string
    user_id: bigint
    caption: string | null
    age: number
    ocr: string | null
    ocrverified: boolean
    disabled: boolean
    approved: boolean
    dmca: boolean
    url: string
    realm_id: number | null
    contest_id: number | null
    realmstatus: number
    created_at: Date
    updated_at: Date | null
}
