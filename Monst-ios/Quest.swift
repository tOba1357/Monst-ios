//
//  Quest.swift
//  Monst-ios
//
//  Created by Tatsuya Oba on 2015/12/07.
//  Copyright © 2015年 Tatsuya Oba. All rights reserved.
//

class Quest {
    let id: String
    let questName: String
    let url: String
    let time: String
    static let idStartTag = "<span class=\"bbs-post-number\">"
    static let idEndTag = "</span>"
    static let boadyStartTag = "<p class=\"bbs-post-body\">"
    static let boadyEndTag = "<p class=\"bbs-post-body\">"
    static let urlStartTag = "href='"
    static let urlEndTag = "'"
    static let questNameStartTag = "「"
    static let questNameEndTag = "」"
    static let timeStartTag = "<span class=\"bbs-posted-time\">"
    static let timeEndTag = "</span>"
    
    
    init(
        id: String,
        qusetName: String,
        url: String,
        time: String
    ) {
        self.id = id;
        self.questName = qusetName;
        self.url = url;
        self.time = time;
    }
    
    static func create(html: String) -> Quest? {
        let id = StringUtils.splitContentFromTag(html, startTag: idStartTag, endTag: idEndTag)
        let boady = StringUtils.splitContentFromTag(html, startTag: boadyStartTag, endTag: boadyEndTag)
        let url: String?;
        let questName: String?;
        if let boadyString = boady {
            url = StringUtils.splitContentFromTag(boadyString, startTag: "href='", endTag: "'")
            questName = StringUtils.splitContentFromTag(boadyString, startTag: questNameStartTag, endTag: questNameEndTag)
        } else {
            return nil;
        }
        let time = StringUtils.splitContentFromTag(html, startTag: timeStartTag, endTag: timeEndTag)
        switch (id, questName, url, time) {
        case (.Some(let id), .Some(let questName), .Some(let url), .Some(let time)) :
            return Quest(id: id, qusetName: questName, url: url, time: time)
        default:
            return nil;
        }
    }
    
    func toString() -> String {
        return"id:" + self.id + "\n"
            + "qusetName:" + self.questName + "\n"
            + "url:" + self.url + "\n"
            + "time:" + self.time + "\n"
    }
}