# ios-keynote 3~4주차 프로젝트

## 관찰자(Observer) 패턴 (완료일 7/24 16:30)

### 주요 작업 내용

- 3-2 과제 피드백 적용
    - Extension Fileprivate 적용
    - identifier, alpha 를 Custom Type으로 변경
    - SlideManager Protocol 생성
    - SlideFactory Protocol 생성
- SlideManager Test 함수 작성
    - MockFactory와 MockSlideManager를 통해 테스트 진행
- NotificationCenter Observer 적용
    - SlideManager에서 Create, alpha & backgroundColor Update가 일어날떄마다 Notificiation을 Post해주고 ViewController에서 해당 이벤트를 받아 뷰를 업데이트 해주는 방식으로 처리

## Notification 구조
<img width="100%" alt="image" src="https://github.com/team-dayeng/Dayeng/assets/76683388/4ca46d66-e585-4297-80f9-386e2d8416b6">

## 테스트 함수 전체보기
<img width="50%" alt="image" src="https://github.com/team-dayeng/Dayeng/assets/76683388/d64ba58d-afcc-4b39-b33c-a1e560928117">

