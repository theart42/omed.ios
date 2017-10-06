//
//  OmedSimpleJBdetect.swift
//  Omed
//
//  Created by Frank on 06/10/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import Foundation

public class OmedSimpleJBdetect {
    public static func detect() -> Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            //Simulator return false
            return false
        #else
            //Device do the checks
            let fm = FileManager()
            
            //Exist checks
            let filechecks = ["/Applications/Cydia.app", "/Library/MobileSubstrate/MobileSubstrate.dylib", "/bin/bash", "/usr/sbin/sshd", "/etc/apt", "/usr/bin/ssh"]
            
            for file in filechecks {
                if (fm.fileExists(atPath: file)){
                    return true
                }
                
                //Double check without FileManager
                let fp = fopen(file, "r")
                if (fp != nil) {
                    fclose(fp)
                    return true
                }
            }
            return false;
        #endif
    }
}
