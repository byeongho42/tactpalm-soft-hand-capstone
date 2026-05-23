# AI 코딩 툴 활용 캡스톤디자인 보고서

## 1. 과제 개요

- **논문제목**: Soft Robotic Hand with Tactile Palm-Finger Coordination
- **논문 정보**: Nature Communications, volume 16, Article number 2395, 2025
- **사용 AI 코딩 툴**: Cursor
- **GitHub 주소**: https://github.com/byeongho42/tacpalm-soft-hand-capstone
- **프로젝트 주제**: 물류 로봇 및 Gripping 자동화에 적용 가능한 tactile palm-finger coordination 개념의 Windows/Python 기반 재현형 구현

본 과제는 target 논문인 `Soft Robotic Hand with Tactile Palm-Finger Coordination`의 핵심 아이디어를 하드웨어 없이 재현 가능한 소프트웨어 데모로 축소 구현한 것이다. 원 논문은 high-density visual-tactile palm, two-segment pneumatic soft fingers, palm-finger feedback strategy를 결합한 TacPalm SoftHand를 제안한다. 본 프로젝트에서는 실제 soft robotic hand, pneumatic actuator, tactile camera가 없는 환경을 고려하여 synthetic tactile image를 생성하고, 접촉 감지, 물체 분류, 결함 탐지, finger wrap 전환 시뮬레이션을 구현하였다.

## 2. 논문 선택 이유 및 프로젝트 연계성

본인은 회사에서 물류 로봇 및 Gripping 자동화 구현 업무를 수행하고 있으며, 캡스톤디자인 프로젝트도 이와 유사한 방향으로 진행하고 있다. 물류 현장의 그리핑 자동화에서는 카메라 기반 외부 인식뿐 아니라 실제 접촉 상태, 미끄러짐, 눌림, 파손 가능성, 제품 표면 결함 등을 판단하는 기술이 중요하다.

이 논문은 기존 finger/fingertip 중심 tactile sensing 접근과 달리 palm을 주요 접촉/지지/감지 영역으로 활용한다. 이는 다양한 크기와 재질의 물체를 안정적으로 잡아야 하는 물류 로봇 end-effector 설계와 직접적으로 연결된다. 특히 물류 대상물은 박스, 파우치, 병, 캡, 케이블류, 비닐 포장재처럼 형태와 강성이 다양하므로 palm tactile feedback 기반의 grasp strategy는 실무 적용 가능성이 높다고 판단하였다.

## 3. 원 논문 핵심 분석

### 3.1 문제 정의

Soft robotic hand는 compliance가 높아 fragile object나 형상이 다양한 물체를 다루는 데 유리하지만, 실제 접촉 정보를 충분히 감지하지 못하면 안정적인 grasping과 manipulation이 어렵다. 기존 연구는 주로 finger 또는 fingertip sensor에 집중했으나, 사람의 손처럼 palm이 넓은 접촉 면적과 지지 역할을 수행하는 구조는 상대적으로 부족했다.

### 3.2 TacPalm SoftHand 구성

1. **High-density visual-tactile palm**  
   Palm 내부 카메라와 RGB LED 조명을 이용해 접촉에 따른 표면 변형을 tactile image로 획득한다. 이를 통해 접촉 위치, 면적, 형상, 표면 패턴을 분석한다.

2. **Two-segment pneumatic soft fingers**  
   각 finger는 proximal segment와 distal segment를 독립적으로 구동할 수 있다. 이를 통해 precision pinch, distal actuation, proximal actuation, power wrap 등 다양한 grasp mode가 가능하다.

3. **Palm-finger coordination strategy**  
   Palm의 tactile feedback을 이용해 finger motion을 조절한다. 예를 들어 물체가 palm에 충분히 닿았을 때 finger wrap을 시작하거나, 접촉 형상에 따라 grasping pose를 보정한다.

### 3.3 논문 내 알고리즘 요소

- Tactile image 기반 object/fabric classification
- RGB tactile image 변화량 기반 contact detection
- CDM(Color Difference Metric) 기반 fabric flaw detection
- Palm feedback을 이용한 grasping pose adjustment 및 dynamic manipulation

## 4. 과제 구현 범위

원 논문은 실제 하드웨어 의존성이 높으므로, 본 과제에서는 논문의 핵심 개념을 다음과 같이 재현 가능한 소프트웨어 기능으로 변환하였다.

| 원 논문 요소 | 본 과제 구현 방식 |
|---|---|
| 실제 visual-tactile palm camera | synthetic RGB tactile image 생성 |
| 실제 pneumatic soft finger | state machine 기반 finger wrap 전환 시뮬레이션 |
| Palm contact detection | saturation/contact-area 기반 PNHS-like score 구현 |
| CDM 기반 fabric flaw detection | RGB channel range 기반 CDM-like score 구현 |
| ResNet34 기반 tactile classification | image feature + nearest-centroid classifier로 경량 재현 |
| 실제 robot arm/gripper control | Windows/Python에서 실행 가능한 알고리즘 데모로 축소 |

## 5. GitHub 프로젝트 구성

```text
tacpalm-soft-hand-capstone/
├─ README.md
├─ REPORT.md
├─ PROMPTS.md
├─ REPORT.docx
├─ requirements.txt
├─ run_windows.bat
├─ src/
│  └─ tacpalm_demo.py
├─ outputs/
│  ├─ sample_synthetic_tactile_images.png
│  ├─ classification_confusion_matrix.png
│  ├─ coordination_sequence.png
│  ├─ flaw_detection_examples.png
│  ├─ flaw_detection_cdm_hist.png
│  ├─ classification_metrics.csv
│  ├─ flaw_detection_scores.csv
│  └─ metrics.json
└─ docs/
   ├─ plan_comment.md
   ├─ submission_guide.md
   └─ email_template.md
```

## 6. Windows 실행 매뉴얼

### 6.1 사전 준비

- Windows 10/11
- Python 3.10 이상 권장
- GitHub 계정 및 repository: https://github.com/byeongho42/tacpalm-soft-hand-capstone

### 6.2 실행 순서

```bat
cd tacpalm-soft-hand-capstone
python -m venv .venv
.venv\Scriptsctivate
pip install --upgrade pip
pip install -r requirements.txt
python src	acpalm_demo.py --out outputs --n-train 50 --n-test 20 --seed 42
```

또는 `run_windows.bat` 파일을 실행하면 동일한 명령이 순차적으로 수행된다.

### 6.3 결과 확인

실행 후 `outputs/` 폴더에서 결과 이미지와 CSV/JSON 파일을 확인한다. 보고서에는 PNG 결과를 삽입하고, 정량 결과는 `metrics.json` 또는 `classification_metrics.csv`를 기준으로 정리한다.

## 7. 구현 알고리즘 설명

### 7.1 Synthetic tactile image generation

실제 tactile camera가 없기 때문에 각 object class별로 height map을 생성하였다. Bottle cap은 원형 ridge, box corner는 직각 edge, soft pouch는 부드러운 gaussian deformation, cable bundle은 여러 개의 curved line, woven fabric은 반복 texture로 모델링하였다. 이후 height map gradient를 RGB intensity 차이로 변환하여 visual-tactile image처럼 보이도록 구성하였다.

### 7.2 Tactile object classification

생성된 tactile image에서 평균, 표준편차, gradient 통계, 중심부/외곽부 특징 등을 추출하였다. 학습 데이터의 class별 feature centroid를 계산하고, test image는 가장 가까운 centroid에 할당하는 nearest-centroid classifier를 적용하였다. 원 논문의 ResNet34 기반 fine-tuning을 그대로 재현하지는 않았지만, 과제 환경에서 실행이 쉽고 알고리즘 흐름을 설명하기 적합하도록 경량 분류기로 대체하였다.

### 7.3 Palm-finger coordination simulation

Reference tactile image와 current tactile image의 차이를 계산하고, saturation/contact-area 기반 score를 산출하였다. Score가 threshold를 넘으면 palm에 물체가 충분히 접촉한 것으로 판단하고, robot state를 `approach`에서 `wrap`으로 전환한다. 이는 논문의 palm tactile feedback 기반 finger control 개념을 state machine으로 단순화한 것이다.

### 7.4 Fabric flaw detection

정상 fabric image와 결함 fabric image를 생성한 뒤, reference image와의 RGB channel range 차이를 합산하여 CDM-like score를 계산하였다. Score가 threshold보다 크면 결함이 있는 것으로 판단하였다. 이 구현은 원 논문의 CDM 기반 flaw detection 아이디어를 synthetic data 환경에 맞게 축소한 것이다.

## 8. 실행 결과

실행 조건은 다음과 같다.

```bat
python src	acpalm_demo.py --out outputs --n-train 50 --n-test 20 --seed 42
```

| 항목 | 결과 |
|---|---:|
| Tactile object classification accuracy | 0.990 |
| Fabric flaw detection accuracy | 1.000 |
| Palm-finger wrap trigger time step | 12 |

### 8.1 Synthetic tactile image 예시

결과 파일: `outputs/sample_synthetic_tactile_images.png`

### 8.2 Object classification 결과

결과 파일: `outputs/classification_confusion_matrix.png`

Class별 accuracy는 bottle_cap 1.000, box_corner 1.000, soft_pouch 1.000, cable_bundle 1.000, woven_fabric 0.950으로 확인되었다. 전체 accuracy는 0.990이다.

### 8.3 Palm-finger coordination 결과

결과 파일: `outputs/coordination_sequence.png`

접촉 score가 threshold 420를 초과한 시점은 time step 12이며, 이 시점부터 finger state가 `wrap`으로 전환된다.

### 8.4 Fabric flaw detection 결과

결과 파일: `outputs/flaw_detection_cdm_hist.png`, `outputs/flaw_detection_examples.png`

Synthetic fabric data 기준 결함 탐지 accuracy는 1.000이다. 다만 threshold는 synthetic RGB scale에 맞게 calibration한 값이므로 실제 촉각 센서 적용 시에는 별도의 calibration이 필요하다.

## 9. AI 코딩 툴(Cursor) 활용 내용

Cursor는 다음 단계에서 활용하였다.

1. 논문 핵심 개념 정리 및 구현 범위 축소
2. Windows에서 실행 가능한 Python repository 구조 설계
3. synthetic tactile image generation 코드 작성
4. PNHS-like contact score 및 CDM-like flaw detection 구현
5. classification, visualization, metrics 저장 코드 작성
6. README, REPORT, PROMPTS.md 작성 보조
7. 실행 오류 및 dependency 문제 해결

프롬프트 로그는 GitHub root의 `PROMPTS.md`에 별도로 정리하였다.

## 10. 한계점

- 실제 TacPalm SoftHand 하드웨어를 제작하거나 제어하지 않았다.
- 실제 tactile camera image가 아니라 synthetic tactile image를 사용하였다.
- 원 논문에서 사용한 ResNet34 fine-tuning을 그대로 수행하지 않았다.
- 실제 pneumatic pressure, robot arm trajectory, grasp force measurement는 구현하지 않았다.
- 실제 물류 현장의 조명, 재질, 마찰, 미끄러짐, 파손 위험 등은 제한적으로만 반영하였다.

## 11. 개선 방향

1. 저가형 camera-based tactile sensor 또는 pressure sensor를 부착하여 실제 접촉 데이터를 수집한다.
2. 실제 물류 대상물인 박스, 파우치, 캡, 병, 튜브, 케이블, 비닐 포장재를 대상으로 dataset을 구축한다.
3. ResNet34 또는 MobileNet 계열 모델을 이용하여 tactile image classification을 고도화한다.
4. PLC/robot controller와 연동하여 contact-triggered gripping sequence를 구현한다.
5. Grasp success rate, slip detection, damage rate, cycle time 등 물류 자동화 관점의 KPI로 평가한다.

## 12. 결론

본 프로젝트는 `Soft Robotic Hand with Tactile Palm-Finger Coordination` 논문을 기반으로, 물류 로봇 Gripping 자동화에 적용 가능한 tactile palm-finger coordination 개념을 Windows/Python 환경에서 재현하였다. 실제 하드웨어 구현은 제외하였지만, synthetic tactile image 생성, tactile object classification, CDM-like flaw detection, contact-triggered finger wrap 시뮬레이션을 통해 논문의 핵심 개념을 과제 수준에서 검증하였다.

본 결과물은 향후 실제 gripper와 tactile sensor를 적용한 물류 로봇 자동화 프로젝트의 초기 알고리즘 검증 자료로 활용할 수 있다.

## 13. 참고문헌

1. Zhang, N., Ren, J., Dong, Y. et al. Soft robotic hand with tactile palm-finger coordination. Nature Communications 16, 2395 (2025). DOI: 10.1038/s41467-025-57741-6. URL: https://www.nature.com/articles/s41467-025-57741-6
2. Cursor official website. URL: https://cursor.com
3. GitHub repository for this project. URL: https://github.com/byeongho42/tacpalm-soft-hand-capstone
