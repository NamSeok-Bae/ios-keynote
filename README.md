# ios-keynote 3~4주차 프로젝트

## 아이패드 앱 프로젝트 (완료시간 : 17:20)

### 주요 작업 내용

- Struct를 사용하지않고 모두 Class로 선언하여 구현하였습니다.
- Factory Pattern을 적용하였습니다. 아래와 같은 구조를 가집니다.
    - SlideFactory
        - ImageSlideFactory
        - SquareSlideFactory
- ViewController에서 SlideFactory를 생성하여 SlideType Enum을 통해 ImageSlide 또는 SquareSlide 객체를 생성해줍니다.
- OS_Log 함수를 사용할 때 Message 내부에 형식 지정자(%d, %s)를 통해 number와 description을 담아주었습니다.

## 작업 결과

<img width="80%" alt="image" src="https://github.com/team-dayeng/Dayeng/assets/76683388/83c9d693-8b46-4556-b0f2-ac9b7ae88893">
