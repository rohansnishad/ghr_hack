# 🚧 Worker Safety Monitoring System

## 📜 Problem Statement
Ensuring workers follow safety protocols in hazardous work environments is a persistent challenge. Missing essential **Personal Protective Equipment (PPE)** such as **helmets, gloves, or vests** can lead to severe accidents or injuries. 

The goal of this project is to develop a **Worker Safety Monitoring System** that uses **CCTV camera feeds** to automatically detect the absence of safety gear and **alert the safety team** when unsafe conditions are detected. This will help prevent workplace accidents by allowing quick interventions and promoting a culture of safety.

---

## 💡 Solution Overview
The **Worker Safety Monitoring System** is a mobile application built using **Flutter**. The app acts as a **control panel** for the safety team to monitor workers' safety compliance in hazardous areas. It integrates with CCTV cameras to:
- ✅ **Monitor CCTV Feeds** in real-time.
- ✅ **Detect Missing Safety Gear** like helmets, gloves, and vests using AI models.
- ✅ **Send Real-time Alerts** when unsafe conditions are detected.
- ✅ **Capture Image Snapshots** of safety violations for quick reference.
- ✅ **Generate Reports** on safety violations for further analysis.

The system aims to minimize workplace accidents by providing **immediate alerts** and **visual evidence** when safety gear violations occur.

---

## 📲 Features
### 🎥 Real-time CCTV Monitoring
- Stream **live CCTV camera feeds** from hazardous work areas.
- Automatically detect missing **helmets, gloves, and vests** using an AI model.

### ⚠️ Real-time Safety Alerts
- Send **instant alerts** to the safety team when a violation is detected.
- Include **image snapshots** and timestamps for verification.

### 📊 Safety Violation Reports
- Generate **daily, weekly, and monthly reports** of safety violations.
- Track high-risk areas and repetitive violations.



---

## 🛠 Tech Stack
| Technology     | Purpose                                         |
|----------------|-------------------------------------------------|
| **Flutter (Dart)** | Frontend mobile application                  |
| **Firebase Firestore** | Real-time database                        |
| **OpenCV / YOLOv5** | PPE detection using CCTV feed (AI model)    |
| **Firebase Cloud Messaging (FCM)** | Push notifications           |
| **Node.js (Optional)** | Custom API backend (if required)        |

---






