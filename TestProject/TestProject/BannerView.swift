//
//  InAppView.swift
//  REIOSSDK
//
//  Created by Sivakumar on 11/6/18.
//  Copyright © 2018 Interakt. All rights reserved.
//

import UIKit
import AVKit
import WebKit

class NewBanner: UIView{
    
    let bannerStyle = 0
    let  isHeader = true
    let isFooter = true
    let isAlertBtn = true
    let isDismissBtn = true
    let bodyContentIndex = 4
    var newWebView = UIView()
    var carouselArray = ["A","B","C","D"]
    
    let topBannerView:UIView = {
        let _view = UIView()
        _view.backgroundColor = .white
        _view.layer.cornerRadius = 10.0
        _view.layer.borderWidth = 2.0
        _view.layer.borderColor = UIColor.blue.cgColor
        _view.translatesAutoresizingMaskIntoConstraints = false
        
        return _view
    }()
    
    let fullScreenContainerView:UIView = {
        let _view = UIView()
        _view.translatesAutoresizingMaskIntoConstraints = false
        
        return _view
    }()
    
    let containerStackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.axis = .vertical
        _stackView.alignment = .fill
        _stackView.distribution = .fillProportionally
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        return _stackView
    }()
    
    let closeButton:UIButton = {
        let  _btn = UIButton()
        _btn.backgroundColor = .green
        _btn.setTitleColor(.white, for: .normal)
        _btn.setTitle("X", for: .normal)
        _btn.layer.cornerRadius = 5.0
        _btn.translatesAutoresizingMaskIntoConstraints = false
        _btn.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        
        return _btn
    }()
    
    let headerView:UIView = {
        let _view = UIView()
        _view.backgroundColor = .gray
        _view.translatesAutoresizingMaskIntoConstraints = false
        
        return _view
    }()
    
    var bodyView:UIView = {
        let _view = UIView()
        _view.backgroundColor = .black
        _view.translatesAutoresizingMaskIntoConstraints = false
        
        return _view
    }()
    
    let footerView:UIView = {
        let _view = UIView()
        _view.backgroundColor = .darkGray
        _view.translatesAutoresizingMaskIntoConstraints = false
        
        return _view
    }()
    
    let headerLbl: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.text = "default  text"
        
        return _label
    }()
    
    let bodyImage:UIImageView = {
        let  _img = UIImageView()
        let logoImg = UIImage(named: "red")
        _img.image = logoImg
        _img.translatesAutoresizingMaskIntoConstraints = false
        _img.contentMode = .scaleAspectFit
        
        return _img
    }()
    
    let buttonStackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.axis = .horizontal
        _stackView.alignment = .fill
        _stackView.distribution = .fillEqually
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.spacing = 5.0
        return _stackView
    }()
    
    let alertButton:UIButton = {
        let  _btn = UIButton()
        _btn.backgroundColor = .blue
        _btn.setTitleColor(.white, for: .normal)
        _btn.setTitle("Alert", for: .normal)
        _btn.layer.cornerRadius = 5.0
        _btn.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        
        return _btn
    }()
    
    let dismissButton:UIButton = {
        let  _btn = UIButton()
        _btn.backgroundColor = .blue
        _btn.setTitleColor(.white, for: .normal)
        _btn.setTitle("Dismiss", for: .normal)
        _btn.layer.cornerRadius = 5.0
        _btn.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        
        return _btn
    }()
    
    let playButton:UIButton = {
        let  _btn = UIButton()
        _btn.translatesAutoresizingMaskIntoConstraints = false
        _btn.backgroundColor = .blue
        _btn.setTitleColor(.white, for: .normal)
        _btn.setTitle("Play", for: .normal)
        _btn.layer.cornerRadius = 5.0
        _btn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        
        return _btn
    }()
    
    let carousel: CarouselView = {
        let _carousel = CarouselView()
        
        return _carousel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        
        self.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2)
        carousel.myNewDelegate = self as? CarouselViewDelegate
        carousel.dataSource = self as? CarouselViewDataSourse

        setupBannerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            self.removeFromSuperview()
        }
        return hitView
    }
    
    func setupBannerView() {
        
        self.addSubview(topBannerView)
        topBannerView.backgroundColor = .blue
        
        topBannerView.anchor(top: nil, trailing: self.trailingAnchor, bottom: nil, leading: self.leadingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 5), size: .zero)
        topBannerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        
        if bannerStyle == 0 {
            topBannerView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        } else if bannerStyle == 1 {
            topBannerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        } else if bannerStyle == 2 {
            topBannerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        }  else {
            topBannerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 95).isActive = true
            topBannerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        }
        
        topBannerView.addSubview(closeButton)
        closeButton.anchor(top: topBannerView.topAnchor, trailing: topBannerView.trailingAnchor, bottom: nil, leading: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 5), size: .init(width: 25, height: 25))
        
        setupStackView()
    }
    
    func setupStackView() {
        setupHeaderView()
        setupFooterView()
        setupBodyView()
    }
    
    func setupHeaderView() {
        
        topBannerView.addSubview(headerView)
        headerView.addSubview(headerLbl)
        headerView.anchor(top: closeButton.bottomAnchor, trailing: topBannerView.trailingAnchor, bottom: nil, leading: topBannerView.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 0, height: 50))
        
        headerView.addSubview(headerLbl)
        headerLbl.fillSuperView(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        if !isHeader {
            hideHeader()
        }
    }
    
    func hideHeader() {
        headerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        headerLbl.isHidden = true
    }
    
    func setupBodyView() {
        
        topBannerView.addSubview(bodyView)
        bodyView.anchor(top: headerView.bottomAnchor, trailing: topBannerView.trailingAnchor, bottom: footerView.topAnchor, leading: topBannerView.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .zero)
        
        switch bodyContentIndex {
            
        case 0:
            loadImage()
        case 1:
            loadGif()
        case 2:
            loadVideoPlayer()
        case 3:
            loadWebview()
        case 4:
            loadCarousel()
        default:
            print("nothing to show")
        }
    }
    
    func loadImage() {
        
        bodyView.addSubview(bodyImage)
        bodyImage.anchor(top: bodyView.topAnchor, trailing: bodyView.trailingAnchor, bottom: bodyView.bottomAnchor, leading: bodyView.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .zero)
        bodyImage.imageFromServerURL(urlString: "https://run.resulticks.com//SocialMediaPostPicture/Temp/a9c29d3f-2430-47a1-aa7c-31743c7063cc.jpeg")
    }
    
    func loadGif() {
        
        bodyView.addSubview(bodyImage)
        bodyImage.anchor(top: bodyView.topAnchor, trailing: bodyView.trailingAnchor, bottom: bodyView.bottomAnchor, leading: bodyView.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .zero)
        
        DispatchQueue.global().async { [weak self] in
            let gifURL : String = "https://media.giphy.com/media/l0ErBTfnwCom6mFPi/giphy.gif"
            let imageURL = UIImage.gifImageWithURL(gifUrl: gifURL)
            
            DispatchQueue.main.async {
                self?.bodyImage.image = imageURL
            }
        }
    }
    func loadCarousel() {
       
        carousel.cellPerPage = 1;
        carousel.backgroundColor = .systemOrange
        carousel.frame = bodyView.frame
        carousel.myNewDelegate = self
        carousel.dataSource = self
        carousel.reload()
        bodyView.addSubview(carousel)
        carousel.anchor(top: bodyView.topAnchor, trailing: bodyView.trailingAnchor, bottom: bodyView.bottomAnchor, leading: bodyView.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .zero)
        
        
        
//        let _controller = CarouselContainerViewController()
//        _controller.view.backgroundColor = .green
        
        
        
//        topMostController()?.addChild(_controller)
//        //_controller.view.frame = bodyView.frame
//        topMostController()?.view.addSubview(_controller.view)
//        _controller.didMove(toParent: topMostController())
//       bodyView.addSubview(_controller.view)
//
//        _controller.view.anchor(top: bodyView.topAnchor, trailing: bodyView.trailingAnchor, bottom: bodyView.bottomAnchor, leading: bodyView.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .zero)
         //carousel.reload()
        
        
    }
    func loadVideoPlayer() {
        
        bodyView.addSubview(playButton)
        bodyView.bringSubviewToFront(playButton)
        playButton.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        playButton.anchor(top: bodyView.topAnchor, trailing: bodyView.trailingAnchor, bottom: bodyView.bottomAnchor, leading: bodyView.leadingAnchor, padding: .zero, size: .zero)
    }
    
    @objc func playVideo() {
        
        guard let videoUrl =  URL(string: "https://www.radiantmediaplayer.com/media/bbb-360p.mp4") else { return }
        
        let player = AVPlayer(url: videoUrl)
        let vc = AVPlayerViewController()
        vc.player = player
        
        topMostController()?.addChild(vc)
        topMostController()?.view.addSubview(vc.view)
        vc.didMove(toParent: topMostController())
        vc.player?.play()
        
        bodyView.addSubview(vc.view)
        vc.view.anchor(top: bodyView.topAnchor, trailing: bodyView.trailingAnchor, bottom: bodyView.bottomAnchor, leading: bodyView.leadingAnchor, padding: .init(top: 3, left: 3, bottom: 3, right: 3), size: .zero)
    }
    
    func loadWebview() {
        
        var webView: WKWebView!
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        bodyView.addSubview(webView)
        webView.anchor(top: bodyView.topAnchor, trailing: bodyView.trailingAnchor, bottom: bodyView.bottomAnchor, leading: bodyView.leadingAnchor, padding: .init(top: 3, left: 3, bottom: 3, right: 3), size: .zero)
        if let url = URL(string: "https://www.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func setupFooterView() {
        
        topBannerView.addSubview(footerView)
        footerView.anchor(top: nil, trailing: topBannerView.trailingAnchor, bottom: topBannerView.bottomAnchor, leading: topBannerView.leadingAnchor, padding: .init(top: 0, left: 5, bottom: 5, right: 5), size: .init(width: 0, height: 50))
        footerView.addSubview(buttonStackView)
        
        buttonStackView.anchor(top: footerView.topAnchor, trailing: footerView.trailingAnchor, bottom: footerView.bottomAnchor, leading: footerView.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .zero)
        
        if isAlertBtn {
            buttonStackView.addArrangedSubview(alertButton)
        }
        if isDismissBtn {
            buttonStackView.addArrangedSubview(dismissButton)
        }
        
        if !isFooter || (!isDismissBtn && !isAlertBtn) {
            hiderFooter()
        }
    }
    
    func hiderFooter() {
        footerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        buttonStackView.isHidden = true
    }
    
    @objc func closePopup() {
        print("closing popup")
        self.removeFromSuperview()
    }
    
    func topMostController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        return topController
    }
    
}

extension NewBanner : CarouselViewDelegate,CarouselViewDataSourse {
    func numberOfView(_ carousel: CarouselView) -> Int {
        return carouselArray.count
    }
    func carousel(_ carousel:CarouselView, didTapAt cell:Int){
        print("Select Index \(cell)")
    }
    func carousel(_ carousel: CarouselView, viewForIndex index: Int) -> UIView? {
        let padding:CGFloat = 20
        let v = UIView()
        v.backgroundColor = UIColor.orange
        
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = carouselArray[index]
        label.backgroundColor = UIColor.purple
        v.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let w = label.heightAnchor.constraint(equalTo: v.widthAnchor, multiplier: 1, constant: -padding * 2)
        let h = label.widthAnchor.constraint(equalTo: v.heightAnchor, multiplier: 1, constant: -padding * 2)
        let cx = label.centerXAnchor.constraint(equalTo: v.centerXAnchor)
        let cy = label.centerYAnchor.constraint(equalTo: v.centerYAnchor)
        
        NSLayoutConstraint.activate([w, h, cx, cy])
        v.layer.borderColor = UIColor.red.cgColor
        v.layer.borderWidth = 10
        return v
    }
    
    
}

extension UIImage {
    
    public class func gifImageWithData(data: NSData) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source: source)
    }
    
    public class func gifImageWithURL(gifUrl:String) -> UIImage? {
        guard let bundleURL = NSURL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL as URL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a!
            a = b!
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b!
                b = rest
            }
        }
    }
    
    class func gcdForArray(array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(a: val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(index: Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(array: delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

class WebviewContainerController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        var webView: WKWebView!
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
        
        let request = URLRequest(url: URL(string: "https://learnappmaking.com")!)
        webView.load(request)
        
    }
    
}

// MARK: Constraints extension

extension UIView {
    
    func fillSuperView(padding: UIEdgeInsets) {
        anchor(top: superview?.topAnchor, trailing: superview?.trailingAnchor, bottom: superview?.bottomAnchor, leading: superview?.leadingAnchor, padding: .init(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right), size: .zero)
        
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, padding: UIEdgeInsets, size: CGSize) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let _top = top {
            topAnchor.constraint(equalTo: _top, constant: padding.top).isActive = true
        }
        if let _trailing = trailing {
            trailingAnchor.constraint(equalTo: _trailing, constant: -padding.right).isActive = true
        }
        if let _bottom = bottom {
            bottomAnchor.constraint(equalTo: _bottom, constant: -padding.bottom).isActive = true
        }
        if let _leading = leading {
            leadingAnchor.constraint(equalTo: _leading, constant: padding.left).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

//extension UNNotificationAttachment {
//
//    static func create(identifier: String, image: UIImage, options: [NSObject : AnyObject]?, type: String) -> UNNotificationAttachment? {
//        let fileManager = FileManager.default
//        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
//        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
//        do {
//            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
//            let imageFileIdentifier = identifier+".\(type)"
//            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
//            guard let imageData = image.UIImageJPEGRepresentation(compressionQuality: 0.8) else {
//                return nil
//            }
//            try imageData.write(to: fileURL)
//            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: options)
//            return imageAttachment
//        } catch {
//            print("error " + error.localizedDescription)
//        }
//        return nil
//    }
//}

extension UIImageView {
    
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}

extension CarouselDelegate {
    func carouselWillInstall(cell: CarouselCell) {
    
    }
    func carouselWillUninstall(cell: CarouselCell) {
        
    }
    
    func carouselDidInstall(cell: CarouselCell) {
        
    }
    
    func carouselDidUninstall(cell: CarouselCell) {
        
    }
    
    func carouselScroll(from: Int, to: Int, progress: CGFloat) {
        
    }
    
    func carouselDidScroll(from: Int, to: Int) {
        
    }
    
    func carouselDidScroll() {
        
    }
    
    func carouselWillBeginDragging() {
        
    }
    
    func carouselDidEndDraggingWillDecelerate(_ decelerate: Bool) {
        
    }
    
    func carouselWillBeginDecelerating() {
        
    }
    
    func carouselDidEndDecelerating() {
        
    }
    
    func carouselDidEndScrollingAnimation() {
        
    }
    
    func carouselDidTap(cell: CarouselCell) {
        
    }
}

class CarouselContainerViewController: UIViewController, MyViewDelegate, CarouselViewDataSourse, CarouselViewDelegate {
    func numberOfView(_ carousel: CarouselView) -> Int {
        return 10
    }
    
    func carousel(_ carousel: CarouselView, viewForIndex index: Int) -> UIView? {
        let padding:CGFloat = 20
        let v = UIView()
        v.backgroundColor = UIColor.orange
        
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "P \(index)"
        label.backgroundColor = UIColor.purple
        v.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let w = label.heightAnchor.constraint(equalTo: v.widthAnchor, multiplier: 1, constant: -padding * 2)
        let h = label.widthAnchor.constraint(equalTo: v.heightAnchor, multiplier: 1, constant: -padding * 2)
        let cx = label.centerXAnchor.constraint(equalTo: v.centerXAnchor)
        let cy = label.centerYAnchor.constraint(equalTo: v.centerYAnchor)
        
        NSLayoutConstraint.activate([w, h, cx, cy])
        v.layer.borderColor = UIColor.red.cgColor
        v.layer.borderWidth = 10
        return v
    }
    
        
     let sliderView = CarouselView.init(frame: CGRect(x: 10, y: 10, width: 300, height: 300))
    
    override func viewDidLoad() {
        
        view.backgroundColor = .red
//        setupMyViewButton()
        setupSliderView()
    }
    
    func setupSliderView() {
        
       
        sliderView.backgroundColor = .blue
       sliderView.cellPerPage = 1

        //        carousel = CarouselView.init(frame: view.bounds)
        //        view.addSubview(carousel)
                sliderView.type = .linear
        sliderView.dataSource = self
        sliderView.myNewDelegate = self
                sliderView.pagingType = .cellLimit
                sliderView.reload()
        view.addSubview(sliderView)
    }
    
    func setupMyViewButton() {
        let myview = MyView(frame: view.frame)
        myview.delegate = self as MyViewDelegate
        view.addSubview(myview)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func didClickButton() {
        print("My button clicked")
    }
    
    func numberOfCell() -> Int{
        return 10
    }
    func cellForIndex(_ index:Int) -> UIView?{
        let padding:CGFloat = 20
        let v = UIView()
        v.backgroundColor = UIColor.orange
        
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "P \(index)"
        label.backgroundColor = UIColor.purple
        v.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let w = label.heightAnchor.constraint(equalTo: v.widthAnchor, multiplier: 1, constant: -padding * 2)
        let h = label.widthAnchor.constraint(equalTo: v.heightAnchor, multiplier: 1, constant: -padding * 2)
        let cx = label.centerXAnchor.constraint(equalTo: v.centerXAnchor)
        let cy = label.centerYAnchor.constraint(equalTo: v.centerYAnchor)
        
        NSLayoutConstraint.activate([w, h, cx, cy])
        v.layer.borderColor = UIColor.red.cgColor
        v.layer.borderWidth = 10
        return v
    }

}

public protocol MyViewDelegate: class {
    func didClickButton()
}


class MyView: UIView {
    
    weak var delegate: MyViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 70))
        button.setTitle("Green day", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchDown)
        button.backgroundColor = .blue
        self.addSubview(button)
    }
    
    @objc
    func buttonAction() {
        delegate?.didClickButton()
    }
}

