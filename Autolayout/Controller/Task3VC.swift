//
//  ViewController.swift
//  Autolayout
//
//  Created by Алина Власенко on 10.02.2023.
//


// Task 3:
//Скрін по натисканню на кнопку Task 3. Містить 2 текстові поля Label та 2 поля вводу тексту Text Field.
//Перше поле вводу зробити активним, реалізувати делегат UITextFieldDelegate і при введенні будь-якого символу друкувати те, що зараз у полі введення. Друге текстове поле зробити неактивними. Все знаходиться в контейнері. Контейнер зафарбований в системний колір Group Table View Background Color та має відступи з усіх боків по 8pt. Шрифт стандартний, висота текстових полів по замовчуванню.

import UIKit

class Task3VC: UIViewController {

    //MARK: - UI objects
    
    private let lbl1: UILabel = {
        let label = UILabel()
        label.text = "TextField1 - with UITextFieldDelegate"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        return label
    }()
    
    private let lbl2: UILabel = {
        let label = UILabel()
        label.text = "TextField2 - no active"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        return label
    }()
    
    private let textField1: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type something"
        textField.backgroundColor = .white
        textField.tintColor = .blue
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        return textField
    }()
    
    private var textField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type something"
        textField.backgroundColor = .white
        textField.tintColor = .blue
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        //Роблю цей textField не активним для редагування
        textField.isUserInteractionEnabled = false
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        return textField
    }()
    
    private let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        //Маю помилку "was deprecated in iOS 13.0" на колір 'groupTableViewBackground', який маю задати по завданню:
        //container.backgroundColor = .groupTableViewBackground
        container.backgroundColor = .systemGray5
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    //Додаю subContainer для обмеження елементів у контейнері, щоб не мали великий відступ одне від одного.
    private let subContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.distribution = .equalSpacing
        container.spacing = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        addSubviews()
        applyConstraints()
        applyDelegat()
    }

    //MARK: - Add subviews

    private func addSubviews() {
        view.addSubview(container)
        container.addSubview(subContainer)
        //додаю елементи у контейнер
        subContainer.addArrangedSubview(lbl1)
        subContainer.addArrangedSubview(textField1)
        subContainer.addArrangedSubview(lbl2)
        subContainer.addArrangedSubview(textField2)
        
    }
    
    //MARK: - Configure NavBar

    private func configureNavigationBar() {
        title = "Task 3"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor(named: "NavBackground")
        navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: - Apply constraints
    
    private func applyConstraints() {
        let containerConstraints = [
//!!!        //як зробити відступ від NavBar?
            //container.topAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor, constant: 8),
            container.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ]
        
        let subContainerConstraints = [
            subContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 150),
            //задаю розмір для підконтейнера для елементів, щоб їх не розтягувало по всьому контейнеру, який на увесь екран
            subContainer.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let lbl1Constraints = [
            lbl1.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8)
        ]

        let lbl2Constraints = [
            lbl2.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8)
        ]
        
        let textField1Constraints = [
            textField1.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8)
        ]
        
        let textField2Constraints = [
            //не працює нижній відступ від container - лише від вью
            //textField2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            textField2.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(lbl1Constraints)
        NSLayoutConstraint.activate(lbl2Constraints)
        NSLayoutConstraint.activate(textField1Constraints)
        NSLayoutConstraint.activate(textField2Constraints)
        NSLayoutConstraint.activate(subContainerConstraints)
    }
}

//Перше поле вводу зробити активним, реалізувати делегат UITextFieldDelegate і при введенні будь-якого символу друкувати те, що зараз у полі введення.
extension Task3VC: UITextFieldDelegate {
    
    func applyDelegat() {
        textField1.delegate = self
        textField2.delegate = self
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField1.text ?? "no text"
        print(text)
    }
    
    
    //Напагалася таким чином реалізувати не активний textField. Але усе простіше - просто через крапку до філда написати - .isUserInteractionEnabled = false
    //коли вмикаю цей метод, то не редагує ніякі текст філди
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        let textField = textField2
//        return false
//    }
    
    //Це взагалі не працює
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//            self.textField2 = textField
//       }
    
}


