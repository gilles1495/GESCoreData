//
//  FileUtils.swift
//  GESCoreData
//
//  Created by gilles Goncalves on 18/04/2017.
//  Copyright © 2017 gilles et julien. All rights reserved.
//

import Foundation
import UIKit

class FileUtils: NSObject {

    class func getDocumentDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }
    
    class func getDocumentFile(at path: String)-> URL{
        let parent = self.getDocumentDirectory()
        return parent.appendingPathComponent(path)
    }
    
    class func afficheMsg(label:UILabel, msg:String, color: UIColor){
        label.text = msg
        label.textColor = color
    }
}
