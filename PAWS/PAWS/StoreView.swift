//
//  StoreView.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import SwiftUI
import AxisSegmentedView

struct StoreView: View {
    @EnvironmentObject var dataModel: AppDataModel
    
    @State private var isStoreButtonTapped = false
    @State private var selectedTab: Int = 0
    @State var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var items: [Item] = sampleItems

    @State private var selectedCharacterBody: Item?
    @State private var selectedCharacterAccessoryHead: Item?
    @State private var selectedCharacterAccessoryFace: Item?
    @State private var selectedInteriorLeftSeat: Item?
    @State private var selectedInteriorTopSeat: Item?
    @State private var selectedBackgroundSeat: Item?
    
    @State private var showAlert = false
    @State private var selectedItemForPurchase: Item?
    @GestureState private var isPressed = false
    @State private var pressedItem: Item?
    
    var body: some View {
        NavigationStack {
            VStack {
                room
                Text("*미리보기 입니다.")
                    .font(.pretendardRegular14)
                    .foregroundColor(Color.red)
                    .padding(.bottom, 10)
                customSegmentedView
                itemsView
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
        .environmentObject(AppDataModel())
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
        Text("스토어")
            .font(.pretendardBold18)
            .foregroundColor(Color.black)
    }
    
    private var room: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.white, lineWidth: 1)
            .frame(width: 150, height: 150)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white.opacity(0.3))
                    .padding(5)
                if let item = selectedBackgroundSeat {
                    Image(item.imageName)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(5)
                }
            }
            .overlay {
                
                if let item = selectedCharacterBody {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200*150/360, height: 200*150/360)
                        .padding()
                        .offset(x: 10*150/360, y: 50*150/360)
                }
                    
                if let item = selectedCharacterAccessoryHead {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60*150/360)
                        .padding()
                        .offset(x: 7*150/360, y: -25*150/360)
                }
                
                if let item = selectedCharacterAccessoryFace {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100*150/360, height: 100*150/360)
                        .padding()
                        .offset(x: 10*150/360, y: 30*150/360)
                }
                        
                if let item = selectedInteriorLeftSeat {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80*150/360)
                        .padding()
                        .offset(x: -100*150/360, y: 105*150/360)
                }
                        
                if let item = selectedInteriorTopSeat {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140*150/360)
                        .padding()
                        .offset(x: 0, y: -100*150/360)
                }
            }
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
                        .overlay {
                            if item.isHaving {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color.black.opacity(0.3))
                                    .frame(width: 80, height: 80)
                                VStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .frame(width: 170)
                                        .foregroundColor(.white)
                                    Text("Owned")
                                        .font(.footnote.bold())
                                        .padding(.top, 2)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .updating($isPressed) { value, state, _ in
                                    state = value
                                }
                                .onChanged {_ in 
                                    pressedItem = item
                                }
                                .onEnded { _ in
                                    selectedItemForPurchase = item
                                    showAlert = true
                                    pressedItem = nil
                                    print("길게누름")
                                }
                            
                        )
                        .alert(isPresented: $showAlert) {
                            if let selectedItem = selectedItemForPurchase {
                                if isHavingPurchaseSelectedItem() {
                                    return Alert(
                                        title: Text("알림"),
                                        message: Text("이미 구매한 아이템입니다."),
                                        dismissButton: .cancel(Text("확인"))
                                    )
                                } else if isPossiblePurchaseSelectedItem() {
                                    return Alert(
                                        title: Text("아이템을 구매하시겠습니까?"),
                                        message: Text("꾹꾹이 포인트 \(selectedItem.price)개가 차감됩니다."),
                                        primaryButton: .destructive(Text("구매"), action: {
                                            purchaseSelectedItem()
                                        }),
                                        secondaryButton: .cancel(Text("취소"))
                                    )
                                } else {
                                    return Alert(
                                        title: Text("알림"),
                                        message: Text("포인트가 부족하여 아이템을(를) 구매할 수 없습니다."),
                                        dismissButton: .cancel(Text("확인"))
                                    )
                                }
                            } else {
                                return Alert(
                                    title: Text("알림"),
                                    message: Text("선택된 아이템이 없습니다."),
                                    dismissButton: .cancel(Text("확인"))
                                )
                            }
                        }
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            if !showAlert {
                                LiveActivityManager.shared.onLiveActivity()
                                let jsonString = selectedItemsToJSON(items:dataModel.items)
                                                
                                // Objective-C 클래스의 메서드 호출
                                LiveActivityManager.shared.updateLiveActivity(selectedItemsJSON: jsonString ?? "")
                                
                                // Deselect previously selected item of the same type
                                switch item.type {
                                case .characterBody:
                                    if let selectedItem = selectedCharacterBody {
                                        if selectedItem.id == item.id {
                                            selectedCharacterBody = nil
                                        } else {
                                            selectedCharacterBody = item
                                        }
                                    } else {
                                        selectedCharacterBody = item
                                    }
                                    
                                case .characterAccessoryHead:
                                    if let selectedItem = selectedCharacterAccessoryHead {
                                        if selectedItem.id == item.id {
                                            selectedCharacterAccessoryHead = nil
                                        } else {
                                            selectedCharacterAccessoryHead = item
                                        }
                                    } else {
                                        selectedCharacterAccessoryHead = item
                                    }
                                
                                case .characterAccessoryFace:
                                    if let selectedItem = selectedCharacterAccessoryFace {
                                        if selectedItem.id == item.id {
                                            selectedCharacterAccessoryFace = nil
                                        } else {
                                            selectedCharacterAccessoryFace = item
                                        }
                                    } else {
                                        selectedCharacterAccessoryFace = item
                                    }
                                    
                                case .interiorLeftSeat:
                                    if let selectedItem = selectedInteriorLeftSeat {
                                        if selectedItem.id == item.id {
                                            selectedInteriorLeftSeat = nil
                                        } else {
                                            selectedInteriorLeftSeat = item
                                        }
                                    } else {
                                        selectedInteriorLeftSeat = item
                                    }
                                    
                                case .interiorTopSeat:
                                    if let selectedItem = selectedInteriorTopSeat {
                                        if selectedItem.id == item.id {
                                            selectedInteriorTopSeat = nil
                                        } else {
                                            selectedInteriorTopSeat = item
                                        }
                                    } else {
                                        selectedInteriorTopSeat = item
                                    }
                                
                                case .backgroundSeat:
                                    if let selectedItem = selectedBackgroundSeat {
                                        if selectedItem.id == item.id {
                                            selectedBackgroundSeat = nil
                                        } else {
                                            selectedBackgroundSeat = item
                                        }
                                    } else {
                                        selectedBackgroundSeat = item
                                    }
                                }
                                
                                // Update isSelected state of the item
                                if let index = items.firstIndex(where: { $0.id == item.id }) {
                                    items[index].isSelected.toggle()
                                }
                            }
                            showAlert = false
                        }
                )
                .scaleEffect(isPressed && pressedItem?.id == item.id ? 1.2 : 1.0) // 작아지는 효과
                .animation(.easeInOut(duration: 0.3), value: isPressed && pressedItem?.id == item.id)
            itemPriceView(for: item.price)
        }
        
    }
    
    private func itemPriceView(for price: Int) -> some View {
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
            Text("\(price)")
                .font(.pretendardRegular16)
            Text("0")
                .foregroundColor(Color.clear)
        }
        .padding(.top, -6)
    }
    
    private func isHavingPurchaseSelectedItem() -> Bool {
        guard let selectedItem = selectedItemForPurchase else { return false }
        if let index = dataModel.items.firstIndex(where: { $0.id == selectedItem.id }) {
            print("is having : \(dataModel.items[index].isHaving)")
            return dataModel.items[index].isHaving
        }
        return false
    }
    
    private func isPossiblePurchaseSelectedItem() -> Bool {
        guard let selectedItem = selectedItemForPurchase else { return false }
        if dataModel.point >= selectedItem.price {
            return true
        } else {
            print("Insufficient points to purchase \(selectedItem.imageName)")
            return false
        }
    }

    private func purchaseSelectedItem() {
        guard let selectedItem = selectedItemForPurchase else { return }
        if dataModel.point >= selectedItem.price {
            dataModel.point -= selectedItem.price
            print("\(selectedItem.imageName) purchased successfully!")
            
            if let index = dataModel.items.firstIndex(where: { $0.id == selectedItem.id }) {
                dataModel.items[index].isHaving = true
                print("is having22 : \(dataModel.items[index].isHaving)")
            }
        } else {
            print("Insufficient points to purchase \(selectedItem.imageName)")
        }
    }
    
    private var itemsView: some View {
        ScrollView {
            if(selectedTab == 0) {
                Section {
                    LazyVGrid(columns: columns) {
                        ForEach(dataModel.items) { item in
                            itemView(for: item)
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
                        ForEach(dataModel.items.filter { $0.type == .characterBody }) { item in
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
                        ForEach((0...10), id: \.self) { _ in
                            ForEach(dataModel.items.filter { $0.type == .characterAccessoryHead }) { item in
                                itemView(for: item)
                            }
                            ForEach(items.filter { $0.type == .characterAccessoryFace }) { item in
                                itemView(for: item)
                            }
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
                        ForEach(dataModel.items.filter { $0.type == .interiorLeftSeat }) { item in
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
                        ForEach(dataModel.items.filter { $0.type == .interiorTopSeat }) { item in
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
                        ForEach(dataModel.items.filter { $0.type == .backgroundSeat }) { item in
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
