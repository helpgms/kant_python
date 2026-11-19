import random

print("=" * 25)
print("     가위 / 바위 / 보      ")
print("=" * 25)
user_name = input("이름 입력하세요: ")
hands = [(1,"가위"), (2,"바위"), (3, "보")]

user_wins_count = 0
computer_wins_count = 0
try_count = 0

while user_wins_count < 2 and computer_wins_count < 2:
    user_hands = input("1. 가위 / 2. 바위 / 3. 보 \n번호를 선택하세요 : ")
    computer_hands = random.choice(hands)
    user = 0
    if user_hands == "q":
        print("게임이 종료됩니다.")
        break

    if user_hands == "1":
        user = "가위"
    elif user_hands == "2":
        user = "바위"
    elif user_hands == "3":
        user = "보"

    if (int(user_hands) - int(computer_hands[0])) % 3 == 0:
        print(f"{user_name}: {user} vs 컴퓨터 : {computer_hands[1]}\n => 비김\n현재 스코어 {user_name} {user_wins_count} : {computer_wins_count} 컴퓨터")
    elif (int(user_hands) - int(computer_hands[0])) % 3 == 1:
        try_count += 1
        user_wins_count += 1
        print(f"{user_name}: {user} vs 컴퓨터 : {computer_hands[1]}\n => 승리\n현재 스코어 {user_name} {user_wins_count} : {computer_wins_count} 컴퓨터")
    elif (int(user_hands) - int(computer_hands[0])) % 3 == 2:
        try_count += 1
        computer_wins_count += 1
        print(f"{user_name}: {user} vs 컴퓨터 : {computer_hands[1]}\n => 패배\n현재 스코어 {user_name} {user_wins_count} : {computer_wins_count} 컴퓨터")