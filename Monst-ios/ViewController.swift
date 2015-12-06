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
    let selectedBoardName = UILabel()
    let startSerachButton = UIButton()
    let boardList = [
        Board(name:"運極限定", url: "http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/3"),
        Board(name:"曜日・タス", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/33"),
        Board(name:"降臨攻略", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/4"),
        Board(name:"何でも", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/2"),
        Board(name:"神殿", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/12")
    ]
    var selectedBoard: Board?

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
        
        
        selectedBoardName.frame = CGRect(x: 10, y: 140, width: (viewWidht - 20), height: 50)
        selectedBoardName.text = "掲示板名"
        selectedBoardName.textAlignment = .Center
        selectedBoardName.font = UIFont.boldSystemFontOfSize(CGFloat(20))
        self.view.addSubview(selectedBoardName)
        
        
        startSerachButton.frame = CGRect(x: 0, y: (viewHeight - 70), width: viewWidht, height: 70)
        startSerachButton.setTitle("検索開始！", forState: .Normal)
        startSerachButton.addTarget(self, action: "onClickStartSearchButton:", forControlEvents: .TouchUpInside)
        startSerachButton.backgroundColor = UIColor.blackColor()
        self.view.addSubview(startSerachButton)
        
        setBoardButtons(190, buttom: (viewHeight - 200), width: (viewWidht - 20))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onClickStartSearchButton(sender: UIButton) {
        //TODO: maek func
        titleLabel.text = "check!";
    }
    
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func setBoardButtons(top: CGFloat, buttom: CGFloat, width: CGFloat) {
        let sumHeight = buttom - top
        let addHeigt = sumHeight / CGFloat(boardList.count)
        var height = top
        for board in boardList{
            let boardButton = UIButton()
            boardButton.frame = CGRect(x: 10, y: height, width: width, height: addHeigt)
            height += addHeigt
            boardButton.setTitleColor(UIColor.orangeColor(), forState:  UIControlState.Normal)
            boardButton.setTitle(board.name, forState: .Normal)
            boardButton.addTarget(self, action: "setSelectedBoardName:", forControlEvents: .TouchUpInside);
            self.view.addSubview(boardButton)
            board.setButton(boardButton)
        }
    }
   
    func setSelectedBoardName(sender: UIButton) {
        for board in boardList {
            if(board.getButton() == sender) {
                self.selectedBoard = board
            }
        }
        self.selectedBoardName.text = self.selectedBoard?.name;
    }
}

