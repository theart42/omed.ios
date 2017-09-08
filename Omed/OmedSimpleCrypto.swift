//
//  OmedSimpleCrypto.swift
//  Omed
//
//  Created by Frank on 08/09/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import Foundation

//
//  Cryptor.swift
//  Vektor
//
//  Created by Frank on 21/05/2017.
//  Copyright © 2017 Frank. All rights reserved.
//

import Foundation


class Cryptor {
    public static let encrypt = CCOperation(kCCEncrypt)
    public static let decrypt = CCOperation(kCCDecrypt)
    
    func cryptography(_ inputData: Data, key: String, operation: CCOperation) -> Data? {
        
        //prepare the Key
        let keyData = key.data(using: .utf8, allowLossyConversion: false)!
        let keyLength = kCCKeySizeAES128
        
        //Prepare the input data
        
        //Check whether this is encryption , if so generate a random  IV and append this to the encrypted data
        let ivData :Data
        let data: Data
        if operation == CCOperation(kCCEncrypt) {
            // ivData = self.generateIV()
            ivData = Data(repeating: 0, count: 16)
            data = inputData
        } else {
            //for decryption the last 16 bytes will be the IV so extract it
            let rangStart = inputData.count - kCCBlockSizeAES128
            let rangeEnd = inputData.count
            ivData = inputData.subdata(in: rangStart..<rangeEnd)
            data = inputData.subdata(in: 0..<rangStart)
        }
        let dataLength = data.count
        
        //Calculate buffer details
        var bufferData       = Data(count: dataLength + kCCBlockSizeAES128)
        let bufferLength     = bufferData.count
        
        var bytesDecrypted   = 0
        let cryptStatus = keyData.withUnsafeBytes {keyBytes in
            ivData.withUnsafeBytes {ivBuffer in
                data.withUnsafeBytes {dataBytes in
                    bufferData.withUnsafeMutableBytes {bufferPointer in
                        CCCrypt(
                            operation,                      // Operation
                            CCAlgorithm(kCCAlgorithmAES128),   // Algorithm is AES
                            CCOptions(kCCOptionPKCS7Padding), //options
                            keyBytes,                       // key data
                            keyLength,                      // key length
                            ivBuffer,                            // IV buffer
                            dataBytes,                      // input data
                            dataLength,                     // input length
                            bufferPointer,                  // output buffer
                            bufferLength,                   // output buffer length
                            &bytesDecrypted)                // output bytes decrypted real length
                    }
                }
            }
        }
        
        if cryptStatus == Int32(kCCSuccess) {
            bufferData.count = bytesDecrypted // Adjust buffer size to real bytes
            if operation == CCOperation(kCCEncrypt) {
                bufferData.append(ivData)
            }
            return bufferData
        } else {
            print("Error in crypto operation: \(cryptStatus)")
            return nil
        }
    }
}

class OmedSimpleCrypto {
    public static func read() -> String {
        let c = Cryptor()
        var msg = Bundle.main.infoDictionary!["CFBundleName"] as! String
        msg = msg + " crypt decrypted"
        let key = randomAlphaNumericString(length: 16)
        
        let enc = c.cryptography(msg.data(using: .utf8)!, key: key, operation: Cryptor.encrypt)
        let dec = c.cryptography(enc!, key: key, operation: Cryptor.decrypt)
        return String(data: dec!, encoding: .utf8)!
    }
    
    private static func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
}
