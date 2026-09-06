cat << 'EOF' > README.md
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

## Day 3: CloudFront Distribution & HTTPS Enforcement
* **Global Distribution:** Provisioned CloudFront CDN distribution connected to S3 website endpoint origin.
* **Edge Caching:** Enabled global edge caching tailored for static S3 website assets.
* **Transport Security:** Configured viewer protocol policy to redirect HTTP traffic to HTTPS (`d25gcsywe82wnw.cloudfront.net`).

## Day 4: Custom Domain, TLS Certificate & OAC Security Lockdown
* **Custom Domain Delegation:** Delegated DNS management for `kiran-cloud.com` from GoDaddy to an AWS Route 53 Hosted Zone via custom nameservers.
* **TLS Certificate Provisioning:** Issued and validated a wildcard SSL/TLS certificate in AWS Certificate Manager (ACM `us-east-1`) using Route 53 CNAME DNS validation.
* **S3 Origin Migration & OAC Lockdown:** Switched CloudFront origin from S3 Website Endpoint to REST API endpoint (`.s3.amazonaws.com`) to support Origin Access Control (OAC), re-enabling S3 "Block all public access".
* **Edge Routing & Invalidation:** Configured `index.html` as the Default Root Object, created Route 53 Alias A-records pointing to CloudFront, and issued a global cache invalidation (`/*`) to verify custom domain HTTPS access.

## Day 5: Database Setup (DynamoDB)
* **Table Provisioning:** Created an on-demand DynamoDB table named `cloud-resume-stats` in `ap-northeast-1` with a String partition key (`id`).
* **Item Initialisation:** Seeded the initial counter item (`id = "visitors"`) with a `visitor_count` numerical attribute set to `0`.

## Day 6: Serverless Backend & IAM Least Privilege
* **Python Lambda Function:** Developed `GetVisitorCount` using Python 3.12 and Boto3 to atomically increment and retrieve the `visitor_count` attribute from DynamoDB.
* **CORS & Response Serialization:** Integrated CORS headers (`Access-Control-Allow-Origin: *`) and a custom `DecimalEncoder` class to properly serialize DynamoDB numeric types into JSON.
* **IAM Security Enforcement:** Applied an inline IAM policy adhering to the principle of least privilege, granting the Lambda execution role access exclusively to `dynamodb:UpdateItem` and `dynamodb:GetItem` operations on the target table.

## Day 7: API Gateway & CORS Integration
* **HTTP API Endpoint:** Provisioned an AWS API Gateway (HTTP API) named `cloud-resume-api` routing `GET /counter` directly to the `GetVisitorCount` Lambda function.
* **CORS Configuration:** Enforced Cross-Origin Resource Sharing (CORS) rules restricting allowed origins to `https://kiran-cloud.com` with `GET` and `OPTIONS` method permissions.
* **End-to-End Verification:** Validated public HTTP API execution via browser/cURL, confirming atomic increments in DynamoDB (`visitor_count: 2`).

## Day 8: Frontend JavaScript Integration & Full-Stack Hookup
* **Asynchronous Fetch Implementation:** Added an inline `async/await` JavaScript snippet to `index.html` targeting the API Gateway `/counter` endpoint.
* **DOM Dynamics & Error Handling:** Configured live DOM updates (`#visitor-count`) with graceful fallback error handling.
* **Global Edge Invalidation:** Re-uploaded static assets to Amazon S3 and created a CloudFront cache invalidation (`/*`) to verify full-stack atomic updates (`visitor_count: 3`).

## Day 9: Python Unit Testing & Test Automation
* **Mocking Strategy:** Implemented `unittest.mock.patch` to isolate and mock the `boto3` DynamoDB table resource without calling live AWS services.
* **Test Coverage:** Created unit tests in `pytest` covering successful atomic updates (`200 OK`) and exception handlings (`500 Internal Server Error`).
* **Assertions:** Validated HTTP response structure, CORS header integrity, Decimal-to-JSON serialization, and proper Boto3 `update_item` parameters.

## Day 10: GitHub Source Control & Repository Structuring
* **Monorepo Architecture:** Structured project into clear `/frontend` (HTML/CSS) and `/backend` (Python Lambda & Pytest suite) directories.
* **Ignored Artifacts:** Configured `.gitignore` to exclude bytecode (`__pycache__`), test caches (`.pytest_cache`), and local environment configurations.
* **Version Control:** Initialized Git, set default branch to `main`, and published the clean, tested repository to GitHub.
