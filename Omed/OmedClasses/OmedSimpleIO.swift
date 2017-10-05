//
//  OmedSimpleIO.swift
//  Omed
//
//  Created by Frank on 06/09/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import Foundation

class OmedSimpleIO {
    static func read() -> String {
        do {
            let path = Bundle.main.path(forResource: "file", ofType: "txt")
            if (path != nil) {
                let fileContents = try String(contentsOfFile: path! ,encoding: String.Encoding.utf8)
                return fileContents
            }
            else
            {
                let msg = "<File not found>"
                print(msg)
                return msg
            }
        }
        catch {
            let msg = "<Error finding path>"
            print(msg)
            return msg
        }
    }
}
