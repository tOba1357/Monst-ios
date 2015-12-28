//
//  ViewController.swift
//  Monst-ios
//
//  Created by Tatsuya Oba on 2015/11/24.
//  Copyright © 2015年 Tatsuya Oba. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    let titleLabel = UILabel()
    let questNameLabel = UITextField()
    let boardListLabel = UILabel()
    let selectedBoardLabel = UILabel()
    let startSerachButton = UIButton()
    let webView = UIWebView()
    let boardList = [
        Board(name:"運極限定", url: "http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/3"),
        Board(name:"曜日・タス", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/33"),
        Board(name:"降臨攻略", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/4"),
        Board(name:"何でも", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/2"),
        Board(name:"神殿", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/12")
    ]
    var selectedBoard: Board?
    var monstController: MonstController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewWidht = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        titleLabel.frame = CGRect(x: 10, y: 0, width: viewWidht, height: 70)
        titleLabel.text = "モンスト~クエスト検索~"
        titleLabel.font = UIFont.boldSystemFontOfSize(CGFloat(30))
        self.view.addSubview(titleLabel)

        questNameLabel.frame = CGRect(x: 10, y: 80, width: (viewWidht - 20), height: 50)
        questNameLabel.placeholder = "クエスト名"
        questNameLabel.layer.borderWidth = 1
        self.view.addSubview(questNameLabel)
        
        
        boardListLabel.frame = CGRect(x: 30, y: 140, width: (viewWidht - 60), height: 50)
        boardListLabel.text = "掲示板リスト"
        boardListLabel.textAlignment = .Left
        boardListLabel.font = UIFont.boldSystemFontOfSize(CGFloat(20))
        self.view.addSubview(boardListLabel)
        
        
        startSerachButton.frame = CGRect(x: 0, y: (viewHeight - 70), width: viewWidht, height: 70)
        startSerachButton.setTitle("検索開始！", forState: .Normal)
        startSerachButton.addTarget(self, action: "onClickStartSearchButton:", forControlEvents: .TouchUpInside)
        startSerachButton.backgroundColor = UIColor.blackColor()
        self.view.addSubview(startSerachButton)
        
        webView.frame = self.view.bounds
        webView.hidden = true
        self.view.addSubview(webView)
        
        setBoardButtons(190, buttom: (viewHeight - 200), width: viewWidht - 40)
        self.monstController = MonstController(webView: webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onClickStartSearchButton(sender: UIButton) {
        if let board = self.selectedBoard {
            monstController!.startSearch(board.url, questName: questNameLabel.text!)
        } else {
            let alertController = UIAlertController(title: "エラー", message: "クエストを選択してください。", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func setBoardButtons(top: CGFloat, buttom: CGFloat, width: CGFloat) {
        let addHeight = CGFloat(40)
        var height = top
        for board in boardList{
            let boardButton = UIButton()
            boardButton.frame = CGRect(x: 40, y: height, width: width, height: addHeight)
            height += addHeight
            boardButton.setTitleColor(UIColor.orangeColor(), forState:  UIControlState.Normal)
            boardButton.setTitle(board.name, forState: .Normal)
            boardButton.contentHorizontalAlignment = .Left
            boardButton.addTarget(self, action: "setSelectedBoardName:", forControlEvents: .TouchUpInside);
            self.view.addSubview(boardButton)
            board.setButton(boardButton)
        }
        selectedBoardLabel.frame = CGRect(x: 40, y: height, width: width, height: addHeight)
        selectedBoardLabel.font = UIFont.boldSystemFontOfSize(CGFloat(20))
        selectedBoardLabel.text = "選択中："
        self.view.addSubview(selectedBoardLabel)
    }
   
    func setSelectedBoardName(sender: UIButton) {
        for board in boardList {
            if(board.getButton() == sender) {
                self.selectedBoard = board
            }
        }
        if let boardName = self.selectedBoard?.name {
            self.selectedBoardLabel.text = "選択中：" + boardName;
        }
        self.view.endEditing(true)
    }
}

//