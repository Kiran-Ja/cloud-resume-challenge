# AWS Cloud Resume Challenge

## Project Overview
This repository contains the source code and infrastructure for my serverless Cloud Resume, deployed on AWS.

## Day 1: Local Setup & Frontend Baseline
* **Local Environment:** Initialized local Git repository and project file structure (`index.html`, `styles.css`).
* **Frontend Markup:** Drafted a clean, responsive single-page HTML resume showcasing technical skills, certifications, and project experience.
* **Dynamic Counter Placeholder:** Added a frontend `<span>` element (`#visitor-count`) prepared for downstream API Gateway and Lambda integration.
* **Version Control:** Connected local workspace to remote GitHub repository for ongoing CI/CD tracking.

## Day 2: AWS S3 Static Website Hosting
* **Bucket Provisioning:** Provisioned S3 bucket `kiran-cloud-resume-site` in Tokyo (`ap-northeast-1`).
* **Hosting Configuration:** Enabled S3 Static Website Hosting configured to serve `index.html`.
* **Access Control:** Configured public access settings and applied an anonymous `s3:GetObject` JSON policy to permit global web traffic.
* **Deployment Verification:** Successfully verified public HTTP website endpoint rendering.
EOF
