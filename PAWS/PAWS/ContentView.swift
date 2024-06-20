//
//  ContentView.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import SwiftUI
import AxisSegmentedView
import WidgetKit

// UserDefaults Key
private let selectedItemsKey = "SelectedItems"

struct ContentView: View {
    @EnvironmentObject var dataModel: AppDataModel
    
    @GestureState private var isPressed = false
    @State private var pressedItem: Item?
    
    @State private var isStoreButtonTapped = false
    @State private var selectedTab: Int = 0
    @State var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @State private var items: [Item] = sampleItems

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    title
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        room
                        pointSection
                            .padding(16)
                        
                    }
                    subTitle
                    customSegmentedView
                    itemsView
                }
                
            }
            .padding(16)
            .background {
                LinearGradient( colors: [Color.accentColor.opacity(0.4), Color.white.opacity(0.67)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppDataModel())
}

extension ContentView {
    
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
            Text("\(dataModel.point)")
                .font(.pretendardMedium16)
                .fontWeight(.regular)
            Text("0")
                .foregroundColor(Color.clear)
        }
        .background(Color.white.opacity(0.4))
        .cornerRadius(50)
    }
    
    private var title: some View {
//        Text("PAWS")
//            .font(.pretendardBold18)
//            .foregroundColor(Color.black)
        Image("title")
            .resizable()
            .scaledToFit()
            .frame(width: 80)
            .padding(.bottom, 10)
    }
    
    private var storeButton: some View {
        Button{
            isStoreButtonTapped = true
        } label: {
            Image(systemName: "storefront.fill")
                .font(.pretendardBold18)
                .foregroundColor(Color.black)
        }
        .navigationDestination(isPresented: $isStoreButtonTapped) {
            StoreView()
                .environmentObject(dataModel)
        }
    }
    
    private var room: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.white, lineWidth: 1)
            .frame(width: 360, height: 360)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.white.opacity(0.3))
                    .padding(5)
                if let item = dataModel.items.first(where: { $0.isSelected && $0.type == .backgroundSeat }) {
                    Image(item.imageName)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(5)
                }
            }
            .overlay {
                if let item = dataModel.items.first(where: { $0.isSelected && $0.type == .characterBody }) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                        .offset(x: 10, y: 50)
                }
                    
                if let item = dataModel.items.first(where: { $0.isSelected && $0.type == .characterAccessoryHead }) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .padding()
                        .offset(x: 7, y: -25)
                }
                
                if let item = dataModel.items.first(where: { $0.isSelected && $0.type == .characterAccessoryFace }) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        .offset(x: 10, y: 30)
                }
                        
                if let item = dataModel.items.first(where: { $0.isSelected && $0.type == .interiorLeftSeat }) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .padding()
                        .offset(x: -100, y: 105)
                }
                        
                if let item = dataModel.items.first(where: { $0.isSelected && $0.type == .interiorTopSeat }) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140)
                        .padding()
                        .offset(x: 0, y: -100)
                }
            }
        
    }
    
    private var subTitle: some View {
        HStack {
            Text("What's in my room")
                .font(.pretendardBold18)
            Spacer()
//            Rectangle()
//                .foregroundColor(Color.black.opacity(0.5))
//                .frame(width: 140, height: 0.6)
//            Spacer()
            storeButton
        }
        .padding(.top, 30)
        .padding(.bottom, 10)
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

    private func itemView(for item: Item) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color.white.opacity(0.3))
                .frame(width: 80, height: 80)
                .overlay{
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .updating($isPressed) { value, state, _ in
                                    state = value
                                }
                                .onChanged {_ in
                                    pressedItem = item
                                }
                        )
                }
                .simultaneousGesture (
                    TapGesture()
                        .onEnded { _ in
                            LiveActivityManager.shared.onLiveActivity()
                            let jsonString = selectedItemsToJSON(items:dataModel.items)
                                 
                            print("ssss : \(jsonString)")
                            // Objective-C 클래스의 메서드 호출
                            LiveActivityManager.shared.updateLiveActivity(selectedItemsJSON: jsonString ?? "")
                            
                            // 같은 타입의 아이템 중 선택된 아이템 찾기
                            if let selectedIndex = dataModel.items.firstIndex(where: { $0.isSelected && $0.type == item.type }) {
                                // 이전에 선택된 아이템 해제
                                dataModel.items[selectedIndex].isSelected = false
                            }
                            
                            // 현재 아이템 선택
                            if let currentIndex = dataModel.items.firstIndex(where: { $0.id == item.id }) {
                                dataModel.items[currentIndex].isSelected = true
                            }
                            WidgetCenter.shared.reloadTimelines(ofKind: "PawsWidget")
                        }
                )
                .scaleEffect(isPressed && pressedItem?.id == item.id ? 1.2 : 1.0) // 작아지는 효과
                .animation(.easeInOut(duration: 0.3), value: isPressed && pressedItem?.id == item.id)
        }
    }
    
    private var itemsView: some View {
        ScrollView {
            if(selectedTab == 0) {
                Section {
                    LazyVGrid(columns: columns) {
                        ForEach(dataModel.items.filter { $0.isHaving }) { item in
                            itemView(for: item)
                        }
                    }
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
                    .padding(.top, 5)
                    LazyVGrid(columns: columns) {
                        ForEach(dataModel.items.filter { $0.isHaving && $0.type == .characterBody }) { item in
                            itemView(for: item)
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
                        ForEach(dataModel.items.filter { $0.isHaving && $0.type == .characterAccessoryHead }) { item in
                            itemView(for: item)
                        }
                        ForEach(dataModel.items.filter { $0.isHaving && $0.type == .characterAccessoryFace }) { item in
                            itemView(for: item)
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
                    .padding(.top, 5)
                    LazyVGrid(columns: columns) {
                        ForEach(dataModel.items.filter { $0.isHaving && $0.type == .interiorLeftSeat }) { item in
                            itemView(for: item)
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                Section {
                    HStack {
                        Text("Top Seat")
                            .font(.pretendardRegular14)
                            .foregroundColor(Color.black.opacity(0.6))
                        Spacer()
                    }
                    LazyVGrid(columns: columns) {
                        ForEach(dataModel.items.filter { $0.isHaving && $0.type == .interiorTopSeat }) { item in
                            itemView(for: item)
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                Section {
                    HStack {
                        Text("Backgound Color")
                            .font(.pretendardRegular14)
                            .foregroundColor(Color.black.opacity(0.6))
                        Spacer()
                    }
                    LazyVGrid(columns: columns) {
                        ForEach(dataModel.items.filter { $0.isHaving && $0.type == .backgroundSeat }) { item in
                            itemView(for: item)
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
        }
    }
    // 선택된 아이템을 JSON 문자열로 변환하는 함수
    func selectedItemsToJSON(items: [Item]) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(items)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding selected items: \(error)")
            return nil
        }
    }
    
}
