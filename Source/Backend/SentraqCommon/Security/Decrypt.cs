using System.Security.Cryptography;
using System.Text;

namespace SentraqCommon.Security;

public static class Decrypt
{
    /// <summary>
    /// Decrypt a string which was encrypted by the same algorithm
    /// into a clear-text string using a password.
    /// Encryption has to be done using the Hr.RijndaelTextEncryption 
    /// </summary>
    /// <param name="t">encrypted text to decrypt</param>
    /// <param name="pwd">password used to encrypt text (as clear text)</param>
    /// <returns></returns>
    public static string Text(string t, string pwd)
    {
        var cipherBytes = Convert.FromBase64String(t);

        PasswordDeriveBytes pdb = new PasswordDeriveBytes(pwd,
            new byte[] {
                0x49, 0x23, 0x62, 0x6e, 0x12, 0x4d, 0x65, 0x66, 0x91, 0x34, 0x64, 0x10, 0x77
            });

        var decryptedData = DecryptData(cipherBytes,
            pdb.GetBytes(32), pdb.GetBytes(16));

        return Encoding.Unicode.GetString(decryptedData);
    }

    /// <summary>
    /// <para>Decrypts a password within a database ConnectionString.</para>
    /// <para>Example connStr with encrypted password: Data Source=sql_local; Initial Catalog=mydatabase;User ID=db_user; Password=SokIanR1EgtWIUxZQIKEMjJnY/PErtqYwv0lYoBU3zU=;</para>
    /// <para>Result connStr with decrypted password: Data Source=sql_local; Initial Catalog=mydatabase;User ID=db_user; Password=MyPassword001;</para>
    /// </summary>
    /// <param name="connectionString">ConnectionString that must contain one element of 'Password=' with base64 decoded encrypted text.</param>
    /// <param name="pwd">Password (plain) used to decrypt the password contained in the ConnectionString</param>
    /// <param name="passwordElement">Name of the password element to search for, default 'Password'.</param>
    /// <returns>ConnectionString with plain (decrypted) password</returns>
    public static string PasswordInConnectionString(string connectionString, string pwd, string passwordElement = "Password")
    {
        var encryptedPwd = string.Empty;

        var elems = connectionString.Split(';');
        foreach (var elem in elems)
        {
            if (elem.ToLower().Trim().StartsWith(passwordElement.ToLower().Trim()))
            {
                if (elem.Contains("="))
                    encryptedPwd = elem.Trim().Substring(elem.Trim().IndexOf("=") + 1).Trim();
            }
        }

        if (!string.IsNullOrWhiteSpace(encryptedPwd))
            return connectionString.Replace(encryptedPwd, Text(encryptedPwd, pwd));
        else
            return connectionString;
    }

    // Decrypt a byte array into a byte array using a key and an IV 
    private static byte[] DecryptData(byte[] cipherData, byte[] Key, byte[] IV)
    {
        var ms = new MemoryStream();

        var alg = Rijndael.Create();

        alg.Key = Key;
        alg.IV = IV;

        var cs = new CryptoStream(ms,
            alg.CreateDecryptor(), CryptoStreamMode.Write);

        cs.Write(cipherData, 0, cipherData.Length);

        cs.Close();

        var decryptedData = ms.ToArray();

        return decryptedData;
    }
}