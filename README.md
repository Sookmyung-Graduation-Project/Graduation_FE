# 🎓 GraduationCollaborate

졸업 프로젝트 프론트 레포입니다. 


## 🗂️ Index

- [프로젝트 개요](#프로젝트-개요)
- [팀 구성 및 담당 역할](#팀-구성-및-담당-역할)
- [기능 요약](#기능-요약)
- [화면 미리보기](#화면-미리보기)
- [핵심 기능 코드 예시](#핵심-기능-코드-예시)
- [빌드 및 실행 매뉴얼](#빌드-및-실행-매뉴얼)
- [추후 확장 방안](#추후-확장-방안)

## 📌 프로젝트 개요

<table>
  <tr>
    <td width="80">
      <img src="assets/icon/app_icon.png" width="60" alt="GraduationCollaborate App Icon"/>
    </td>
    <td>
      <h2><b>GraduationCollaborate</b> - 졸업 프로젝트 협업 플랫폼</h2>
    </td>
  </tr>
</table>

### 🔹 개발 기간
2025년 3월 ~ 2025년 8월

### 🔹 개발 배경
대학교 졸업 프로젝트에서 팀원 간 일정 공유, 진척 관리, 피드백 수집의 필요성이 커지고 있습니다. 기존 메신저나 간단한 공유 드라이브만으로는 체계적인 협업과 산출물 관리에 한계가 있습니다.

### 🔹 개발 목표

- **졸업 프로젝트 전용 협업 플랫폼 구현**
- **할 일, 일정, 산출물, 피드백 통합 관리**
- **사용자 친화적 UI 제공으로 협업 효율 향상**

### 🔹 주요 기술 스택

[Frontend]
├── Flutter
├── Provider (State Management)
└── http (API 연동)

## Project Structure

```bash
lib/
├── data
│   └── word_data.dart
├── main.dart
├── screens
│   ├── custom_progress_bar.dart
│   ├── lesson_screen.dart
│   ├── phonics_home.dart
│   ├── phonics_screen.dart
│   └── quiz_screen.dart
└── widgets
    ├── basic_lg_button.dart
    ├── draggable_widget.dart
    ├── phonics_button.dart
    ├── phonics_word_widget.dart
    └── quiz_button.dart
```
---

## 👥 팀 구성 및 담당 역할

| 프로필 | 이름 (GitHub) | 담당 기능 | 세부 내용 |
|--------|---------------|-----------|-----------|
| ![김문원](https://github.com/angkmfirefoxygal.png) | 김문원 ([angkmfirefoxygal](https://github.com/angkmfirefoxygal)) | **Task 관리 UI, 캘린더 연동** | 과제/할 일 등록, 수정, 삭제 UI 및 캘린더 라이브러리 연동 |
| ![하고은](https://github.com/hagoeun0119.png) | 하고은 ([hagoeun0119](https://github.com/hagoeun0119)) | **Firebase Auth 연동 및 홈 UI** | 로그인/회원가입 흐름 구현, 프로젝트별 홈 화면 UI |
| ![전시원](https://github.com/siiion.png) | 전시원 ([siiion](https://github.com/siiion)) | **프로젝트 상세 및 피드백 UI** | 프로젝트별 상세 페이지, 피드백 리스트 및 작성 기능 |

---

## 🧩 기능 요약

### ✅ 핵심 기능

1. **회원가입 및 로그인 (Firebase Auth)**
2. **프로젝트 생성 및 팀원 초대**
3. **할 일(Task) 등록, 수정, 삭제**
4. **캘린더 기반 일정 관리**
5. **산출물 파일 업로드 및 관리**
6. **팀원 피드백 작성 및 조회**

---

## 🖼️ 화면 미리보기

| 기능 | 이미지 |
|------|--------|
| 로그인 화면 | <img src="assets/screens/login.png" width="200"/> |
| 회원가입 화면 | <img src="assets/screens/signup.png" width="200"/> |
| 홈 (프로젝트 리스트) | <img src="assets/screens/home.png" width="200"/> |
| 프로젝트 상세 | <img src="assets/screens/project_detail.png" width="200"/> |
| 할 일 관리 | <img src="assets/screens/task.png" width="200"/> |
| 캘린더 뷰 | <img src="assets/screens/calendar.png" width="200"/> |
| 피드백 작성 | <img src="assets/screens/feedback.png" width="200"/> |

---



## GIF
<p align="center">
  <img src="https://github.com/user-attachments/assets/f2dec122-9369-4403-8066-01af3b3c7454" width="200">
  <img src="https://github.com/user-attachments/assets/1b0c763d-879b-47cf-8cd7-7b8fd178cd42" width="200">
  <img src="https://github.com/user-attachments/assets/cfed5f0e-deca-486c-ad63-3703eb87784b" width="200">
</p>
