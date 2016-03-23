//
//  ViewController.swift
//  Monst-ios
//
//  Created by Tatsuya Oba on 2015/11/24.
//  Copyright © 2015年 Tatsuya Oba. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITextFieldDelegate {
    let titleLabel = UILabel()
    let questNameLabel = UITextField()
    let boardListLabel = UILabel()
    let selectedBoardLabel = UILabel()
    let isSearchLabel = UILabel()
    let startSerachButton = UIButton()
    let stopButton = UIButton()
    let webView = UIWebView()
    var selectedBoard: Board?
    var monstController: MonstController?
    let baseColor = UIColor.whiteColor()
    let mainColor = UIColor.init(red: 0, green: 0.3, blue: 1, alpha: 0.8)
    let accentColor = ColorUtils.ACCENT_COLOR

    var boardSelectListView: BoardSelectListView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewWidht = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        titleLabel.frame = CGRect(x: 0, y: 20, width: viewWidht, height: 70)
        titleLabel.text = "モンスト~クエスト検索~"
        titleLabel.font = UIFont.boldSystemFontOfSize(CGFloat(30))
        titleLabel.backgroundColor = mainColor
        titleLabel.textColor = ColorUtils.BASE_COLOR
        self.view.addSubview(titleLabel)

        questNameLabel.frame = CGRect(x: 10, y: 95, width: (viewWidht - 20), height: 50)
        questNameLabel.placeholder = "クエスト名"
        questNameLabel.layer.borderWidth = 1
        questNameLabel.layer.borderColor = ColorUtils.MAIN_COLOR.CGColor
        questNameLabel.returnKeyType = .Done
        questNameLabel.delegate = self
        self.view.addSubview(questNameLabel)
        
        
        boardListLabel.frame = CGRect(x: 30, y: 140, width: (viewWidht - 60), height: 50)
        boardListLabel.text = "掲示板リスト"
        boardListLabel.textAlignment = .Left
        boardListLabel.textColor = mainColor
        boardListLabel.font = UIFont.boldSystemFontOfSize(CGFloat(20))
        self.view.addSubview(boardListLabel)
        
        stopButton.frame = CGRect(x: 0, y: (viewHeight - 120), width: viewWidht, height: 60)
        stopButton.setTitle("STOP", forState: .Normal)
        stopButton.addTarget(self, action: "onCLickStopButton:", forControlEvents: .TouchUpInside)
        stopButton.hidden = true
        stopButton.backgroundColor = UIColor.redColor()
        self.view.addSubview(stopButton)

        self.boardSelectListView = BoardSelectListView(frame: CGRect(
            x: 20,
            y: 190,
            width: (viewWidht - 40),
            height: viewHeight - 200 - 190
        ))
        self.view.addSubview(self.boardSelectListView!)
        
        startSerachButton.frame = CGRect(x: 0, y: (viewHeight - 60), width: viewWidht, height: 60)
        startSerachButton.setTitle("検索開始！", forState: .Normal)
        startSerachButton.addTarget(self, action: "onClickStartSearchButton:", forControlEvents: .TouchUpInside)
        startSerachButton.backgroundColor = mainColor
        self.view.addSubview(startSerachButton)
        
        webView.frame = self.view.bounds
        webView.hidden = true
        self.view.addSubview(webView)
        
        self.monstController = MonstController(webView: webView, isSearchLabel: isSearchLabel, stopButton: stopButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onClickStartSearchButton(sender: UIButton) {
        if let board = self.boardSelectListView!.getSelectedBoard() {
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
    
    func onCLickStopButton(sender: UIButton) {
        self.monstController!.stopTimer()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
