# TacPalm SoftHand Capstone Demo

Target paper: **Soft Robotic Hand with Tactile Palm-Finger Coordination**  
Publication: Nature Communications 16, Article 2395 (2025)  
AI coding tool: **Cursor**  
GitHub: https://github.com/byeongho42/tacpalm-soft-hand-capstone

이 저장소는 물류 로봇 및 Gripping 자동화 관점에서, 논문의 핵심 아이디어인 **tactile palm + finger coordination**을 Windows에서 쉽게 실행 가능한 Python 소프트웨어 데모로 재현합니다.

> 주의: 이 저장소는 논문 저자의 공식 구현이 아닙니다. 원 논문은 실제 soft robotic hand, pneumatic actuator, visual-tactile palm camera가 필요한 하드웨어 연구입니다. 본 저장소는 과제 제출을 위해 synthetic tactile image를 생성하고 알고리즘 개념을 재현한 구현입니다.

## 1. 구현한 기능

1. **Synthetic tactile image generation**
   - bottle_cap, box_corner, soft_pouch, cable_bundle, woven_fabric class 생성

2. **Tactile object classification**
   - image feature + nearest-centroid classifier
   - confusion matrix, accuracy CSV/JSON 저장

3. **Palm-finger coordination simulation**
   - PNHS-like contact score가 threshold를 넘으면 `approach`에서 `wrap`으로 상태 전환

4. **Fabric flaw detection**
   - CDM-like color difference metric 기반 flaw/no flaw 판단

## 2. Windows 실행 방법

### 2.1 Python 버전 확인

```bat
python --version
```

Python 3.10 이상 권장입니다.

### 2.2 가상환경 생성 및 활성화

```bat
python -m venv .venv
.venv\Scriptsctivate
```

### 2.3 패키지 설치

```bat
pip install --upgrade pip
pip install -r requirements.txt
```

### 2.4 코드 실행

```bat
python src	acpalm_demo.py --out outputs --n-train 50 --n-test 20 --seed 42
```

또는 아래 파일을 실행합니다.

```bat
run_windows.bat
```

## 3. 현재 포함된 예시 실행 결과

| 항목 | 결과 |
|---|---:|
| Tactile object classification accuracy | 0.990 |
| Fabric flaw detection accuracy | 1.000 |
| Palm-finger wrap trigger time step | 12 |

## 4. 결과 파일

| 파일 | 설명 |
|---|---|
| `outputs/sample_synthetic_tactile_images.png` | 합성 tactile image 예시 |
| `outputs/classification_confusion_matrix.png` | object classification confusion matrix |
| `outputs/coordination_sequence.png` | contact-triggered finger wrap 시뮬레이션 |
| `outputs/flaw_detection_examples.png` | 정상/결함 tactile image 예시 |
| `outputs/flaw_detection_cdm_hist.png` | CDM-like flaw detection histogram |
| `outputs/metrics.json` | 전체 정량 결과 |
| `outputs/classification_metrics.csv` | classification 결과 표 |
| `outputs/flaw_detection_scores.csv` | flaw detection score 표 |

## 5. 제출물

- `REPORT.docx`: 보고서(매뉴얼, 분석 내용, 실행 결과 포함)
- `REPORT.md`: GitHub에서 보기 쉬운 보고서
- `PROMPTS.md`: AI 코딩 툴 활용 프롬프트 로그
- `src/tacpalm_demo.py`: 구현 코드
- `outputs/`: 실행 결과 이미지 및 metric 파일

## 6. GitHub 업로드 명령어

```bat
git init
git add .
git commit -m "Initial capstone implementation"
git branch -M main
git remote add origin https://github.com/byeongho42/tacpalm-soft-hand-capstone.git
git push -u origin main
```

이미 GitHub repository를 만들었다면, 웹에서 파일을 drag & drop으로 업로드해도 됩니다.

## 7. Troubleshooting

- `python` 명령이 안 되면 Python 설치 시 `Add Python to PATH`를 체크했는지 확인합니다.
- 패키지 설치 오류가 나면 가상환경을 삭제한 뒤 다시 생성합니다.
- `ModuleNotFoundError`가 나오면 가상환경 활성화 후 `pip install -r requirements.txt`를 다시 실행합니다.
- 결과 파일이 생성되지 않으면 현재 위치가 repository root인지 확인합니다.
