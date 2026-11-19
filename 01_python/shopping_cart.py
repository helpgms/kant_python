# shopping cart class 선언
class ShoppingCart:
    def __init__(self):
        self.bucket = []    

    # 상품 담기
    def add_products(self, product):
        self.bucket.append(product)
    # 상품 빼기
    def remove_product(self,product):
        self.bucket.remove(product)

    # 상품 목록 조희
    def show_products(self):
        return self.bucket


# 상품 목록 저장 기능
# 메서드 추가
# - 장바구니 담기
# - 장바구니 빼기

# 상품 class
# 속성 
# - 제품명
# - 가격
class Product:
    def __init__(self,name,price):
        self.name = name
        self.price = price

# 쇼핑 카트 생성
cart = ShoppingCart()

# 상품 3개 생성
product_a = Product("초코파이", 2_000)
product_b = Product("초콜렛", 5_000)
product_c = Product("초코송이", 8_000)
# 상품 1개 장바구니 담기
cart.add_products(product_a)
# 상품 1개 더 장바구니 담기
cart.add_products(product_b)
# 상품 1개 더 장바구니 담기
cart.add_products(product_c)

# 상품 1개 장바구니에서 빼기
cart.remove_product(product_b)
# 장바구니 담긴 최종 상품 목록 조희
for product in cart.show_products():
    print([product.name, product.price])

