# 🏭 Tethys — Smart Factory Management System

**Tethys** is an intelligent, end-to-end **factory and inventory management system** built to streamline operations in **water bottle** and **soft drink manufacturing plants**.  
The platform enhances efficiency, transparency, and productivity through real-time data handling, digital automation, and insightful analytics.

---

## 🌊 Project Overview

**Tethys** was developed as a **Major Project (July–Dec 2024)** under the **Department of Computer Science and Information Technology, AITR Indore**.  
It addresses key manufacturing challenges like **waste reduction**, **resource optimization**, and **role-based process automation**.

The name **Tethys** — inspired by the ancient Greek goddess of the sea — symbolizes **flow, balance, and continuity**, reflecting how the system keeps industrial operations synchronized and seamless.

---

## ✨ Core Features

- ⚙️ **Factory Management Dashboard** — Unified control center for admins and managers.  
- 📦 **Inventory Tracking** — Real-time material and product stock monitoring.  
- 🧾 **Role-Based Access Control (RBAC)** — Distinct dashboards for Admin, Manager, and Worker roles.  
- 📊 **Analytics & Insights** — Data-driven reports to identify inefficiencies and improve throughput.  
- 🔄 **Automated Process Sync** — Instant updates across production, storage, and dispatch modules.  
- 🧠 **Scalable Modular Design** — Clean architecture with extensible backend and responsive frontend.  
- ☁️ **Dockerized Deployment** — Ensuring stability, isolation, and easy scalability on VPS.

---

## 🛠️ Tech Stack

| Layer | Technology Used |
|-------|-----------------|
| **Frontend** | Flutter (Web + Responsive UI) |
| **Backend** | FastAPI (Python) |
| **Database** | PostgreSQL |
| **API Testing** | Postman |
| **Authentication** | JWT (JSON Web Tokens) |
| **Deployment** | Docker + VPS |
| **Version Control** | Git & GitHub |

---

## 🧩 System Architecture

```mermaid
graph TD
A[Flutter Frontend] --> B[FastAPI Backend]
B --> C[(MySQL Database)]
B --> D[Authentication Service - JWT]
B --> E[Analytics Engine]
E --> F[Reports & Insights Dashboard]
