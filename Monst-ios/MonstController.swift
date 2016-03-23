//
//  MonstCOnt.swift
//  Monst-ios
//
//  Created by Tatsuya Oba on 2015/12/06.
//  Copyright © 2015年 Tatsuya Oba. All rights reserved.
//

import Alamofire
import APIKit

protocol MonstControllerDelegate: NSObjectProtocol {
    func onEndSearch()
}


class MonstController: NSObject {
    let delegate: MonstControllerDelegate?
    let webView: UIWebView
    
    var url: String = ""
    var questName: String = ""
    
    var timer: NSTimer?
    var task: NSURLSessionDataTask?
    
    var questList: [Quest] = []
    let questListTag = "<div id=\"bbs-posts\""
    let questDivTag = "<div class=\"bbs-post bbs-content\""
    
    var cal: [String] = []
    
    init(delegate: MonstControllerDelegate, webView: UIWebView) {
        self.webView = webView
        self.delegate = delegate
    }
    
    func startSearch(url: String ,questName: String) {
        self.questName = questName
        self.url = url
        
        if (!isRunTask()) {
            searchQuest()
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "searchQuest", userInfo: nil, repeats: true)
        }
    }
    
    func searchQuest() {
        if (self.task != nil) {
            return
        }
        self.questList = []
        let url:NSURL = NSURL(string: self.url)!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        self.task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, err) in
            if(err == nil) {
                self.questList = self.splitQuest(String(data: data!, encoding: NSUTF8StringEncoding)!)
            
                let jumpQuest =  self.questList
                    .filter({(quest: Quest) -> Bool in
                        if let questIndex = quest.questName.rangeOfString(self.questName) {
                            return !questIndex.isEmpty
                        }
                        return false
                    })
                    .filter({(quest: Quest) -> Bool in quest.time == "数秒前"}).first
            
                if let quest = jumpQuest {
                    self.stopTimer()
                    let request = NSURLRequest(URL: NSURL(string: quest.url)!)
                    self.webView.loadRequest(request)
                }
                self.task = nil
            } else {
                print(err)
            }
        })
        if let task = self.task {
            task.resume()
        }
    }
    
    func stopTimer() {
        if isRunTask() {
            self.timer?.invalidate()
        }
        self.delegate?.onEndSearch()
    }
    
    func isRunTask() -> Bool {
        if let timer = self.timer {
            if timer.valid {
                return true
            }
        }
        return false
    }
    
    func fomatData(res:NSURLResponse?,data:NSData?,error:NSError?) {
        let myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        print(myData)
    }
    
    func splitQuest(html: String) -> [Quest] {
        var questList: [Quest] = []
        let startIndex = html.rangeOfString(questListTag)?.startIndex.advancedBy(questListTag.utf16.count)
        let tmp = html.substringFromIndex(startIndex!)
        let quetIndexes = tmp.rangeOfString(questDivTag)
        for index in quetIndexes! {
            let questHtml = tmp.substringFromIndex(index)
            if let quest = Quest.create(questHtml) {
                questList.append(quest)
            }
        }
        return questList
    }
}