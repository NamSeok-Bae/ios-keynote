# ios-keynote 3~4주차 프로젝트

## 사진 슬라이드 추가하기 (완료일 7/27 01:00)

### 주요 작업 내용

- Cell에 ContextMenuInteraction를 할당
- ImageSlideView에 원 탭, 투 탭 기능 할당
- ContextMenuInteraction의 메뉴에 따른 동작 구현
- UIGraphicsImageRenderer를 활용한 Image Resize
    - resize한 결과에 따라 ImageSlideView Size 재정의
- SlideFactory에서 Random Slide 생성

## 작업결과

### 사진 등록
<img width="100%" alt="image" src="https://github.com/team-dayeng/Dayeng/assets/76683388/2334c759-d0e4-4543-81a7-3f1dc0b4518b">

### 메뉴 4개를 통한 Slide 이동
<img width="100%" alt="image" src="https://github.com/team-dayeng/Dayeng/assets/76683388/01935822-51b6-4159-bb29-f8e9a65e915e">

## 고민
- UIView 내부에서 자그마한 로직들을 구현하면서 생긴 의문점이 있습니다.
- 어제 스쿼드 세션 뿐만 아니라 동료분들과 대화하면서 View 내부의 프로퍼티를 사용해 로직을 구현하는 과정을 Model에서 진행하는게 맞다고 생각하였습니다.
- 하지만 isTapped = !isTapped 또는 이런 비슷한 로직들을 위해 따로 ViewModel을 만들어서 주는게 맞는지, 하위 뷰의 1개의 로직만을 위한 ViewModel을 만드는게 맞는건지 고민이 있습니다.
- 제 생각엔 단순한 로직 같은 경우 Model을 만들고 binding을 해주는 것보다 View에서 처리하는게 맞다고 생각하는데, 어떤 것이 효율적인 성능을 이끌어내는지 궁금합니다.