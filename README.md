# ios-keynote 3~4주차 프로젝트

## 슬라이드 목록 표시 (완료일 7/26 00:00)

### 주요 작업 내용

- 오른쪽에 위치한 Inspector 처리 부분의 뷰들을 분리 (InspertorView 안에 처리)
- UITableView 생성 및 구현
    - Add Button을 통한 동적 Cell 생성
    - DragDelegate 와 DropDelegate를 활용하여 Drag And Drop 구현
    - Cell 의 선택과 해제가 가능하도록 구현

## 작업결과

### 셀 선택과 해제
<img width="100%" alt="image" src="https://github.com/team-dayeng/Dayeng/assets/76683388/3f499046-c1bb-4093-b8cf-75bdd3d231f1">

### 셀 드래그 앤 드롭
<img width="100%" alt="image" src="https://github.com/team-dayeng/Dayeng/assets/76683388/2e855310-ace3-41cd-a71a-f713b162bddc">

## 고민
- 구현을 하는 과정에서 어떤 코드 작성이 좋은 코드인가에 대해 고민하였습니다.
- 동료 개발자가 실행돌릴 때 컴파일 에러가 뜨는 것이 좋은건지, 아무렇게나 써도 돌아가는 코드가 좋은건지에 대해서 입니다.
- 전자는 컴파일 시점에서 확실히 확인할 수 있다는 특징이 있고, 후자에 대해선 테스트 코드를 통해 확인할 수 있다는 특징이 있다고 생각합니다.
- JK님은 어떻게 생각하시나요?