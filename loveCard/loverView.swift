//
//  loverView.swift
//  loveCard
//
//  Created by Kumo on 2019/11/10.
//  Copyright © 2019 Kumo. All rights reserved.
//

import SwiftUI

struct loverView: View {
    @Binding var showLover:Bool
    @Binding var profileIndex:Int
    @Binding var name:String
    @Binding var age:Int
    @Binding var birthday:Date
    @Binding var selectHair:String
    @Binding var selectHobby:String
    @State private var scale: CGFloat = 1
    @State private var brightnessAmount: Double = 0
    @State private var moveDistance: CGFloat = 0
    @State private var opacity: Double = 1
    @State private var selectIndex = 0
    @State private var showAlert = false
    var body: some View {
        VStack{
            Group{
                Spacer()
                Text("個人資訊")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(30)
                personView(profileIndex: self.$profileIndex, name: self.$name, age: self.$age, birthday: self.$birthday, selectHair: self.$selectHair, selectHobby: self.$selectHobby)
                heartMove(moveDistance: $moveDistance, opacity: $opacity)
            }
            if selectHair == "長髮"{
                VStack{
                    Group{
                        Image(longHair[selectIndex].name)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(scale)
                            .brightness(brightnessAmount)
                            .frame(width: 300,height: 300)
                        Button(action: {self.showAlert = true}) {
                            Text("送出邀請")
                        }
                        .alert(isPresented: $showAlert) { () -> Alert in
                            let answer = ["非常適合", "不太適合"]
                            if self.selectHobby == longHair[selectIndex].hobby{
                                return Alert(title: Text(answer[0]))
                            }
                            else{
                                return Alert(title: Text(answer[1]))
                            }
                        }
                        VStack {
                            HStack{
                                Image(systemName: "minus.circle")
                                Slider(value: $scale, in: 0...1)
                                Image(systemName: "plus.circle")
                            }
                            .padding()
                            HStack{
                                Image(systemName: "sun.max.fill").imageScale(.small)
                                Slider(value: $brightnessAmount, in: 0...1)
                                Image(systemName: "sun.max.fill").imageScale(.large)
                            }
                            .padding()
                        }
                    }
                    Picker("Girls", selection: $selectIndex) {
                        ForEach(0..<3) { (index) in
                            Text(longHair[index].name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            else if selectHair == "短髮"{
                VStack{
                    Group{
                        Image(shortHair[selectIndex].name)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(scale)
                            .brightness(brightnessAmount)
                            .frame(width: 300,height: 300)
                        Button(action: {self.showAlert = true}) {
                            Text("送出邀請")
                        }
                        .alert(isPresented: $showAlert) { () -> Alert in
                            let answer = ["非常適合", "不太適合"]
                            if self.selectHobby == shortHair[selectIndex].hobby{
                                return Alert(title: Text(answer[0]))
                            }
                            else{
                                return Alert(title: Text(answer[1]))
                            }
                        }
                        VStack {
                            HStack{
                                Image(systemName: "minus.circle")
                                Slider(value: $scale, in: 0...1)
                                Image(systemName: "plus.circle")
                            }
                            .padding()
                            HStack{
                                Image(systemName: "sun.max.fill").imageScale(.small)
                                Slider(value: $brightnessAmount, in: 0...1)
                                Image(systemName: "sun.max.fill").imageScale(.large)
                            }
                            .padding()
                        }
                    }
                    Picker("Girls", selection: $selectIndex) {
                        ForEach(0..<3) { (index) in
                            Text(shortHair[index].name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            else if selectHair == "馬尾"{
                VStack{
                    Group{
                        Image(horseTail[selectIndex].name)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(scale)
                            .brightness(brightnessAmount)
                            .frame(width: 300,height: 300)
                        Button(action: {self.showAlert = true}) {
                            Text("送出邀請")
                        }
                        .alert(isPresented: $showAlert) { () -> Alert in
                            let answer = ["非常適合", "不太適合"]
                            if self.selectHobby == horseTail[selectIndex].hobby{
                                return Alert(title: Text(answer[0]))
                            }
                            else{
                                return Alert(title: Text(answer[1]))
                            }
                        }
                        VStack {
                            HStack{
                                Image(systemName: "minus.circle")
                                Slider(value: $scale, in: 0...1)
                                Image(systemName: "plus.circle")
                            }
                            .padding()
                            HStack{
                                Image(systemName: "sun.max.fill").imageScale(.small)
                                Slider(value: $brightnessAmount, in: 0...1)
                                Image(systemName: "sun.max.fill").imageScale(.large)
                            }
                            .padding()
                        }
                    }
                    Picker("Girls", selection: $selectIndex) {
                        ForEach(0..<3) { (index) in
                            Text(horseTail[index].name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
            }
            Spacer()
            Button(action: {self.showLover = false}){
                HStack {
                    Text("Exit")
                    Image(systemName: "trash.fill")
                }
                .padding()
                .font(.title)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(30)
            }
        }
        .background(Image("wallpaper1")
        .resizable()
        .scaledToFill()
        .clipped()
        .edgesIgnoringSafeArea([.top, .bottom]))
    }
}

struct loverView_Previews: PreviewProvider {
    static var previews: some View {
        loverView(showLover: .constant(true), profileIndex: .constant(3), name: .constant(""), age: .constant(18), birthday: .constant(Date()), selectHair: .constant(""), selectHobby: .constant("") )
    }
}


struct personView: View {
    @Binding var profileIndex:Int
    @Binding var name:String
    @Binding var age:Int
    @Binding var birthday:Date
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    @Binding var selectHair:String
    @Binding var selectHobby:String
    var body: some View {
        VStack{
            HStack{
                Image(profiles[profileIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 5){
                    Text("喜歡女生髮型: \(selectHair)")
                        .foregroundColor(Color.purple)
                    Text("你的興趣: \(selectHobby)")
                        .foregroundColor(Color.purple)
                }
            }
            Text("名字: \(name), 年齡: \(age), 生日: \(dateFormatter.string(from: birthday))")
                .font(Font.custom("Cochin Italic", size: 20))
                .foregroundColor(Color.green)
        }
    }
}

struct heartMove: View {
    @Binding var moveDistance: CGFloat
    @Binding var opacity: Double
    var body: some View {
        HStack {
            Image("heart")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 25)
                .offset(x: moveDistance, y: 0)
                .opacity(opacity)
            Spacer()
        }
        .onAppear {
            self.moveDistance += 400
            self.opacity -= 0.3
        }
        .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
    }
}
