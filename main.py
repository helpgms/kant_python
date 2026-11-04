# 가위 바위 보 게임 미니 프로젝트
import random

print("=" * 30)
print("가위바위보 게임")
print("=" * 30)

user_name = input("이름을 입략해주세요: ")

hands = ["가위", "바위", "보"]
try_count = 0
user_win_count = 0
computer_win_count = 0


while try_count < 3 and user_win_count <= 2 and computer_win_count <= 2:
    computer = random.choice(hands)
    print("종료를 희망하시면 q를 누르시오")
    user_hands = input("입력하세요 : ")
    if user_hands == "q":
        print("게임이 종료됩니다.")
        break
    if computer == user_hands:
        print("[게임 결과]")
        print(f"{user_name}: {user_hands} vs 컴퓨터: {computer}")
        print("비김")
        # break
    elif computer != user_hands:
        # 패배 조건
        if computer == "가위" and user_hands == "보":
            try_count += 1
            computer_win_count += 1
            print("[게임 결과]")
            print(f"{user_name}: {user_hands} vs 컴퓨터: {computer}")
            print("패배")
            # break
        elif computer == "바위" and user_hands == "가위":
            try_count += 1
            computer_win_count += 1
            print("[게임 결과]")
            print(f"{user_name}: {user_hands} vs 컴퓨터: {computer}")
            print("패배")
            # break
        elif computer == "보" and user_hands == "바위":
            try_count += 1
            computer_win_count += 1
            print("[게임 결과]")
            print(f"{user_name}: {user_hands} vs 컴퓨터: {computer}")
            print("패배")
            # break
        # 승리 조건
        elif computer == "보" and user_hands == "가위":
            try_count += 1
            user_win_count += 1
            print("[게임 결과]")
            print(f"{user_name}: {user_hands} vs 컴퓨터: {computer}")
            print("승리")
            # break
        elif computer == "가위" and user_hands == "바위":
            try_count += 1
            user_win_count += 1
            print("[게임 결과]")
            print(f"{user_name}: {user_hands} vs 컴퓨터: {computer}")
            print("승리")
            # break
        elif computer == "바위" and user_hands == "보":
            try_count += 1
            user_win_count += 1
            print("[게임 결과]")
            print(f"{user_name}: {user_hands} vs 컴퓨터: {computer}")
            print("승리")
            # break
    
if user_win_count > computer_win_count:
    print(f"최종 스코어 나: {user_win_count} : {computer_win_count} 컴퓨터")
    print(f"{user_name} 승리")
elif user_win_count < computer_win_count:
    print(f"최종 스코어 나: {user_win_count} : {computer_win_count} 컴퓨터")
    print("컴퓨터 승리")