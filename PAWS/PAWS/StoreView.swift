//
//  StoreView.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import SwiftUI
import AxisSegmentedView

struct StoreView: View {
    @State private var isStoreButtonTapped = false
    @State private var selectedTab: Int = 0
    @State var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            VStack {
                room
                Text("*미리보기 입니다.")
                    .font(.pretendardRegular16)
                    .foregroundColor(Color.red)
                    .padding(.top, -20)
                    .padding(.bottom, 10)
                customSegmentedView
                itemView
            }
            .padding(16)
            .background {
                LinearGradient( colors: [Color.accentColor.opacity(0.4), Color.white.opacity(0.67)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: backButton, trailing: pointSection)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("스토어")
                        .font(.pretendardBold18)
                }
            }
        }
    }
}

#Preview {
    StoreView()
}

extension StoreView {
    
    private var backButton: some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left") // 화살표 Image
                    .aspectRatio(contentMode: .fit)
                Text("Back")
            }
        }
    }
    
    private var pointSection: some View {
        HStack {
            Circle()
                .foregroundColor(Color.white)
                .overlay {
                    Image(systemName: "pawprint.fill")
                        .font(.caption2)
                        .foregroundColor(Color.accentColor)
                }
                .frame(height: 20)
                .padding(5)
                .padding(.trailing, -5)
            Text("11")
                .font(.pretendardMedium16)
                .fontWeight(.regular)
            Text("0")
                .foregroundColor(Color.clear)
        }
        .background(Color.white.opacity(0.4))
        .cornerRadius(50)
    }
    
    private var title: some View {
        Text("스토어")
            .font(.pretendardBold18)
            .foregroundColor(Color.black)
    }
    
    private var room: some View {
        
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.white, lineWidth: 1)
            .frame(width: 150, height: 150)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.white.opacity(0.3))
                    .padding(5)
            }
            .padding(.bottom, 20)
        
    }
    
    private var customSegmentedView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .foregroundColor(Color.white.opacity(0.2))
                .frame(height: 40)
            
            AxisSegmentedView(selection: $selectedTab, constant: .init()) {
                Group{
                    Text("All")
                        .itemTag(0, selectArea: 0) {
                            Text("All")
                                .foregroundColor(Color.white)
                        }
                    Text("캐릭터")
                        .itemTag(1, selectArea: 0) {
                            Text("캐릭터")
                                .foregroundColor(Color.white)
                        }
                    Text("인테리어")
                        .itemTag(2, selectArea: 0) {
                            Text("인테리어")
                                .foregroundColor(Color.white)
                        }
                }
                .foregroundColor(Color.black)
                .font(.pretendardMedium16)
            } style: {
                ASCapsuleStyle(backgroundColor: Color.white, foregroundColor: Color.accentColor, animation: .bouncy)
            } onTapReceive: { selectedTab in
                print("---------------------")
                print("Selection : ", selectedTab)
            }
            .frame(height: 40)
        }
    }
    
    private var item: some View {
        VStack {
            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                .cornerRadius(14)
                .frame(width: 80, height: 80)
            itemPrice
        }
    }
    
    private var itemPrice: some View {
        HStack {
            Circle()
                .foregroundColor(Color.white)
                .overlay {
                    Image(systemName: "pawprint.fill")
                        .font(.caption2)
                        .foregroundColor(Color.accentColor)
                }
                .frame(height: 20)
                .padding(5)
                .padding(.trailing, -5)
            Text("11")
                .font(.pretendardRegular16)
            Text("0")
                .foregroundColor(Color.clear)
        }
        .padding(.top, -6)
    }

    
    private var itemView: some View {
        ScrollView {
            if(selectedTab == 0) {
                Section {
                    LazyVGrid(columns: columns) {
                        ForEach((0...18), id: \.self) { _ in
                            item
                        }
                    }
                    .padding(.top, 6)
                }
                .padding(10)
            } else if(selectedTab == 1) {
                Section {
                    HStack {
                        Text("Body")
                            .font(.pretendardRegular14)
                            .foregroundColor(Color.black.opacity(0.6))
                        Spacer()
                    }
                    .padding(.top, 10)
                    LazyVGrid(columns: columns) {
                        ForEach((0...1), id: \.self) { _ in
                            item
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                Section {
                    HStack {
                        Text("Accessory")
                            .font(.pretendardRegular14)
                            .foregroundColor(Color.black.opacity(0.6))
                        Spacer()
                    }
                    LazyVGrid(columns: columns) {
                        ForEach((0...10), id: \.self) { _ in
                            item
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            } else if(selectedTab == 2) {
                Section {
                    HStack {
                        Text("Left Seat")
                            .font(.pretendardRegular14)
                            .foregroundColor(Color.black.opacity(0.6))
                        Spacer()
                    }
                    .padding(.top, 10)
                    LazyVGrid(columns: columns) {
                        ForEach((0...3), id: \.self) { _ in
                            item
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                Section {
                    HStack {
                        Text("Right Seat")
                            .font(.pretendardRegular14)
                            .foregroundColor(Color.black.opacity(0.6))
                        Spacer()
                    }
                    LazyVGrid(columns: columns) {
                        ForEach((0...6), id: \.self) { _ in
                            item
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
        }
    }
    
}
