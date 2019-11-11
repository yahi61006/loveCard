//
//  IntroView.swift
//  loveCard
//
//  Created by Kumo on 2019/11/10.
//  Copyright © 2019 Kumo. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    @State private var profileSheet = false
    @State private var profileIndex:Int = 3
    @State private var name:String = ""
    @State private var showMood = false
    @State private var age:Int = 18
    @State private var birthday = Date()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    @State private var selectHair = "長髮"
    @State private var selectHobby = "玩遊戲"
    @State private var showLover = false
    var body: some View {
        VStack {
            profileView(profileIndex: self.$profileIndex)
            Button(action: {self.profileSheet = true}) {
                Text("選擇大頭照")
            }
            .actionSheet(isPresented: $profileSheet) {
                ActionSheet(title: Text("Profile"), message: Text("good looking guys"), buttons: [.default(Text(profiles[0]), action: {
                    self.profileIndex = 0
                }), .default(Text(profiles[1]), action: {
                    self.profileIndex = 1
                }), .default(Text(profiles[2]), action: {
                    self.profileIndex = 2
                }), .destructive(Text("No photo"), action: {
                    self.profileIndex = 3
                })])
            }
            Group{
                TextField("你的名字", text: $name, onEditingChanged: { (editing) in
                    print("onEditingChanged", editing)
                }) {
                    print(self.name)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.pink, lineWidth: 5))
                .padding()
                Toggle(isOn: $showMood) {
                    if showMood {
                        HStack {
                            Image("goodmood")
                                .resizable()
                                .scaledToFill()
                                .frame(width:50, height:50)
                                .clipShape(Circle())
                            Text("好心情")
                            HStack {
                                Image(systemName: "star.fill").imageScale(.small)
                                Text("Congratulations!")
                                Image(systemName: "star.fill").imageScale(.small)
                            }
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(30)
                        }
                    }
                    else {
                        HStack {
                            Image("badmood")
                                .resizable()
                                .scaledToFill()
                                .frame(width:50, height:50)
                                .clipShape(Circle())
                            Text("壞心情")
                        }
                    }
                }
                .padding()
            }
            Group{
                Form{
                    Stepper(value: $age, in: 1...100) {
                        Text("年齡: \(age) 歲")
                            .foregroundColor(Color.purple)
                    }
                    
                    DatePicker("你的生日", selection: $birthday, in: ...Date(), displayedComponents: .date)
                    Text(dateFormatter.string(from: birthday))
                    
                    Text("喜歡的女生髮型")
                    Picker("喜歡的女生髮型", selection: $selectHair) {
                        ForEach(hairStyles, id: \.self) { (hairStyle) in
                            Text(hairStyle)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker(selection: $selectHobby, label: Text("選擇興趣")) {
                        ForEach(hobbies, id: \.self) { (hobby) in
                            Text(hobby)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 400, height: 90)
                    //.clipped()
                }
                Spacer()
                Button(action: {self.showLover = true}){
                    Text("Show Result")
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(30)
                }
                .sheet(isPresented: self.$showLover) {
                    loverView(showLover: self.$showLover, profileIndex: self.$profileIndex, name: self.$name, age: self.$age, birthday: self.$birthday, selectHair: self.$selectHair, selectHobby: self.$selectHobby)
                }
            }
        }
        .background(Image("wallpaper")
        .resizable()
        .scaledToFill()
        .clipped()
        .edgesIgnoringSafeArea([.top, .bottom]))
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

struct profileView: View {
    @Binding var profileIndex:Int
    var body: some View {
        Image(profiles[profileIndex])
            .resizable()
            .scaledToFill()
            .frame(width:180, height:180)
            .clipShape(Circle())
    }
}
