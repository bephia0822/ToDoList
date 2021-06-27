//
//  SecondViewController.swift
//  ToDoList
//
//  Created by Sophia Wang on 2021/4/2.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    var infoFromViewOne: Int?   //使用者想編輯哪一列
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    @IBOutlet weak var myTextInput: UITextField!
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func textFieldDidChanged(_ sender: UITextField) {
        //文字輸入匡不等於空字串
        if sender.text != ""{
            myButton.setTitle("OK", for: .normal)      //使用者一輸入文字就會變ＯＫ
        }else{
            myButton.setTitle("Back", for: .normal)   
        }
    }
   
    @IBAction func buttonPressed(_ sender: UIButton) {
        //把使用者輸入的文字存成待辦事項
        if let text = myTextInput.text{
            guard let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController else{ return }
            if text != ""{
                if infoFromViewOne != nil{
                    firstViewController.toDos[infoFromViewOne!] = text
                    infoFromViewOne = nil
                }else{
                    firstViewController.toDos.append(text)
                }
                firstViewController.myTableView.reloadData()//要加這個程式才會知道資料已經改變了，才知道要顯示最新資料
                UserDefaults.standard.set(firstViewController.toDos, forKey: "todos")
            }else{
                //使用者把代辦文字全刪掉了
                if infoFromViewOne != nil{
                    firstViewController.toDos.remove(at: infoFromViewOne!)
                    firstViewController.myTableView.reloadData()
                    UserDefaults.standard.set(firstViewController.toDos, forKey: "todos")
                    infoFromViewOne = nil
                }
            }
        }
        myTextInput.text = ""      //輸入完要清空文字輸入匡
        myButton.setTitle("Back", for: .normal)    //重新設定按鈕文字回Back
        tabBarController?.selectedIndex = 0     //使用者沒輸入按back可回到第一個畫面
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextInput.becomeFirstResponder()
        myTextInput.delegate = self
        //使用者想修改的待辦事項
        if infoFromViewOne != nil{
            if let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController{
                myTextInput.text = firstViewController.toDos[infoFromViewOne!]
                myButton.setTitle("OK", for: .normal)
            }
        }
    }
    //如此才能再次修改
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController{
            myTextInput.text = firstViewController.toDos[infoFromViewOne!]
            myButton.setTitle("OK", for: .normal)
        }
    }
    //按鍵盤的return鍵也能輸入
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonPressed(UIButton())
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
