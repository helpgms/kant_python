class shopping_cart():

    lists = {
        1 : ["무선 이어폰", 89_000 , 3], 
        2 : ["텀블러", 15_000, 10], 
        3 : ["보조배터리", 32_000, 5], 
        4 : ["마우스패드", 9_000, 0], 
        5 : ["USB 허브", 18_000, 4]
        }
    
    # 제목
    def shop_title(self):
        print("-" * 60)
        print("1.상품 목록 2.담기 3.빼기 4.장바구니 5.쿠폰 6.결제 q.종료")
        print("-" * 60)
    shop_choice = {"1" :"상품목록" , "2" : "담기" , "3" : "빼기", "4" : "장바구니", "5" : "쿠폰", "6" : "결제", "q" : "종료"}

    # 장바구니 생성
    def __init__(self):
        self.cart = {}
        self.total_price = 0
        self.discount_price = 0
        self.user_choice_coupon = 1
        self.discount = 0

        self.kind = {
                        1 : "쿠폰 없음", 
                        2 : "10% 할인(최대 5_000원)", 
                        3 : "3_000원 할인(20_000원 이상 구매 시)"
                    }

    # 유저의 메뉴 선택
    def user_choice(self):
        user_answer = input("선택 : ").strip()
    
        if user_answer in self.shop_choice:
            return user_answer
        
        print("1, 2, 3, 4, 5, 6, q 중에서 입력하세요.")

    # 상품목록 보이기
    def shop_list(self):
        for lst in self.lists:
            print(f"{lst}. {self.lists[lst][0]} : {self.lists[lst][1]}  (재고 {self.lists[lst][2]}개)")

    # 상품 담기
    def add_cart(self):
        user_item_number = int(input("상품 번호: "))

        # 존재하지 않는 거 없애기
        if user_item_number not in self.lists:
            print("존재하지 않는 상품입니다.")
            return 
        
        user_hope_buy = int(input("수량: "))

        # 재고량
        stock = self.lists[user_item_number][2]

        # 카트 안에 있는 재고량
        current_stock = self.cart.get(user_item_number,0)

        # 만약 희망하는 수량과 현재 담겨있는 재고량이 더했을 때 재고량보다 작으면 담고
        if user_hope_buy <= stock:
            self.cart[user_item_number] = current_stock + user_hope_buy
            # self.lists[user_item_number][2] - user_hope_buy
            print(f"{self.lists[user_item_number][0]} {user_hope_buy}개를 담았습니다.")

        # 그렇지 않으면 0보다 크고 희망 수보다 작으면 x
        elif 0 < stock < user_hope_buy:
            print(f"담을 수 있는 수량: {self.lists[user_item_number][2]}개")

        # 0개면 품절
        elif stock == 0:
            print("품절된 상품입니다.")

            

    # 상품 뺴기
    def remove_cart(self):
        user_item_remove_number = int(input("빼고 싶은 상품 번호: "))
        user_remove_item = int(input("빼고 싶은 수량: "))

        # 상품번호가 없으면 제거 x
        if user_item_remove_number not in self.cart:
            print("뺄 상품이 없습니다.")
            return
        # 0개 이하이면 제거 x
        if user_remove_item <= 0:
            print("1개 이상 선택하시오.")
            return
        # 만약 카트 안에 빼고 싶은 상품의 수량이 빼고 싶은 수량보다 같거나 크면 빼자
        if self.cart[user_item_remove_number] >= user_remove_item:
            self.cart[user_item_remove_number] -= user_remove_item

            print(f"{self.lists[user_item_remove_number][0]} {user_remove_item}개를 뺐습니다.")

            # 빼고 싶은 상품을 빼니깐 카트 안 수량이 0이면 그 상품 전체를 카트에서 제거
            if self.cart[user_item_remove_number] == 0:
                del self.cart[user_item_remove_number]

        else:
            print("빼고 싶은 수량이 담은 수량보다 많습니다.")

    def show_cart(self):
        print("=" * 60)
        print("                        장바구니")
        print("=" * 60)

        if not self.cart:
            print("아무것도 없습니다.")
            return 
        
        total_price = 0

        for item_number, quantity in self.cart.items():
            name = self.lists[item_number][0]
            price = self.lists[item_number][1]

            item_total = price * quantity
            total_price += item_total 
            
            print(f"{name}   :   {quantity}개  {item_total:,} 원")

        self.total_price = total_price

        self.discount = 0

        if self.user_choice_coupon == 2:
            self.discount = self.total_price * 0.1
            if self.total_price * 0.1 >= 5_000:
                self.discount = 5_000
                
        elif self.user_choice_coupon == 3:
            if self.total_price >= 20_000:
                self.discount = 3_000

            else: 
                self.discount_price = self.total_price
                self.discount = 0

        
        elif self.user_choice_coupon == 1:
            self.discount = 0

        self.discount_price = self.total_price - self.discount

        print("-" * 60)
        print(f"상품 합계    : {self.total_price:,}원")
        print(f"할인         : {int(self.discount):,}원     {self.kind[self.user_choice_coupon]}")
        print(f"총 결제 금액 : {int(self.discount_price):,}원")

    # 쿠폰 메뉴
    def coupon(self):
        for key,value in self.kind.items():
            print(f"{key}. {value}")
        
        user_choice_coupon = int(input("쿠폰 번호: "))

        if user_choice_coupon == 1:
            user_choice_coupon = 1
            print("쿠폰이 없습니다.")

        elif user_choice_coupon in self.kind:
            self.user_choice_coupon = user_choice_coupon
            print(f"{self.kind[user_choice_coupon]} 쿠폰을 적용했습니다.")

        else:
            print("쿠폰이 존재하지 않습니다.")

    # 중간 문제점 : 1. 결제 완료 되었을 때 쿠폰 활용이 안되는 것 같음 해결 하지만 할인 가격이 위에서 0으로 초기화해서 그대로 0원으로 나오는 것 같음 -> 이건 여전히 안됨. -> 해결
    #               2. 결제가 완료되었는데 장바구니 안에 상품은 그대로 있음 -> 삭제 로직 구현했는데 적용 안됨... 튜플을 리스트로 바꾸니 연산이 되서 해결
    #               3. 결제 후 재고가 상품리스트에서 사라져야하는데 안 사라짐. -> 해결 완

    # 후반 문제점 : 1. 2만원이 안넘는 물품도 쿠폰 3번인 할인권이 적용됨 하지만 결제에서는 적용이 안됨.
    #               2. 10% 할인 쿠폰이 5000원이 안넘으면 10% 가격이 총금액으로 출력됨. -> 해결 완

    # 결제
    def payment(self):
        discount_price = self.total_price

        if not self.cart:
            print("장바구니가 비어있습니다.")
            return

        self.total_price = 0

        for item_number, quantity in self.cart.items():
            price = self.lists[item_number][1]
            self.total_price += price * quantity

        discount_price = self.total_price

        if self.user_choice_coupon == 2:
            discount_price = self.total_price - self.total_price *  0.1
            self.discount = self.total_price * 0.1
            if self.total_price * 0.1 >= 5_000:
                discount_price = self.total_price - 5_000
                self.discount = 5_000
        
        elif self.user_choice_coupon == 3:
            if self.total_price >= 20_000:
                discount_price = self.total_price - 3_000
                self.discount = 3_000

        elif self.user_choice_coupon == 1:
            discount_price = self.total_price
            self.discount = 0
            
        print(f"영수증 출력\n{discount_price}원이 결제가 완료되었습니다. 감사합니다!\n")

        # 카트 안에서 결제가 완료된 상품들의 재고량을 빼자
        for item_number, quantity in self.cart.items():
            self.lists[item_number][2] -= quantity

        # 카트 안으로 정리하고 사용했던 쿠폰과 총 금액을 초기화
        self.cart.clear()
        self.user_choice_coupon = 1
        self.total_price = 0


    # 실행하기
    def run(self):
        while True:
            self.shop_title()
            choice = self.user_choice()

            # 1번 선택 시 상품 목록으로
            if choice == "1":
                self.shop_list()
            # 2번 선택 시 담기
            elif choice == "2":
                self.add_cart()
            # 3번 선택 시 빼기
            elif choice == "3":
                self.remove_cart()
            # 4번 선택 시 장바구니
            elif choice == "4":
                self.show_cart()
            # 5번 선택 시 쿠폰
            elif choice == "5":
                self.coupon()
            # 6번 선택 시 결제
            elif choice == "6":
                self.payment()
            # 종료
            elif choice == "q":
                print("장바구니가 종료됩니다.")
                break

shop = shopping_cart()
shop.run()