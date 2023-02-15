//
//  ViewController.swift
//  Autolayout
//
//  Created by Алина Власенко on 10.02.2023.
//


//Task 2:
//Скрін по натисканню на кнопку Task 2. Містить довільну картинку та текстове поле Label. Картинка повинна мати співвідношення таке саме, як у реального зображення. Текст розміщується по центру області що залишилась.


import UIKit

class Task2VC: UIViewController {
    
    //MARK: - UI objects
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cat")
        //Картинка повинна мати співвідношення таке саме, як у реального зображення. Роблю за допомогою contentMode = .scaleAspectFit
        img.clipsToBounds = true //дозволяє зберігати пропорції картинки
        img.contentMode = .scaleAspectFill //розтягує картинку до вказаний констрейнтами обмежень
        img.layer.shadowRadius = 5
        img.layer.shadowOpacity = 0.5
        img.layer.shadowOffset = CGSize(width: -2, height: 2)
        img.layer.shadowColor = UIColor.black.cgColor
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let comment: UILabel = {
        let label = UILabel()
        label.text = "This cat is so cute"
        //Задаю розміри і шрифт вказані у завданні
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Task 2"
        view.backgroundColor = .systemBackground
        
        addSubviews()
        applyConstraints()
    }
    
    //MARK: - Add subviews
    
    private func addSubviews() {
        view.addSubview(image)
        view.addSubview(comment)
    }
    
    //MARK: - Apply constraints
    
    private func applyConstraints() {
        let imageConstraints = [
//!!!      //Не стає на місце картинка - має бути зверху з відступом: 8. Якщо роблю відступ зверху -106 і потім лейблі додаю відступ від картинки десь 70, то вирівнюється на 12 Pro Max. Але ж то на різних екранах вже не працюватиме як слід. Не розумію з відки реруться ці зайві маржени у картинки (через те що я зробила її пропорційно меншою за відступами з боків?
            //image.topAnchor.constraint(equalTo: view.topAnchor, constant: -106),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            //image.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            image.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            //висота картинки буде займати 3 частину екрана
            image.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ]
        
        let commentConstraints = [
            comment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //комент до картинки відбивається з низу на половину від 2/3 екрана
            comment.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -((view.frame.height - view.frame.height / 3) / 2))
            //роблю текст по центру від картинки до низу екрана(як вказано у завданні)
            //comment.centerYAnchor.constraint(equalTo: image.bottomAnchor)
            //comment.centerYAnchor.constraint(equalTo: image.bottomAnchor, constant: 70),
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(commentConstraints)
        
    }
}
