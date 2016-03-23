import UIKit

protocol BoardSelectViewDelegate: NSObjectProtocol {
    func onClickBoard(tag: Int)
}

class BoardSelectView: UIView  {
    let checkImage = UIImage(named: "check")
    var checkImageView: UIImageView?
    var titleLabel: UILabel?
    var delegate: BoardSelectViewDelegate?
    
    init(delegate: BoardSelectViewDelegate ,frame: CGRect, titleName: String) {
        super.init(frame: frame)
        self.delegate = delegate
        
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
        self.titleLabel!.text = titleName
        self.titleLabel!.font = UIFont.systemFontOfSize(CGFloat(20))
        self.addSubview(self.titleLabel!)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onClickBoard:"))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onClickBoard(sender: UITapGestureRecognizer) {
        delegate?.onClickBoard(self.tag)
    }
    
    internal func setCheckMarkToVisible(visible: Bool) {
        self.checkImageView!.hidden = !visible
    }
}