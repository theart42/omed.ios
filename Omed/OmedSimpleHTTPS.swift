//
//  OmedSimpleHTTPS.swift
//  Omed
//
//  Created by Frank on 06/09/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import Foundation

class OmedSimpleHTTPS {
    static func request(completionBlock: @escaping (String) -> Void) -> Void {
        let url = URL(string: "https://2017.hack.lu/")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!, completionHandler: { data, response, error in
            if(error != nil) {
                print("Error: \(String(describing: error))")
            }
            else {
                completionBlock(String(data: data!, encoding: .utf8)!)
            }
        })
        task.resume()
    }
    
    static func requestPinned(completionBlock: @escaping (String) -> Void) -> Void {
        let url = URL(string: "https://2017.hack.lu/agenda/")
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: URLSessionPinningDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: url!, completionHandler: { data, response, error in
            if(error != nil) {
                completionBlock("Error: \(String(describing: error))")
            }
            else {
                completionBlock(String(data: data!, encoding: .utf8)!)
            }
        })
        task.resume()
    }
    
}

//
// https://stackoverflow.com/questions/34223291/ios-certificate-pinning-with-swift-and-nsurlsession
//
class URLSessionPinningDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        
        // Adapted from OWASP https://www.owasp.org/index.php/Certificate_and_Public_Key_Pinning#iOS
        
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType.invalid
                let status = SecTrustEvaluate(serverTrust, &secresult)
                
                if(errSecSuccess == status) {
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
                        let data = CFDataGetBytePtr(serverCertificateData);
                        let size = CFDataGetLength(serverCertificateData);
                        let cert1 = NSData(bytes: data, length: size)
                        let file_der = Bundle.main.path(forResource: "pinned", ofType: "cer")
                        
                        if let file = file_der {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if cert1.isEqual(to: cert2 as Data) {
                                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
    
}
