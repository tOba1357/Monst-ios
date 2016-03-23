import UIKit

class BoardSelectListView :UIView, BoardSelectViewDelegate {
    let boardList = [
        Board(name:"運極限定", url: "http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/3"),
        Board(name:"曜日・タス", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/33"),
        Board(name:"降臨攻略", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/4"),
        Board(name:"何でも", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/2"),
        Board(name:"神殿", url:"http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/12"),
        Board(name: "極みクエスト", url: "http://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/bbs/matching/threads/show/11")
    ]
    
    var selectedBoradIndex: Int?
    var boardViews: [BoardSelectView] = []

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    func onClickBoard(tag: Int) {
        if let index = self.selectedBoradIndex {
            self.boardViews[index].setCheckMarkToVisible(false)
        }
        self.selectedBoradIndex = tag
        self.boardViews[tag].setCheckMarkToVisible(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setViews() {
        self.boardList.enumerate().forEach{
            let frame = CGRect(x: 0, y: $0 * 40, width: Int(self.frame.width), height: 40)
            let boardSelectView = BoardSelectView(
                delegate: self,
                frame: frame,
                titleName: $1.name
            )
            boardSelectView.tag = $0
            self.addSubview(boardSelectView)
            self.boardViews.append(boardSelectView)
        }
    }
    
    internal func getSelectedBoard() -> Board? {
        if let index = self.selectedBoradIndex {
            return self.boardList[index]
        }
        return nil
    }
}
