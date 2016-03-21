//
//  QuestSelectView.swift
//  Monst-ios
//
//  Created by Tatsuya Oba on 2016/03/21.
//  Copyright © 2016年 Tatsuya Oba. All rights reserved.
//

import UIKit

protocol BoardSelectViewDelegate: NSObjectProtocol {
    func onClickBoard(board: Board, selected: Bool)
}

class BoardSelectView: UIView  {
    let checkImage = UIImage(named: "check")
    var checkImageView: UIImageView?
    var titleLabel: UILabel?
    var board: Board?
    var delegate: BoardSelectViewDelegate?
    
    var selected: Bool = false
    
    init(delegate: BoardSelectViewDelegate ,frame: CGRect, board: Board) {
        super.init(frame: frame)
        self.delegate = delegate
        self.board = board
        
        self.checkImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.checkImageView!.image = self.checkImage
        self.checkImageView!.hidden = true
        self.addSubview(self.checkImageView!)
       
        
        self.titleLabel = UILabel(frame: CGRect(
            x: 25,
            y: 0,
            width: self.frame.width - 25,
            height: 20
        ))
        self.titleLabel!.textColor = ColorUtils.ACCENT_COLOR
        self.titleLabel!.text = board.name
        self.titleLabel!.font = UIFont.systemFontOfSize(CGFloat(20))
        self.addSubview(self.titleLabel!)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onClickBoard:"))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onClickBoard(sender: UITapGestureRecognizer) {
        self.selected = !self.selected
        setCheckMarkToVisible(self.selected)
        delegate?.onClickBoard(self.board!, selected: self.selected)
    }
    
    func setCheckMarkToVisible(visible: Bool) {
        self.checkImageView!.hidden = !visible
    }
}