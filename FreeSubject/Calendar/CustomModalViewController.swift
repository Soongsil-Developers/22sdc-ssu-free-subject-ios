//
//  TestViewControlle.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/09/01.
//

import UIKit
import SnapKit
import RealmSwift

class CustomModalViewController: UIViewController{


    // 모달창에 뜨는 부분 날짜 표기
    var Date:String = ""
    var isToday:Bool = false
    
    // define lazy views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.74, green: 0.85, blue: 0.78, alpha: 1.00)
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
        // 나중에 선택한 날로 변결
        label.text = "\(Date)의 하루"
        label.font = UIFont(name: "Avenir-Black", size: 15)
        return label
    }()
    
    // icon default
    var imageFeeling = UIImageView(image: UIImage(named: "Happy"))
    var imageDidGetMedicine = UIImageView(image: UIImage(named: "약미복용"))
    var sleepTimeString = "00:00"
    lazy var imageSleepTime :UILabel = {
        let label = UILabel()
        label.text = self.sleepTimeString
        label.font = UIFont(name: "Avenir-Black", size: 23)
        return label
    }()
    
    
    lazy var iconView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.74, green: 0.85, blue: 0.78, alpha: 1.00)
        view.layer.cornerRadius = 16
        return view
    }()
    lazy var iconView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.74, green: 0.85, blue: 0.78, alpha: 1.00)
        view.layer.cornerRadius = 16
        return view
    }()
    lazy var iconView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.74, green: 0.85, blue: 0.78, alpha: 1.00)
        view.layer.cornerRadius = 16
        
        return view
    }()

    
    // half-modal 뷰
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.alpha = 1.0
        return view
    }()

    lazy var ButtonForNextView: UIButton = {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load2"), object: self.Date)
        var btn = UIButton()
        btn.setTitle("확인하기", for: .normal)
        btn.titleLabel?.font =  UIFont(name: "Avenir-Black", size: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(red: 0.49, green: 0.65, blue: 0.56, alpha: 1.0)
        btn.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
    
        return btn
    }()
    
    
    // Constants
    let defaultHeight: CGFloat = 300   // 처음 half-modal 이 올라오는 높이
    let dismissibleHeight: CGFloat = 150   // half-modal 없어지는 높이
    let maximumContainerHeight: CGFloat = 600  // half-modal 최대로 끌어올리는 높이
    // UIScreen.main.bounds.height - 100
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        read()
        print(isToday)
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupView()
        setupConstraints()
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        containerView.addGestureRecognizer(tapGesture)
        
        setupPanGesture()
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    @objc func dismissModal(_ sender: UIButton) {
        
        guard let pvc = self.presentingViewController else { return }
        pvc.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true) {
            pvc.present(WriteViewController(isToday: self.isToday),animated: true,completion: nil)
        }
        
    }
    
    
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(containerView)
        containerView.addSubview(iconView1)
        containerView.addSubview(iconView2)
        containerView.addSubview(iconView3)
        containerView.addSubview(titleLabel)
        containerView.addSubview(ButtonForNextView)
        iconView1.addSubviews(imageFeeling)
        iconView2.addSubviews(imageDidGetMedicine)
        iconView3.addSubviews(imageSleepTime)
        
        setSNP()
    }
    
    // 사용자가 선택한 캘린더의 날짜와 동일한 날짜의 데이터만 출력
    private func read() {
        guard let realm = try? Realm() else { return }
        let models = realm.objects(Day.self)
        print(self.Date)
        for model in models {
            if(model.createdDate == self.Date){
                print(model._id,model.createdDate,model.iconFeeling,model.sleepTime,model.didFeelingChange,model.didTakeMedicine,model.firstQuestion,model.secondQuestion,model.thirdQuestion)
                changeToimageMedicine(iconBool: model.didTakeMedicine)
                changeToimageFeelingIcon(iconInt: model.iconFeeling)
                setSleepTime(iconString: model.sleepTime)
            }else{
                continue
            }
        }
    }
    
    // change Realm data to class data
    func setSleepTime(iconString:String){
        self.sleepTimeString = iconString
    }
    // change Realm data to class data
    func changeToimageFeelingIcon(iconInt:Int){
        switch iconInt {
        case 0:
            self.imageFeeling = UIImageView(image: UIImage(named: "Happy"))
            break
        case 1:
            self.imageFeeling = UIImageView(image: UIImage(named: "Tranquility"))
            break
        case 2:
            self.imageFeeling = UIImageView(image: UIImage(named: "Tough"))
            break
        case 3:
            self.imageFeeling = UIImageView(image: UIImage(named: "Sad"))
            break
        case 4:
            self.imageFeeling = UIImageView(image: UIImage(named: "Tired"))
            break
        case 5:
            self.imageFeeling = UIImageView(image: UIImage(named: "Angry"))
            break
        default:
            break
        }
    }
    // change Realm data to class data
    func changeToimageMedicine(iconBool:Bool){
        if iconBool == true{
            self.imageDidGetMedicine = UIImageView(image: UIImage(named: "약복용"))
        }
        else{
            self.imageDidGetMedicine = UIImageView(image: UIImage(named: "약미복용"))
        }
    }
    
    
    
        

    
    func setSNP(){
        imageSleepTime.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        imageFeeling.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-15)
        }
        
        imageDidGetMedicine.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-15)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(containerView).offset(33)
            make.trailing.equalTo(containerView).inset(40)
            make.leading.equalTo(containerView).inset(40)
            make.height.equalTo(30)
        }
        ButtonForNextView.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel).inset(170)
            make.centerX.equalTo(containerView)
            make.height.equalTo(45)
            make.leading.equalTo(containerView).inset(135)
            make.trailing.equalTo(containerView).inset(135)
        }
        iconView1.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel).inset(45)
            make.leading.equalTo(containerView).inset(35)
            make.height.equalTo(90)
            make.width.equalTo(90)
        }
        iconView2.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel).inset(45)
            make.centerX.equalTo(titleLabel)
            make.height.equalTo(90)
            make.width.equalTo(90)
        }
        iconView3.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel).inset(45)
            make.trailing.equalTo(containerView).inset(33)
            make.height.equalTo(90)
            make.width.equalTo(90)
        }
        containerView.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
//        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
//        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        containerView.alpha = 1.0
        UIView.animate(withDuration: 0.4) {
            self.containerView.alpha = 1.0
        }
        
    }
    
    func animateDismissView() {
        containerView.alpha = 1.0
        UIView.animate(withDuration: 0.4) {
            self.containerView.alpha = 1.0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}

