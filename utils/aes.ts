import crypto from 'crypto';

const cryptKeeperKey = process.env.CRYPT_KEY;
const cryptKeeperSalt = process.env.CRYPT_SALT;

function digestPassphrase() {
    const key = cryptKeeperKey;
    const salt = cryptKeeperSalt;
    const iterations = 5000;
    const digest = 'sha512';
    const digestLength = 64;

    if (!key || !salt) {
        throw new Error('Key and salt are required for passphrase digest');
    }

    return crypto.pbkdf2Sync(key, salt, iterations, digestLength, digest).toString('hex');
}

function convertCryptKey(strKey: string) {
    const newKey = Buffer.from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    const buffer: Buffer = Buffer.from(strKey)
    for (let i = 0; i < buffer.length; i++) newKey[i % 16] ^= buffer[i]
    return newKey
}

/**
 * Decrypts AES-encrypted Base64 input using the provided key and salt.
 * @param encryptedText - The Base64-encoded encrypted string.
 * @returns The decrypted plaintext.
 */
export function decryptAES(encryptedText: string) {
    const d = crypto.createDecipheriv('aes-128-ecb', convertCryptKey(digestPassphrase()), '')
    let ret = ''
    ret += d.update(encryptedText, 'base64', 'utf8')
    ret += d.final('utf8')
    return ret
}
