//
//  StringUtils.swift
//  Monst-ios
//
//  Created by Tatsuya Oba on 2015/12/07.
//  Copyright © 2015年 Tatsuya Oba. All rights reserved.
//

class StringUtils {
    static func splitContentFromTag(html: String, startTag: String, endTag: String) -> String? {
        if let startIndex = html.rangeOfString(startTag)?.startIndex.advancedBy(startTag.utf16.count) {
            let tmpString = html.substringFromIndex(startIndex)
            if let endIndex = tmpString.rangeOfString(endTag)?.startIndex {
                return tmpString.substringToIndex(endIndex)
            }
        }
        return nil
    }
}