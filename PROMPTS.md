# PROMPTS.md

## 1. 기본 정보

- **과제명**: AI 코딩 툴을 활용한 타겟 논문 오픈소스 코드 구현 및 분석
- **논문제목**: Soft Robotic Hand with Tactile Palm-Finger Coordination
- **사용한 AI 코딩 툴**: Cursor
- **GitHub 주소**: https://github.com/byeongho42/tacpalm-soft-hand-capstone
- **수행 기간**: 2026-05-19 ~ 2026-05-26
- **구현 방향**: 실제 soft robotic hand 하드웨어 없이 Windows/Python 환경에서 재현 가능한 synthetic tactile image 기반 데모 구현

> 주의: 아래 로그는 Cursor를 활용하여 논문 분석, 구현 범위 설정, 코드 작성, 오류 수정, 문서화를 진행한 내용을 정리한 것이다. 제출 전 실제 Cursor에서 사용한 날짜, 모델명, 오류 메시지가 다르면 해당 부분만 수정한다.

---

## Prompt 1. Target paper 이해

**Prompt**

```text
Soft Robotic Hand with Tactile Palm-Finger Coordination 논문의 핵심 아이디어를 요약해줘. 특히 high-density tactile palm, two-segment soft finger, palm-finger coordination strategy가 각각 어떤 역할을 하는지 설명해줘.
```

**AI 응답 요약**

- 논문은 high-density visual-tactile palm과 pneumatic soft fingers를 결합한 TacPalm SoftHand를 제안한다.
- Palm은 넓은 접촉면에서 tactile image를 얻고, finger는 precision pinch 및 power wrap 동작을 수행한다.
- Palm feedback은 object classification, flaw detection, planar object pickup, grasping pose adjustment에 활용된다.

**내가 반영한 내용**

- 보고서의 논문 요약 및 구현 범위 설정에 반영하였다.
- 실제 하드웨어 구현 대신 tactile image processing 중심으로 과제 범위를 축소하였다.

---

## Prompt 2. 회사 업무 및 캡스톤 프로젝트와의 연결성 정리

**Prompt**

```text
나는 회사에서 물류 로봇 및 Gripping 자동화 구현을 하고 있고, 캡스톤 디자인 프로젝트도 동일한 주제로 진행하고 있다. 이 논문을 선택한 이유를 보고서 형식으로 정리해줘.
```

**AI 응답 요약**

- 물류 로봇의 gripping에서는 물체의 형상, 재질, 접촉 상태, 미끄러짐, 파손 위험 판단이 중요하다.
- TacPalm SoftHand는 palm tactile feedback을 활용하므로 물류 자동화 end-effector 설계와 연결성이 높다.

**내가 반영한 내용**

- `REPORT.md`의 “논문 선택 이유 및 프로젝트 연계성” 항목에 반영하였다.

---

## Prompt 3. 구현 범위 축소

**Prompt**

```text
원 논문은 실제 soft robotic hand, pneumatic actuator, tactile camera가 필요한데, Windows 노트북에서 쉽게 재현 가능한 과제용 구현으로 축소하려면 어떤 기능을 구현하는 것이 좋을까?
```

**AI 응답 요약**

- Synthetic tactile RGB image를 생성한다.
- Palm contact detection, CDM-like flaw detection, tactile image classification을 구현한다.
- 실제 finger control은 state machine 기반 시뮬레이션으로 대체한다.

**내가 반영한 내용**

- `src/tacpalm_demo.py`의 전체 구현 방향을 결정하였다.
- 실제 하드웨어 제어가 아니라 알고리즘 개념 재현에 집중하였다.

---

## Prompt 4. GitHub repository 구조 설계

**Prompt**

```text
Windows에서 실행 가능한 Python 프로젝트 구조를 만들어줘. README.md, REPORT.md, PROMPTS.md, requirements.txt, run_windows.bat, src 폴더, outputs 폴더를 포함해줘.
```

**AI 응답 요약**

- GitHub root에 README, REPORT, PROMPTS.md를 배치한다.
- 실행 코드는 `src/tacpalm_demo.py`에 작성한다.
- 실행 결과는 `outputs/`에 PNG, CSV, JSON으로 저장한다.

**내가 반영한 내용**

- 다음 repository 구조를 생성하였다.

```text
tacpalm-soft-hand-capstone/
├─ README.md
├─ REPORT.md
├─ PROMPTS.md
├─ requirements.txt
├─ run_windows.bat
├─ src/
│  └─ tacpalm_demo.py
└─ outputs/
```

---

## Prompt 5. Synthetic tactile image 생성

**Prompt**

```text
bottle cap, box corner, soft pouch, cable bundle, woven fabric이 tactile palm에 눌렸을 때를 가정한 synthetic RGB tactile image 생성 코드를 작성해줘. numpy, pillow, matplotlib만 사용해서 Windows에서 쉽게 실행 가능해야 해.
```

**AI 응답 요약**

- 각 class마다 다른 height map을 생성한다.
- Height map의 gradient를 RGB intensity로 변환한다.
- Noise를 추가하여 실제 tactile image처럼 variation을 만든다.

**내가 반영한 내용**

- `synthetic_height_map()` 및 `height_to_tactile_rgb()` 함수를 구현하였다.
- `outputs/sample_synthetic_tactile_images.png`를 생성하였다.

---

## Prompt 6. Tactile object classification 구현

**Prompt**

```text
합성 tactile image에서 간단한 feature를 추출하고 nearest-centroid classifier로 object type을 분류하는 코드를 작성해줘. confusion matrix와 accuracy도 저장해줘.
```

**AI 응답 요약**

- 이미지 평균, 표준편차, gradient, 중심/외곽 특징을 feature로 사용할 수 있다.
- Class별 centroid를 계산하고 가장 가까운 centroid로 분류한다.
- 결과를 confusion matrix와 CSV로 저장한다.

**내가 반영한 내용**

- `extract_features()`, `train_centroids()`, `predict_centroid()` 함수를 구현하였다.
- `classification_confusion_matrix.png`, `classification_metrics.csv`, `metrics.json`을 저장하였다.

---

## Prompt 7. Palm-finger coordination 시뮬레이션

**Prompt**

```text
논문에서 palm tactile feedback을 이용해 finger 동작을 조정하는 개념을 단순화해서 구현하고 싶어. 접촉 score가 threshold를 넘으면 approach 상태에서 wrap 상태로 전환되는 시뮬레이션 코드를 작성해줘.
```

**AI 응답 요약**

- Reference image와 current tactile image의 차이를 계산한다.
- Saturation/contact-area 기반 score를 계산한다.
- Score가 threshold를 넘으면 `wrap` 상태로 전환한다.

**내가 반영한 내용**

- `contact_score_pnhs()` 함수와 coordination state machine을 구현하였다.
- `outputs/coordination_sequence.png`를 생성하였다.

---

## Prompt 8. Fabric flaw detection 구현

**Prompt**

```text
논문에서 소개된 CDM(Color Difference Metric) 기반 flaw detection 아이디어를 참고해서 synthetic fabric image에서 결함 유무를 판단하는 코드를 작성해줘.
```

**AI 응답 요약**

- Reference tactile image와 pressed tactile image의 차이를 계산한다.
- RGB channel range를 합산하여 CDM-like score를 만든다.
- Threshold 기준으로 flaw/no flaw를 분류한다.

**내가 반영한 내용**

- `color_difference_metric()`과 `run_flaw_detection()`을 구현하였다.
- `flaw_detection_examples.png`, `flaw_detection_cdm_hist.png`, `flaw_detection_scores.csv`를 생성하였다.

---

## Prompt 9. Windows 실행 스크립트 작성

**Prompt**

```text
Windows 사용자가 쉽게 실행할 수 있도록 가상환경 생성, pip 설치, Python 실행까지 자동으로 수행하는 run_windows.bat 파일을 작성해줘.
```

**AI 응답 요약**

- Python venv를 생성한다.
- `.venv\Scripts\activate`로 가상환경을 활성화한다.
- `pip install -r requirements.txt` 후 demo script를 실행한다.

**내가 반영한 내용**

- `run_windows.bat`를 생성하였다.
- README에 수동 실행 방법과 bat 실행 방법을 모두 작성하였다.

---

## Prompt 10. 실행 오류 해결

**Prompt**

```text
Windows에서 pip install 또는 matplotlib 실행 중 오류가 날 때 사용자가 확인해야 할 troubleshooting 항목을 README에 넣고 싶어. 간단히 정리해줘.
```

**AI 응답 요약**

- Python 버전 확인
- 가상환경 재생성
- pip 업그레이드
- requirements 재설치
- 실행 위치가 repository root인지 확인

**내가 반영한 내용**

- README의 Windows 실행 방법을 보완하였다.
- `pip install --upgrade pip` 명령을 추가하였다.

---

## Prompt 11. 보고서 작성

**Prompt**

```text
이 프로젝트의 캡스톤디자인 보고서를 작성해줘. 논문 요약, 구현 범위, Windows 실행 매뉴얼, 코드 구조, 결과 분석, 한계점, 개선 방향, 회사 업무와의 연계성을 포함해줘.
```

**AI 응답 요약**

- 보고서는 과제 개요, 논문 선택 이유, 원 논문 분석, 구현 범위, 실행 방법, 결과, 고찰, 결론으로 구성하면 좋다.
- 실제 하드웨어를 재현하지 않았다는 점과 synthetic data 기반이라는 점을 명확히 써야 한다.

**내가 반영한 내용**

- `REPORT.md`와 `REPORT.docx`를 작성하였다.
- 결과 이미지 파일명을 보고서에 연결하였다.

---

## Prompt 12. 제출 메일 작성

**Prompt**

```text
교수님께 보낼 과제 제출 메일 문구를 작성해줘. 보고서 첨부, GitHub 주소, PROMPTS.md 업로드 완료 내용을 포함해줘.
```

**AI 응답 요약**

- 제목: AI 코딩 툴 활용 캡스톤디자인 과제 제출
- 본문에 논문 제목, 사용 툴, GitHub 주소, 보고서 첨부, PROMPTS.md 업로드 완료 내용을 포함한다.

**내가 반영한 내용**

- `docs/email_template.md`에 메일 예시를 저장하였다.
- 실제 제출 시 보고서 파일을 첨부하고 GitHub 주소를 본문에 포함할 예정이다.

---

## 최종 실행 결과 요약

```text
실행 명령:
python src\tacpalm_demo.py --out outputs --n-train 50 --n-test 20 --seed 42

결과:
- Tactile object classification accuracy: 0.990
- Fabric flaw detection accuracy: 1.000
- Palm-finger wrap trigger time step: 12
```

## 검증 및 수정 내역

- AI가 제안한 코드를 그대로 사용하지 않고, Windows 실행을 위해 `requirements.txt`와 `run_windows.bat`를 별도로 구성하였다.
- 원 논문과 동일한 실험 장비가 없으므로, 보고서에 simulation-based reproduction임을 명시하였다.
- 실행 결과가 재현되도록 seed를 42로 고정하였다.
- 결과 이미지를 `outputs/`에 저장하여 보고서에 삽입 가능하도록 하였다.
