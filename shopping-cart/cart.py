from product import Product

class Cart:
    def __init__(self):
        # 빈 장바구니 생성
        self.items = {} # {상품: 수량}

    # 장바구니에 상품 담기
    def add(self, product, quantity):
        # 품절 상품은 담을 수 없음
        if product.is_sold_out():
            print("품절된 상품입니다.")
            return

        # 이미 장바구니에 담겨있는 상품 수량 확인
        in_cart_qty = self.items.get(product, 0)
        # 더 담을 수 있는 수량
        extra_qty = product.stock - in_cart_qty
        if quantity > extra_qty: # 재고 수량 범위를 벗어난 경우
            print(f"재고가 부족합니다. (담을 수 있는 수량:{extra_qty}개)")
            return

        self.items[product] = self.items.get(product, 0) + quantity
        print(f"{product.name} {quantity}개를 담았습니다.")

    # 장바구니에서 상품 제거(빼기)
    def remove(self, product, quantity):
        # 장바구니에 없는 상품은 뺄 수 없다.
        if product not in self.items:
            print("뺄 상품이 없습니다")
            return

        # 담은 수량이 이상이면 다 삭제
        if quantity >= self.items[product]:
            del self.items[product]
            print(f"{product.name}를 모두 제거했습니다.")
        else:
            self.items[product] -= quantity
            print(f"{product.name}를 {quantity}개를 제거했습니다")

    # 장바구니 비어있는지 확인
    def is_empty(self):
        return len(self.items) == 0

    # 상품 합계 계산
    def subtotal(self):
        return sum(p.price * q for p,q in self.items.items())

    # 배송비
    def shipping(self):
        if self.is_empty(): return 0
        return 0 if self.subtotal() >= 30_000 else 3_000

    # 결제 금액 계산
    def total(self):
        return self.subtotal() + self.shipping()

    # 장바구니 내용 출력
    def show(self):
        line = "-" * 40
        print(line)

        if self.is_empty():
            print("장바구니 비어있습니다.")

        for p,q in self.items.items():
            # 제품명 x 수량 = 총합계
            print(f"{p.name:<10} x {q:<3} = {p.price * q:>12,}원")

        print(line)
        print(f"{'상품 합계':<10} {self.subtotal():>15,}원")
        print(f"{'배송비':<10} {self.shipping():>15}원")
        print(f"{'결제 금액':<10} {self.total():>15,}원")
        print(line)

    def checkout(self):
        if self.is_empty(): return

        self.show()
        # 재고 감소 처리
        for p,q in self.items.items():
            p.stock -= q

        # 장바구니 비우기
        self.items.clear()

        # 결제 완료 skip
        print("결제가 완료되었습니다. 감사합니다.")

# ------------  test code  ----------------
# 제품 인스턴스 생성
tumbler = Product("텀블러", 15_000, 10)
earphone = Product("무선 이어폰", 89_000, 3)
# 카트 인스턴스 생성
cart = Cart()
cart.add(tumbler, 3)
cart.add(earphone, 2)
cart.checkout()

print(tumbler)
print(earphone)