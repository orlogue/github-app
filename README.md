# GitHub App

## Purpose

A mobile application that allows users to search for GitHub profiles, view user information, browse followers, and save favorite users for quick access.

## Features Demonstration

Below are demonstrations of key app features:

| **User Search**                                                                                           | **Followers List**                                                                                        |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/user-attachments/assets/439aa4de-47c7-4d32-9f41-d0c2b3170295" width="300" /> | <img src="https://github.com/user-attachments/assets/5dd819b1-d8b0-4caa-a23c-c191b726c89d" width="300" /> |
| _Searching for users by GitHub username_                                                                  | _Browsing through a user's followers_                                                                     |

| **Favorites**                                                                                             | **Error Handling**                                                                                        |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/user-attachments/assets/41917cd4-63a7-4eac-ba68-97c9734b6809" width="300" /> | <img src="https://github.com/user-attachments/assets/ed79cd45-83e2-4e76-afe6-03d14d38f932" width="300" /> |
| _Adding and accessing your saved favorite GitHub users_                                                   | _How the app handles errors and edge cases_                                                               |

| **Empty States**                                                                                          |     |
| --------------------------------------------------------------------------------------------------------- | --- |
| <img src="https://github.com/user-attachments/assets/e4f09545-a8cc-43db-8b22-bbbc030d09e0" width="300" /> |     |
| _How the app displays empty states (no results, no favorites, etc.)_                                      |     |

## Technologies

- **Swift 5**
- **UIKit**
- **Programmatic UI** (no storyboards)
- **AutoLayout**
- **URLSession** for network requests
- **UserDefaults** for persisting favorite users
- **Codable** for JSON parsing
- **GitHub REST API**

## Architecture

- **Project Structure**: Features (Search, Followers, User, Favorites), Services, Model, Utilities, Common
- **Design Patterns**: MVC with separation of views and controllers, Delegate, Protocol-Oriented Programming, Dependency Injection
- **UI Implementation**: Custom components, UICollectionView, UITableView, Generic View Controller, UIView extension

## Requirements

- iOS 15.0+
- Xcode 12.0+
- Swift 5.0+
